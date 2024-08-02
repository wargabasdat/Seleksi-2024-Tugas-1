import json
import datetime
from scraper import scrape_player_data

class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        return super(DateTimeEncoder, self).default(obj)

def main():
    data = scrape_player_data()
        
    filename = 'data.json'

    with open(filename, 'w') as file:
        json.dump(data, file, indent=4, cls=DateTimeEncoder)

    print(f"Data has been written to {filename}")



if __name__ == "__main__":
    main()