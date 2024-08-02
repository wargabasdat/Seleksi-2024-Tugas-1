import requests
from bs4 import BeautifulSoup 
from abc import abstractmethod, ABC
from typing import Callable, Dict, List

class Table(ABC):
    URL: str = "https://www.mariowiki.com"
    main_page: str = "Super_Mario_Bros."

    def __init__(self):
        self.json: List[Dict] = []

    def drop_if_exist(self):
        cursor = Table.cursor
        class_name = self.__class__.__name__ # get class name that inherits this class
        cursor.execute("DROP TABLE IF EXISTS " + class_name)

    def get_soup() -> BeautifulSoup:
        print("Web scraping from", Table.URL+"/"+Table.main_page)
        r = requests.get(Table.URL+"/"+Table.main_page)
        print("Status: "+ str(r.status_code))
        return BeautifulSoup(r.content, 'html5lib')

    @abstractmethod
    def process_soup(self, soup):
        pass
    
    def scrape(self, soup: BeautifulSoup) -> Dict:
        self.process_soup(soup)
        return self.json

    def clean_description(self, description: str) -> str:
        return description.strip()
    
    def extract_image(img) -> Dict:
        name = img["alt"]
        url = img["src"]
        width = img["width"]
        height = img["height"]
        width = int(width) if width is not None else None
        height = int(height) if height is not None else None
        return {
            "name": name,
            "url": url,
            "width": width,
            "height": height
        }


    def find_and_process_td(self, id: str, soup: BeautifulSoup, on_td_parsed: Callable[[BeautifulSoup], None]) -> Dict:
        try:
            span = soup.find("span", attrs={"id": id})
            table = span.parent.findNext("table").children

            for tBody in table: # only 1 element
                for tr in tBody:
                    try:
                        td = tr.find_all("td")
                        on_td_parsed(td)
                    except Exception as e:
                        pass
        except Exception as e:
            # print("Error in find_and_process_td for id", id)
            # print(e)
            pass