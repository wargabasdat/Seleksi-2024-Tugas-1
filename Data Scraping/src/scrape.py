import requests
from bs4 import BeautifulSoup
import json

hero_data = []
item_data = []

base_path = "../data"

headers = {'User-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0'}


def get_hero_title(soup):
    title = {}
    header_div = soup.find('div', class_='header-content-title')
    header_second = soup.find('div', class_='header-content-secondary')
    header_image = soup.find('div', class_='header-content-avatar')
    if header_div:
        
        hero_name = header_div.find('h1').contents[0]
        
        
        hero_category = header_div.find('small').text
        
        title['hero_name'] = hero_name
        title['hero_category'] = hero_category

    if header_second:
        won_span = header_second.find('span', class_='won')
        lost_span = header_second.find('span', class_='lost')
        
        if won_span:
            hero_win_rate = won_span.text
            title['hero_win_rate'] = hero_win_rate
        elif lost_span:
            hero_win_rate = lost_span.text
            title['hero_win_rate'] = hero_win_rate
            
        
    
    if header_image:
        hero_image = header_image.find('img')['src']
        hero_image = 'https://www.dotabuff.com' + hero_image
        title['hero_image'] = hero_image

    return title

def get_hero_facets(soup):
    facets = {}
    src = soup.find_all('img', src=lambda x: x and x.startswith('/assets/facet_icons'))
    i = 1
    for img in src:
        facets['facet' + str(i)] = img['alt']
        i += 1
    return facets


def get_hero_attributes(soup):
    attributes = {}
    
    
    section = soup.find('section', class_='hero_attributes')

    primary_table = section.find('table', class_='main')
    if primary_table:
        primary_rows = primary_table.find_all('tr')
        if len(primary_rows) > 1:
            primary_values = primary_rows[1].find_all('td')
            attributes['strength'] = primary_values[0].text.strip()
            attributes['agility'] = primary_values[1].text.strip()
            attributes['intelligence'] = primary_values[2].text.strip()
    
    
    other_table = soup.find('table', class_='other')
    if other_table:
        other_rows = other_table.find_all('tr')
        for row in other_rows:
            cols = row.find_all('td')
            if len(cols) == 2:
                key = cols[0].text.strip().lower().replace(' ', '_')
                value = cols[1].text.strip()
                attributes[key] = value
    
    return attributes
    
def get_item_tooltip(soup):
    tooltip = {}
    tooltip_div = soup.find('div', class_='tooltip-header')
    if tooltip_div:
        tooltip['name'] = tooltip_div.find('div', class_='name').text
        price_div = tooltip_div.find('div', class_='price')
        if price_div:
            price_span = price_div.find('span', class_='number')
            if price_span:
                tooltip['price'] = price_span.text
            else:
                tooltip['price'] = '0'
        else:
            tooltip['price'] = '0'
        item_image = tooltip_div.find('img')['src']
        item_image = 'https://www.dotabuff.com' + item_image
        tooltip['item_image'] = item_image
    
    return tooltip

def get_item_lore(soup):
    lore = {}
    lore_div = soup.find('div', class_='lore')
    if lore_div:
        lore['lore'] = lore_div.text

    return lore

def get_item_build(soup):
    build = {'build' : []}
    build_div = soup.find('div', class_='item-build item-builds-from')
    if build_div:
        items = build_div.find_all('div', class_='item')
        for item in items:
            name = item.find('img').get('alt')
            build['build'].append(name)
    return build



def get_hero_items(soup):
    items = {"items" : []}
    content_div = soup.find('div', class_='content-inner')
    tbody = content_div.find('tbody')
    rows = tbody.find_all('tr')
    for row in rows:
        item_data = {}
        td = row.find_all('td')
        item_data['name'] = td[1].text
        item_data['matches_played'] = td[2].text
        item_data['win_rate'] = td[3].text

        items['items'].append(item_data)

    return items



def get_hero_counters(soup):
    counters = {"counters" : []}
    header = soup.find('header', text='Matchups')

    if header:
        section = header.find_parent('section')
        tbody = section.find('tbody')
        rows = tbody.find_all('tr')
        for row in rows:
            counter_data = {}
            td = row.find_all('td')
            counter_data['hero'] = td[1].text
            counter_data['disadvantage'] = td[2].text
            counter_data['win_rate'] = td[3].text
            counter_data['match_played'] = td[4].text
            counters['counters'].append(counter_data)
    
    return counters

