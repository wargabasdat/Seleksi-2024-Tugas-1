import requests
import json
from concurrent.futures import ThreadPoolExecutor
from bs4 import BeautifulSoup

# labels that don't need further processing
labels = {
    "Title:" : "title",
    "Date:" : "date",
    "Geography:" : "geography",
    "Culture:" : "culture",
    "Medium:" : "medium",
    "Accession Number:" : "accnum",
}

# labels that are excluded from the database
exclude = {
    "Period:" : True, "Dynasty:" : True, "Dimensions:" : True,
    "Reign:" : True,"Series/Portfolio:" : True,
    "Former Attribution:" : True, "Edition:" : True,
}

# setup
header = {'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0)'}
baseURL = "https://www.metmuseum.org/art/collection/search"
pageURL = baseURL + "?showOnly=highlights&sortBy=Date&offset="
offset = 0

artworks = []

def pageRequest(url: str):
    # returns the object grid within a page
    text = requests.get(url, headers=header)
    soup = BeautifulSoup(text.content, 'html.parser')
    return soup.find('section', class_='object-grid_grid__hKKqs')

def creditData(value: str):
    # process credit line data
    # return the name of the credit for the artwork and the year it was acquired
    # delete prefix in the string
    for prefix in ['Purchase,', 'Bequest of', 'Gift of']:
        idx = value.find(prefix)
        if idx != -1:
            idx += len(prefix) + 1
            value = value[idx:]
            break
    
    year = ""
    # separate the year and the name
    if value[-4:].isdigit():
        year = int(value[-4:])
        value = value[:-6]
    
    return value, year

def constituentData(label: str, value: str):
    # process constituent data
    # return the name of the constituent and their role
    data = dict(name=None, role=label[:-1])

    if "Unidentified" in value or "Unknown" in value:
        data.update(name="Unknown")
    else:
        # delete the trailing info on the constituent
        if value[0] == "(":
            idx = value.find(")") + 2
            value = value[idx:]
        if "(" in value:
            idx = value.find("(") - 1
            value = value[:idx]
        # delete the prefix in the string
        for prefix in ['by', 'possibly', 'probably', 'attributed to']:
            idx = value.lower().find(prefix)
            if idx != -1:
                idx += len(prefix) + 1
                value = value[idx:]
                break
        
        data.update(name=value)

    return data

def artworkData(link: str):
    # request the page of an artwork
    id = link.get('href')[26:]
    text = requests.get(baseURL + "/" + id, headers=header)
    soup = BeautifulSoup(text.content, 'html.parser') 
    id = int(id)

    # setup the data to be collected
    data = dict(id=id, title=None, gallery=None, date=None, geography=None, culture=None, medium=None,
                accnum=None, credit=None, year=None, classifications=[], constituents=[])

    # get the gallery number of an artwork if it is on view
    location = soup.find('span', class_='artwork__location--gallery')
    if location is not None:
        gallery = location.get_text(strip=True)[8:]
        if gallery.isdigit():
            data.update(gallery=int(gallery))
    
    # get the overview data for the artwork
    items = soup.find('section', id='overview').find_all('p', class_='artwork-tombstone--item')
    for item in items:
        label = item.find('span', class_='artwork-tombstone--label')
        # process item according to the label
        if label is not None:
            label = label.get_text(strip=True)
            value = item.find('span', class_='artwork-tombstone--value').get_text(strip=True)

            if label in labels: # labels that do not need further processing
                data[labels[label]] = value
            elif label == "Credit Line:": # credit line label
                data["credit"], data["year"] = creditData(value)
            elif label == "Classification:" or label == "Classifications": # classification label
                data["classifications"] += value.split(', ')
            elif label not in exclude: # every other label not excluded contains constituent data
                data["constituents"].append(constituentData(label, value))

    artworks.append(data)

page = pageRequest(pageURL + str(offset))

# scrape pages until there is none left
while page is not None:
    print(f"Scraping page {offset//40 + 1}")

    # use multithreading to go through all links on a page
    links = page.find_all('a', class_='collection-object_link__qM3YR')
    with ThreadPoolExecutor(max_workers=40) as executor:
        executor.map(artworkData, links)
    
    # go to next page
    offset += 40
    page = pageRequest(pageURL + str(offset))

# write data to json file
data = dict(artworks=artworks)
json_object = json.dumps(data, indent=4)
with open('Data Scraping/data/data.json', 'w') as f:
    f.write(json_object)