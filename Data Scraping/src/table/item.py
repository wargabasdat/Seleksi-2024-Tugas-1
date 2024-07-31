from table.table import Table
from bs4 import BeautifulSoup 
from typing import List, Dict

class item(Table):
    def items(self, td):
        name_a = td[1].find("a")
        name = name_a.text
        description = td[2].text
        image = Table.extract_image(td[0].find("img"))
        detail_url = name_a["href"]

        if name == "1 up mushroom":
            name = "1 up Mushroom"

        self.json.append({
            "name": name,
            "description": self.clean_description(description),
            "image": image,
            "detail_url": Table.URL+detail_url,
        })

    def process_soup(self, soup: BeautifulSoup):
        self.find_and_process_td("Items", soup, self.items)
        