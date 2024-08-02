import requests
import time
import os
import json
from bs4 import BeautifulSoup
from cleaner import *

def scrape_and_clean_review(url: str, airline: str):
    """
    Scrape review from a page of a given url
    """
    content = requests.get(url).content
    soup = BeautifulSoup(content, "html.parser")
    reviews = soup.find_all('article', attrs={'itemprop':'review'})

    review_list = []
    airline_name = convert_airline_name(airline)
    try:
       airline_star = int(soup.find('img', attrs={'class': 'skytrax-rating'})['alt'].split()[0])
    except:
        airline_star = 0

    for review in reviews:
        review_dict = {
            'Reviewer': {
                'Name': None,
                'Country': None,
                'Type': None
            },
            'Flight': {
                'Route': None,
                'Aircraft': None,
                'Date Flown': None,
            },
            'Airline': {
                'Name': airline_name,
                'Star': airline_star,
            },
            'Review Details': {
                'Review Text': None,
                'Review Date': None,
                'Overall Rating': 0,
                'Type Of Traveller': None,
                'Seat Type': None,
                'Seat Comfort': 0,
                'Cabin Staff Service': 0,
                'Food & Beverages': 0,
                'Inflight Entertainment': 0,
                'Ground Service': 0,
                'Wifi & Connectivity': 0,
                'Value For Money': 0,
                'Recommended': None
            }
        }
        try:
            review_dict['Review Details']['Review Date'] = review.find("meta").get("content")
            review_dict['Review Details']['Overall Rating'] = int(review.find('span', attrs={'itemprop':'ratingValue'}).get_text())
            review_dict['Review Details']['Review Text'] = review.find('h2', attrs={'class':'text_header'}).get_text().strip('"').strip('“').strip('”')
        except:
            pass

        table = review.find("table", { "class": "review-ratings" })
        data = table.find_all("td")
        keys = data[::2]
        values = data[1::2]
        for key, value in zip(keys, values):
            key = key.get_text()
            star_value = None
            try:
                star_value = value.find_all("span", { "class": "star fill" })[-1]
            except:
                pass
            if star_value:
                value = int(star_value.get_text())
            else:
                try:
                    value = value.get_text()
                    if value == 'N/A':
                        value = None
                except:
                    pass

            if key in ['Route','Date Flown','Aircraft']:
                review_dict['Flight'][key] = value
            elif key == 'Recommended':
                review_dict['Review Details'][key] = categorical_to_bool(value)
            else:   
                review_dict['Review Details'][key] = value
        
        # Scrape for reviewer data
        review_dict['Reviewer']['Name'] = review.find('span', attrs={'itemprop':'name'}).get_text()
        review_dict['Reviewer']['Country'] = review.find('h3', attrs={'class':'text_sub_header userStatusWrapper'}).get_text().split('(')[1].split(')')[0]
        user_status = review.find('a', attrs={'class': 'userStatus'})
        if user_status:
            review_dict['Reviewer']['Type'] = user_status['class'][1]  
        else:
            review_dict['Reviewer']['Type'] = 'nonmember'

        review_list.append(review_dict)
    
    return review_list

def scrape_airline_reviews(airline_name: list, pagesize: int = 100):
    """
    Scrape all review from an airline
    """
    reviews_list = []
    review_scraped = 0
    try_count = 0
    current_page = 1
    
    # while max_reviews > review_scraped and try_count < 2:
    while try_count < 2:
        try:
            print(f"Scraping page {current_page} for {airline_name}")
            url = f"https://www.airlinequality.com/airline-reviews/{airline_name}/page/{current_page}/?pagesize={pagesize}"
            reviews = scrape_and_clean_review(url, airline_name)
            if reviews:
                reviews_list.extend(reviews)
                review_scraped += len(reviews)
                try_count = 0 
            else:
                print(f"No reviews found on page {current_page}")
                try_count += 1  
            current_page += 1 # Scrap next page
        except Exception as e:
            try_count += 1
        time.sleep(0.5)

    return reviews_list

def save_to_json(all_reviews):
    if not all_reviews:
        return
    cwd = os.getcwd()
    with open(cwd[:-3] +"data/airline_reviews.json", "w") as f:
        json.dump(all_reviews, f, indent=4)