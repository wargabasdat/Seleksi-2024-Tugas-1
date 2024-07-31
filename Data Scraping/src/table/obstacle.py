from table.table import Table
from bs4 import BeautifulSoup 
from typing import List, Dict

class obstacle(Table):

    def obstacles(self, td):
        name_a = td[1].find("a")
        name = name_a.text
        description = td[2].text
        image = Table.extract_image(td[0].find("img"))
        detail_url = name_a["href"]
        self.json.append({
            "name": name,
            "description": self.clean_description(description),
            "image": image,
            "detail_url": Table.URL+detail_url,
        })

    def process_soup(self, soup: BeautifulSoup) -> Dict:
        self.find_and_process_td("Obstacles", soup, self.obstacles)
        