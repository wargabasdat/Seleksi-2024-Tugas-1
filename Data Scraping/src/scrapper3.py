import json
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scrape_ingredients():
    options = webdriver.ChromeOptions()
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--ignore-ssl-errors')

    driver = webdriver.Chrome(options=options)

    url = 'https://www.food.com/about/eggplant-128'
    driver.get(url)

    ingredients = []

    wait = WebDriverWait(driver, 10)

    try:
        try:
            
            desc_element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".ingredient-definition")))
            desc = desc_element.text
        except:
            desc = ""
    
        try:
            how_to_select_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to select']/following-sibling::p")))
            how_to_select = how_to_select_element.text
        except:
            how_to_select = ""

        try:
            how_to_store_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to store']/following-sibling::p")))
            how_to_store = how_to_store_element.text
        except:
            how_to_store = ""


        try:
            how_to_prepare_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to prepare']/following-sibling::p")))
            how_to_prepare = how_to_prepare_element.text
        except:
            how_to_prepare = ""

        try:
            match_with_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='Matches well with']/following-sibling::p")))
            match_with = match_with_element.text 
        except:
            match_with_element = ""

        try:
            substitution_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='Substitution']/following-sibling::p")))
            substitution = substitution_element.text

        except:
            substitution = ""

        ingredient = {
            "description": desc,
            "how_to_select": how_to_select,
            "how_to_store": how_to_store,
            "how_to_prepare": how_to_prepare,
            "matches_well_with": match_with,
            "substitution": substitution
        }
        ingredients.append(ingredient)

        with open(r'Data Scraping/data/ingredients.json', 'w') as jsonfile:
            json.dump(ingredients, jsonfile, indent=4)

    except Exception as e:
        logger.error(f"Error: {e}")

    finally:
        driver.quit()

if __name__ == "__main__":
    scrape_ingredients()
