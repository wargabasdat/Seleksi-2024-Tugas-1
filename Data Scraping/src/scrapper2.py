from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import json
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scrape_recipes():
    options = webdriver.ChromeOptions()
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--ignore-ssl-errors')

    driver = webdriver.Chrome(options=options)

    links = ["https://www.food.com/recipe/falafel-293197", "https://www.food.com/recipe/mediterranean-tilapia-pockets-rsc-487593", "https://www.food.com/recipe/lebanese-lentil-salad-47961"]

    recipes = []

    for recipe_url in links:
        driver.get(recipe_url)
        try:

            # Click nutrition information button
            nutrition_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//button[@class='link facts__nutrition svelte-1dqq0pw']"))
            )
            nutrition_button.click()
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[@class='svelte-epeb0m']"))
            )

            # Scrape food name, creator 
            food_name = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//h1[@class='svelte-1muv3s8']"))
            ).text
            creator = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//div[@class='byline svelte-176rmbi']/a"))
            ).text
            logger.info(f"Creator: {creator}")

            # Scrape nutrition information
            serving_size = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[@class='svelte-epeb0m']"))
            ).text
            logger.info(f"Serving size: {serving_size}")

            recipe = {
                "food_name": food_name,
                "creator": creator,
                "serving_size": serving_size
            }

            recipes.append(recipe)

        except Exception as e:
            logger.error(f"Error scraping {recipe_url}: {e}")
            logger.debug(f"Page source: {driver.page_source}")

    with open('recipes.json', 'w') as jsonfile:
        json.dump(recipes, jsonfile, indent=4)

    driver.quit()
    logger.info("Scraping completed and recipes saved to recipes.json")

if __name__ == "__main__":
    scrape_recipes()
