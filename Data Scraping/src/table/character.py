from table.table import Table
from bs4 import BeautifulSoup 
from typing import List, Dict

class character(Table):

    def process_playable_characters(self, soup: BeautifulSoup):
        span = soup.find("span", attrs={"id": "Playable_characters"})
        table = span.parent.findNext("table").children

        for tBody in table: # only 1 element
            description = None
            for tr in tBody:
                try:
                    td = tr.find_all("td")
                    name_a = td[1].find("a")
                    
                    name = name_a.text

                    if description is None: description = td[2].text
                    image = Table.extract_image(td[0].find("img"))
                    detail_url = name_a["href"]
                    
                    self.json["pc"].append({
                        "name": name,
                        "description": self.clean_description(description),
                        "image": image,
                        "detail_url": Table.URL+detail_url,
                    })
                except Exception as e:
                    pass

    def enemies(self, td):
        name_a = td[1].find("a")
        name = name_a.text
        description = td[2].text
        image = Table.extract_image(td[0].find("img"))
        detail_url = name_a["href"]
        pts = int(td[5].text)
        self.json["enemy"].append({
            "name": name,
            "description": self.clean_description(description),
            "image": image,
            "detail_url": Table.URL+detail_url,
            "points": pts,
        })

    def non_playable_characters(self, td):
        name_a = td[1].find("a")
        name = name_a.text
        description = td[2].text
        image = Table.extract_image(td[0].find("img"))
        detail_url = name_a["href"]
        self.json["npc"].append({
            "name": name,
            "description": self.clean_description(description),
            "image": image,
            "detail_url": Table.URL+detail_url,
        })

    def process_soup(self, soup: BeautifulSoup):
        self.json = {
            "pc": [],
            "npc": [],
            "enemy": []
        }
        self.process_playable_characters(soup)
        self.find_and_process_td("Non-playable_characters", soup, self.non_playable_characters)
        self.find_and_process_td("Enemies", soup, self.enemies)
        
