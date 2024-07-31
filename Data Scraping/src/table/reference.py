from table.table import Table
from bs4 import BeautifulSoup 
from typing import List

class reference(Table):

    def process_soup(self, soup: BeautifulSoup):
        self.process(soup, "References_to_other_games", "to_other_games")
        self.process(soup, "References_in_other_games", "in_other_games")
        self.process(soup, "References_in_later_games", "in_later_games")

    def process(self, soup: BeautifulSoup, id: str, type: str):
        span = soup.find("span", attrs={"id": id})
        ul = span.parent.findNext("ul").children
        for li in ul:
            try:
                full_text = li.text
                a = li.find_all("a")
                a_description = a[0].text
                description = full_text.replace(a_description, "").strip()
                description = description.strip().replace("\n", " ") # clean
                description = description[description.rfind(":") + 1:] # remove everything until last ':'
                description = description.strip()

                detail_url = Table.URL + a[0]["href"]
                self.json.append({
                    "name": a_description,
                    "description": description,
                    "detail_url": detail_url,
                    "type": type
                })
            except:
                pass
    
