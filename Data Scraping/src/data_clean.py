import json
import re
from datetime import datetime

# Function to convert duration to minutes
def convert_duration_to_minutes(duration):
    if isinstance(duration, int):
        return duration
    hours_match = re.search(r'(\d+)\s*hr', duration)
    minutes_match = re.search(r'(\d+)\s*min', duration)
    hours = int(hours_match.group(1)) if hours_match else 0
    minutes = int(minutes_match.group(1)) if minutes_match else 0
    return hours * 60 + minutes

# Function to convert watchers to an integer
def convert_watchers_to_int(watchers):
    return int(str(watchers).replace(',', ''))

# Function to extract release year
def extract_year(info):
    match = re.search(r'(\d{4})', str(info))
    return int(match.group(1)) if match else 'unknown'

# Function to extract start and end date
def extract_date(aired):
    date_format = "%b %d, %Y"
    if " - " in aired:
        start_date_str, end_date_str = aired.split(" - ")
        start_date = datetime.strptime(start_date_str.strip(), date_format)
        end_date = datetime.strptime(end_date_str.strip(), date_format)
    else:
        start_date = end_date = datetime.strptime(aired.strip(), date_format)
    
    formatted_start_date = start_date.strftime("%Y-%m-%d")
    formatted_end_date = end_date.strftime("%Y-%m-%d")
    return formatted_start_date, formatted_end_date   

def clean_data(data):
    # Replace None values with 'unknown'
    for key, value in data.items():
        if value is None:
            data[key] = 'unknown'
    
    # Clean Director
    if 'Director' in data and data['Director'] != 'unknown':
        data['Director'] = [director.strip() for director in data['Director'].split(",")]
    
    # Clean Screenwriter
    if 'Screenwriter' in data and data['Screenwriter'] != 'unknown':
        data['Screenwriter'] = [screenwriter.strip() for screenwriter in data['Screenwriter'].split(",")]
    
    # Clean Original Network
    if 'Original Network' in data and data['Original Network'] != 'unknown':
        data['Original_Network'] = [network.strip() for network in data['Original Network'].split(",")]
        del data['Original Network']
    
    # Clean year
    if 'Drama_year' in data and data['Drama_year'] != 'unknown':
        data['Drama_year'] = extract_year(data['Drama_year'])
    
    # Clean duration
    if 'Duration' in data and data['Duration'] != 'unknown':
        data['Duration'] = convert_duration_to_minutes(data['Duration'])
    
    # Clean watchers
    if 'Watchers' in data and data['Watchers'] != 'unknown':
        data['Watchers'] = convert_watchers_to_int(data['Watchers'])
    
    # Clean date
    if 'Aired' in data and data['Aired'] != 'unknown':
        dates = extract_date(data['Aired'])
        data['Start_date'] = dates[0]
        data['End_date'] = dates[1]
        del data['Aired']
    
    # Clean episodes
    if 'Episodes' in data and data['Episodes'] != 'unknown':
        data['Episodes'] = int(data['Episodes'])
    
    # Clean rating
    if 'Drama_Rating' in data and data['Drama_Rating'] != 'unknown':
        data['Drama_Rating'] = float(data['Drama_Rating'])
    

    # Replace None values with 'unknown'
    for key, value in data.items():
        if value == 'unknown':
            data[key] = ['unknown']
    return data

# Load JSON data
with open('korean_dramas.json', 'r', encoding='utf-8') as file:
    dramas = json.load(file)

# Clean each drama in the list
cleaned_dramas = [clean_data(drama) for drama in dramas]

# Write cleaned data to a new JSON file
with open('cleaned_korean_dramas.json', 'w', encoding='utf-8') as file:
    json.dump(cleaned_dramas, file, indent=4)

print("Cleaned data has been written to 'cleaned_korean_dramas.json'")
