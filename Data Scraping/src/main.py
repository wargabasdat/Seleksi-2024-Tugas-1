import asyncio
from scrape import scrape
from db import create_db
from typing import Dict
import platform
import datetime

wait_time = 60*2

if platform.system() == 'Windows':
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

async def start_scheduling():
    while True:
        print(f"New web scraping started at {datetime.datetime.now()}")
        await scrape(create_db)
        print(f"Schedule for {wait_time} seconds")
        await asyncio.sleep(60*2)

try:
    asyncio.run(start_scheduling())
except Exception as e:
    print(f"Error: {e}")