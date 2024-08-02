from table.table import Table
from bs4 import BeautifulSoup 
from typing import List

class version(Table):

    def process_soup(self, soup: BeautifulSoup):
        span = soup.find("span", attrs={"id": "Alternate_versions_and_re-releases"})
        ul = span.parent.findNext("ul").children
        for li in ul:
            try:
                full_text = li.text.strip()

                year = full_text[:4]
                description = full_text[7:]

                if year == "": continue

                self.json.append({
                    "year": year,
                    "description": description
                })

            except:
                pass
