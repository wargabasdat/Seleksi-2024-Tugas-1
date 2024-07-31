from table.table import Table
from bs4 import BeautifulSoup 
from typing import List, Dict
import requests
import asyncio
import aiohttp

class level(Table):

    def process_objects(self, soup: BeautifulSoup):
        span = soup.find("span", attrs={"id": "List_of_levels"})
        table = span.parent.findNext("table").children

        for tBody in table: # only 1 element
            image = ""
            for tr in tBody:
                try:
                    td = tr.find_all("td")
                    img = td[0].find_all("img")

                    start_idx = 0
                    if len(img) > 0:
                        image = Table.extract_image(img[0])
                        start_idx = 1

                    name_a = td[start_idx+0].find_all("a")
                    name = name_a[0].text
                    detail_url = Table.URL + name_a[0]["href"]
                    setting = td[start_idx+1].text.strip()                 

                    self.json.append({
                        "name": name,
                        "image": image,
                        "detail_url": detail_url,
                        "setting": setting,
                        "course_map_image": "",
                        "item": []
                    })                    

                except Exception as e:
                    pass

    
    async def get_detail_soup(self, url: str) -> BeautifulSoup:
        print("Web scraping level detail from", url)
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                content = await response.read()
                soup = BeautifulSoup(content, "html5lib")
                return soup
            
    async def populate_detail(self):
        print("Populating level details...")
        soups: List[BeautifulSoup] = await asyncio.gather(*[self.get_detail_soup(level["detail_url"]) for level in self.json])
        for i in range(len(soups)):
            self.find_and_process_td("Enemies", soups[i], lambda td, i=i: self.enemies(td, i))
            self.find_and_process_td("Enemies_and_obstacles", soups[i], lambda td, i=i: self.enemies_and_obstacle(td, i))
            self.find_and_process_td("Items", soups[i], lambda td, i=i: self.items(td, i))
            self.course_map(soups[i], i)
        print("Populated level details.")

    def enemies_and_obstacle(self, td, idx):
        try:
            name_a = td[1].find_all("a")
            for a in name_a:
                name = a.text
                count = self.clean_description(td[2].text)
                detail_url = a["href"]

                if self.json[idx].get("enemies_and_obstacle") is None:
                    self.json[idx]["enemies_and_obstacle"] = []
                self.json[idx]["enemies_and_obstacle"].append({
                    "name": name,
                    "count": self.convert_count(count),
                    "detail_url": Table.URL+detail_url,
                })
        except Exception as e:
            # print("Error scraping enemies for idx", idx)
            # print(e)
            pass

    def enemies(self, td, idx):
        try:
            name_a = td[1].find_all("a")
            for a in name_a:
                name = a.text
                count = self.clean_description(td[2].text)
                detail_url = a["href"]

                if self.json[idx].get("enemies") is None:
                    self.json[idx]["enemies"] = []
                self.json[idx]["enemies"].append({
                    "name": name,
                    "count": self.convert_count(count),
                    "detail_url": Table.URL+detail_url,
                })
        except Exception as e:
            # print("Error scraping enemies for idx", idx)
            # print(e)
            pass

    def items(self, td, idx):
        try:
            name_a = td[1].find_all("a")
            for a in name_a:
                name = a.text
                count = self.clean_description(td[2].text)
                detail_url = a["href"]
                description = self.clean_description(td[3].text)

                if self.json[idx].get("item") is None:
                    self.json[idx]["item"] = []

                self.json[idx]["item"].append({
                    "name": name,
                    "count": self.convert_count(count),
                    "detail_url": Table.URL+detail_url,
                    "description": description
                })
        except Exception as e:
            # print("Error scraping item for idx", idx)
            # print(e)
            pass

    def course_map(self, soup, idx):
        try:
            span = None
            span = soup.find("span", attrs={"id": "Level_map"})
            if span is None:
                span = soup.find("span", attrs={"id": "Level_maps"})
            if span is None:
                span = soup.find("span", attrs={"id": "Course_map"})
            if span is None:
                span = soup.find("span", attrs={"id": "Map"})


            div = span.parent.findNext("div").children
            for d in div:
                try:
                    img = d.find_all("img")
                    image = Table.extract_image(img[0])
                    self.json[idx]["course_map_image"] = image
                except Exception as e:
                    # print("Error scraping course map image for idx", idx)
                    # print(e)
                    pass

        except Exception as e:
            # print("Error scraping course map image for idx", idx)
            # print(e)
            pass
    
    def convert_count(self, count: str) -> int:
        try:
            return int(count)
        except:
            if count.find("infinite") != -1: return -1 # infinite

            count = count.strip()
            # remove any non-digit characters after the number
            for i in range(len(count)):
                if not count[i].isdigit():
                    count = count[:i]
                    break
            try:
                return int(count)
            except:
                return 0
            return 0

    def process_soup(self, soup: BeautifulSoup):
        self.process_objects(soup)