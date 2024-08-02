import json
import requests
from bs4 import BeautifulSoup
import re
from datetime import datetime

titles = []
# Function to scrape a single page
def scrape_page(url):
    response = requests.get(url)
    response.raise_for_status()
    return BeautifulSoup(response.content, 'html.parser')

# Scrape main page
for i in range(1, 6):
    url = f"https://mydramalist.com/shows/top_korean_dramas?page={i}"
    soup = scrape_page(url)

    box = soup.find('div', class_="col-lg-8 col-md-8")
    container = box.find('div', class_="m-t nav-active-border b-primary")
    cards = container.findAll('div', id=re.compile(r'^mdl-\d+$'))

    # Scraping cards
    for card in cards:
        data = {
            'Drama_title': None,
            'Drama_year': None,
            'Drama_Rating': None,
            'Description': None,
            'Screenwriter': None,
            'Director': None,
            'Episodes': None,
            'Original Network': None,
            'Duration': None,
            'Watchers': None,
            'Genre': None,
            'Aired' : None,
        }

        # Title and Links
        a_tag = card.find('h6', class_="text-primary title").find('a')
        title = a_tag.text
        link = "https://mydramalist.com" + a_tag.get('href')

        info = card.find('span', class_="text-muted").text
        p_tag = card.find('span', class_="p-l-xs score")
        rating = p_tag.text
        description = p_tag.find_next('p').text

        # Append data from main page
        data['Drama_title'] = title
        data['Drama_year'] = info
        data['Drama_Rating'] = rating
        data['Description'] = description

        
        # Visit the link to get additional data
        detail_soup = scrape_page(link)

        # Extract details
        detail_list = detail_soup.find_all('li', class_="list-item p-a-0")
        for item in detail_list:
            title_tag = item.find('b', class_="inline")
            if title_tag:
                title_text = title_tag.text.replace(':', "").strip()
                if title_text in data:
                    data[title_text] = item.text.split(':', 1)[1].strip() if ':' in item.text else item.text.strip()


        # Extract genre
        genre_text = detail_soup.find('li', class_='list-item p-a-0 show-genres')
        if genre_text:
            genre_text = genre_text.text
            genres = genre_text.split(':', 1)[1].strip()
            genres = [genre.strip() for genre in genres.split(',')]
            data['Genre'] = genres

        # Append data to the list
        titles.append(data)

    print(f"Page {i} scraped successfully.")

# Convert data to JSON
json_data = json.dumps(titles, indent=4, ensure_ascii=False)

# Write JSON data to a file
with open('korean_dramas.json', 'w', encoding='utf-8') as file:
    file.write(json_data)

