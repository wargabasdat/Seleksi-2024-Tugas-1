from table.table import Table
from bs4 import BeautifulSoup 
from typing import List

class object(Table):

    def process_objects(self, soup: BeautifulSoup):
        span = soup.find("span", attrs={"id": "Objects"})
        table = span.parent.findNext("table").children

        for tBody in table: # only 1 element
            type = ""
            for tr in tBody:
                try:
                    th = tr.find_all("th")
                    if len(th) > 0:
                        type = self.clean_description(th[0].text)
                        continue

                    td = tr.find_all("td")
                    name_a = td[1].find("a")
                    name = name_a.text
                    description = td[2].text
                    image = Table.extract_image(td[0].find("img"))
                    detail_url = Table.URL + name_a["href"]

                    self.json.append({
                        "name": name,
                        "description": self.clean_description(description),
                        "image": image,
                        "detail_url": detail_url,
                        "type": type
                    })

                except Exception as e:
                    pass


    def process_soup(self, soup: BeautifulSoup):
        self.process_objects(soup)