import asyncio
from scrape import scrape
from db import create_db
from typing import Dict
import platform

if platform.system() == 'Windows':
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

asyncio.run(scrape(create_db))