def get_hero_talents(soup):
    talents = {'talents': []}
    section = soup.find('section', class_='hero-talents')
    if section:
        tbody = section.find('tbody')
        rows = tbody.find_all('tr')
        for row in rows:
            td = row.find_all('td')
        
            talents['talents'].append({
                "level": td[1].text,
                "left": td[0].text,
                "right": td[2].text
            })
    return talents

def get_hero_abilities(soup):
    abilities = {'abilities': []}
    inner_div = soup.find('div', class_='content-inner')
    abilities_div = inner_div.find('div', class_='col-8')
    sections = abilities_div.find_all('section')

    for section in sections:
        ability = {}
        header = section.find('header')
        if header:
            for big in header.find_all('big'):
                big.decompose()
            ability['name'] = header.get_text(strip=True)
        img = section.find('img')['src']
        if img:
            img = 'https://www.dotabuff.com' + img
            ability['image'] = img
        desc_div = section.find('div', class_='description')

        if desc_div:
            ability['description'] = desc_div.get_text(separator='')
        notes_div = section.find('div', class_='notes')
        if notes_div:
            ability['notes'] = notes_div.get_text(separator='' )
        lore_div = section.find('div', class_='lore')
        if lore_div:
            ability['lore'] = lore_div.get_text(separator='')

        abilities['abilities'].append(ability)

    return abilities


def scrape_item(url):

    result = {}
    response = requests.get(url,headers = headers)
    
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        tooltip = get_item_tooltip(soup)
        lore = get_item_lore(soup)
        build = get_item_build(soup)

        result.update(tooltip)
        result.update(lore)
        result.update(build)

    item_data.append(result)

    # return result

def scrape_hero(url):
    
    result = {}
    response = requests.get(url,headers = headers)
    
    

    if response.status_code == 200:
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        title = get_hero_title(soup)
        attributes = get_hero_attributes(soup)
        facets = get_hero_facets(soup)
        
        result.update(title)
        result.update(attributes)
        result.update(facets)




    url_hero_items = url + "/items"
    response = requests.get(url_hero_items,headers = headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        heroItems = get_hero_items(soup)
        result.update(heroItems)


    url_hero_counters = url + "/counters"
    response = requests.get(url_hero_counters,headers = headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        heroCounters = get_hero_counters(soup)
        result.update(heroCounters)
 

    url_hero_abilities = url + "/abilities"
    response = requests.get(url_hero_abilities,headers = headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        hero_talents = get_hero_talents(soup)
        result.update(hero_talents)

        hero_abilities = get_hero_abilities(soup)
        result.update(hero_abilities)
 


    hero_data.append(result)
 

    return result



def scrape_heroes():
    url = "https://www.dotabuff.com/heroes?show=heroes&view=meta&mode=all-pick&date=7d"
    response = requests.get(url,headers = headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        content = soup.find('div', class_='content-inner')
        tbody = content.find('tbody', class_='[&_tr:last-child]:tw-border-0')
        rows = tbody.find_all('tr')
        for row in (rows):
            td = row.find_all('td')
            link = td[0].find('a')['href']
            print(link)
            hero_url = 'https://www.dotabuff.com' + link
            scrape_hero(hero_url)
        
        with open(f'{base_path}/heroes.json', 'w') as json_file:
            json.dump(hero_data, json_file, indent=4)



def scrape_items():
    url = 'https://www.dotabuff.com/items/impact'
    response = requests.get(url,headers = headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        content = soup.find('div', class_='content-inner')
        tbody = content.find('tbody')
        rows = tbody.find_all('tr')
        for row in (rows):
            td = row.find_all('td')
            link = td[0].find('a')['href']
            print(link)
            item_url = 'https://www.dotabuff.com' + link
            scrape_item(item_url)
        
        with open(f'{base_path}/items.json', 'w') as json_file:
            json.dump(item_data, json_file, indent=4)


scrape_heroes()
scrape_items()


