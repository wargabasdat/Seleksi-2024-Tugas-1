import asyncio
import aiohttp
from bs4 import BeautifulSoup
import pandas as pd

BASE_URL = 'https://companiesmarketcap.com'

companies = []
stocks = []
performances = []
countries = set()
categories = set()
stock_categories = []

async def fetch(url, session):
    try:
        async with session.get(url) as response:
            return await response.text()
    except Exception as e:
        print(f"Failed to fetch {url}: {e}")
        return None

async def scrape_performance(session, revenue_link, earning_link, company_name):
    global performances

    try:
        html_content_revenue = await fetch(revenue_link, session)
        html_content_earning = await fetch(earning_link, session)

        if html_content_revenue is None or html_content_earning is None:
            return

        soup_revenue = BeautifulSoup(html_content_revenue, 'html.parser')
        soup_earning = BeautifulSoup(html_content_earning, 'html.parser')

        revenue_rows = soup_revenue.select_one('table.table').select('tr')[1:]
        earning_rows = soup_earning.select_one('table.table').select('tr')[1:]

        for i in range(min(len(revenue_rows), len(earning_rows))):
            year = revenue_rows[i].select_one('span.year').text
            revenue = revenue_rows[i].select('td')[1].text.replace('$', '').strip()
            satuan = revenue[-1]
            revenue = revenue[:-1]

            # Check if revenue is negative

            if revenue[0] == '-':
                revenue = float(revenue[1:]) * -1
            else:
                revenue = float(revenue)

            # Check if revenue is in million
            if satuan == 'M':
                revenue /= 1000

            earning = earning_rows[i].select('td')[1].text.replace('$', '').strip()
            satuan = earning[-1]
            earning = earning[:-1]


            # Check if earning is negative
            if earning[0] == '-':
                earning = float(earning[1:]) * -1
            else:
                earning = float(earning)

            # Check if earning is in million
            if satuan == 'M':
                earning /= 1000

            performances.append({'company_name': company_name, 'year': year, 'revenue': revenue, 'earning': earning})

    except Exception as e:
        print(f"Failed to scrape performance for {company_name} (Revenue: {revenue_link}, Earnings: {earning_link}): {e}")

# Procedure to scrape categories, and store them in the global variables categories and stock_categories
def scrape_categories(categories_list, stock_code):
    global categories, stock_categories
    try:
        for category in categories_list:
            parsed = category.text
            categories.add(parsed)
            stock_categories.append({'stock_code': stock_code, 'category_name': parsed }) 

    except Exception as e:
        print(f"Failed to scrape categories for {stock_code}: {e}")

async def scrape_general_info(session, company, code, url):
    global countries, stocks
    name = company['company_name']

    try:
        print(f"Scraping {url}")
        html_content = await fetch(BASE_URL + url, session)
        
        if html_content is None:
            return

        soup = BeautifulSoup(html_content, 'html.parser')

        information = soup.select('div.line1')

        current_price = float(information[3].text[1:].replace(',', ''))
        market_cap = information[1].text.split(' ')[0]
        market_cap = market_cap.replace('$', '')

        # parse if in trillion
        if market_cap[-1] == 'T':
            market_cap = float(market_cap[:-1]) * 1000
        else:
            market_cap = float(market_cap)
        

        description = soup.select_one('div.company-description')


        if description is None:
            description = "No description available"
        else:
            description = description.select_one('p')
            if description is None:
                description = soup.select_one('div.company-description')
                if description is None:
                    description = "No description available"
                else:
                    description = description.text
            else:
                description = description.text

        
        categorie_list = soup.select('div.line1')[6].select('a')
        country = soup.select_one('span.responsive-hidden').text

        revenue_url = soup.find('a', string='Revenue')
        earning_url = soup.find('a', string='Earnings')
        if revenue_url:
            revenue_url = BASE_URL + revenue_url.get('href')
        if earning_url:
            earning_url = BASE_URL + earning_url.get('href')
        if revenue_url and earning_url:
            await scrape_performance(session, revenue_url, earning_url, company['company_name'])

        stocks.append({'stock_code': code, 'current_price': current_price, 'current_marketcap': market_cap, 'company_name': company['company_name']})
        company['description'] = description
        company['country_name'] = country
        countries.add(country)

        scrape_categories(categorie_list, code)

        print(f"Scraped general info for {name}")

    except Exception as e:
        print(f"Failed to scrape general info for {name} ({url}): {e}")

async def scrape_companies():
    global companies, countries, categories, stocks, stock_categories, performances

    async with aiohttp.ClientSession() as session:
        html_content = await fetch(BASE_URL, session)
        soup = BeautifulSoup(html_content, 'html.parser')

        # Get the table
        table = soup.select_one('table.default-table.table.marketcap-table.dataTable')

        if table:
            rows = table.select('div.name-div')
            tasks = []
            for row in rows:
                # Url for company detail
                url = row.select_one('a').get('href')
                company = {}
                company['company_name'] = row.select_one('div.company-name').text
                code = row.select_one('div.company-code').text
                print(f"Scraping {company['company_name']}")

                # Scrape general info
                task = scrape_general_info(session, company, code, url)
                tasks.append(task)
                companies.append(company)

            await asyncio.gather(*tasks)

        df = pd.DataFrame(companies)
        df.to_json('Data Scraping/data/companies.json', orient='records')
        df = pd.DataFrame(performances)
        df.to_json('Data Scraping/data/performances.json', orient='records')
        df = pd.DataFrame(list(countries), columns=['country_name'])
        df.to_json('Data Scraping/data/countries.json', orient='records')
        temp = list(categories)
        for i in range(len(temp)):
            temp[i] = {'category_name': temp[i], 'category_description' : f"Description for {temp[i]}"}
        categories = temp
        df = pd.DataFrame(categories)
        df.to_json('Data Scraping/data/categories.json', orient='records')
        df = pd.DataFrame(stocks)
        df.to_json('Data Scraping/data/stocks.json', orient='records')
        df = pd.DataFrame(stock_categories)
        df.to_json('Data Scraping/data/stock_categories.json', orient='records')
        print ("Scraping completed")

asyncio.run(scrape_companies())
