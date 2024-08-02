from table.table import Table
import requests
from bs4 import BeautifulSoup 
import os
from typing import List

class power_up(Table):

    def power_up(self, td):
        name_a = ""
        name = ""
        detail_url = ""
        image = ""
        description = ""

        text = td[0].text
        if text is not None and text.strip() == "N/A":
            name = None
            detail_url = None
            image = None
            description = None
        else:
            name_a = td[0].find("a").findNext("a")
            name = name_a.text
            detail_url = Table.URL+name_a["href"]
            image = Table.extract_image(td[0].find("img"))
            description = ""

        mario_form_name, luigi_form_name = "", ""
        mario_form_detail_url, luigi_form_detail_url = "", ""
        mario_form_image, luigi_form_image = "", ""

        try:
            if td[2]["align"] == "left":
                description = td[2].text
                a = td[1].find("a").findNext("a")
                mario_form_detail_url = a["href"]
                mario_form_name = a.text
                mario_form_image = Table.extract_image(td[1].find("img"))

                luigi_form_detail_url = mario_form_detail_url
                luigi_form_name = mario_form_name
                luigi_form_image = mario_form_image
        except:
            if td[3]["align"] == "left":
                description = td[3].text
                
                a_mario = td[1].find("a").findNext("a")
                mario_form_detail_url = a_mario["href"]
                mario_form_name = a_mario.text
                mario_form_image = Table.extract_image(td[1].find("img"))

                a_luigi = td[2].find("a").findNext("a")
                luigi_form_detail_url = a_luigi["href"]
                luigi_form_name = a_luigi.text
                luigi_form_image = Table.extract_image(td[2].find("img"))

        suffix = "Mario / Luigi"
        mario_form_name = mario_form_name.replace(suffix, "Mario").strip()
        luigi_form_name = luigi_form_name.replace(suffix, "Luigi").strip()

        self.json.append({
            "name": name,
            "description": self.clean_description(description),
            "image": image,
            "detail_url": detail_url,

            "mario_form": {
                "name": mario_form_name,
                "image": mario_form_image,
                "detail_url": Table.URL+mario_form_detail_url
            },

            "luigi_form": {
                "name": luigi_form_name,
                "image": luigi_form_image,
                "detail_url": Table.URL+luigi_form_detail_url
            }
        })

    def process_soup(self, soup: BeautifulSoup):
        self.find_and_process_td("Power-ups", soup, self.power_up)
