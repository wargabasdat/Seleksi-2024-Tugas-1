from typing import List, Dict
from table.table import Table
from table.character import character
from table.item import item
from table.obstacle import obstacle
from table.power_up import power_up
from table.object import object
from table.reference import reference
from table.version import version
from table.level import level
from json import dump
import asyncio
from typing import Callable
import asyncio
import os


async def scrape(on_scrape_completed: Callable[[Dict], None]):
    soup = Table.get_soup()

    levels_tables = level()
    tables: List[Table] = [
        character(),
        obstacle(),
        item(),
        power_up(),
        object(),
        reference(),
        version(),
        levels_tables
    ]

    json: List[Dict] = {}
    for table in tables:
        json[table.__class__.__name__] = table.scrape(soup)

    await levels_tables.populate_detail()

    try:
        if not os.path.exists("json"):
            os.makedirs("json")
        with open("json/data.json", "w") as outfile: 
            dump(json, outfile)
    except Exception as e:
        print(e)
        # print all folders in the current directory
        print(os.listdir(os.getcwd()))

    if on_scrape_completed:
        on_scrape_completed(json)


if __name__ == "__main__":
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    asyncio.run(scrape())
    