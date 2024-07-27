from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import json
import logging
import re

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scrape_recipes():
    options = webdriver.ChromeOptions()
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--ignore-ssl-errors')

    driver = webdriver.Chrome(options=options)

    with open(r'Data Scraping\data\creator_url.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open(r'Data Scraping\data\ingredient_links.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    open(r'Data Scraping/data/made_of.json', 'w').close()
    with open(r'Data Scraping\data\recipes_url.txt', 'r') as file:
        links = file.readlines()
        
    recipes = []
    made_of = []
    creator_links = []
    ingredient_links = []

    for recipe_url in links:
        driver.get(recipe_url)
        try:
            # Before button clicked
            food_name_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//h1[@class='svelte-1muv3s8']"))
            )
            food_name = food_name_element.text if food_name_element else ""

            creator_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//div[@class='byline svelte-176rmbi']/a"))
            )
            creator = creator_element.text if creator_element else ""
            creator_link = creator_element.get_attribute("href")
            creator_links.append(creator_link)

            ingredients = driver.find_elements(By.CSS_SELECTOR, ".ingredient-text a")
            for ingredient_element in ingredients:
                ingredient = ingredient_element.text
                made_of_singular = {
                    "food_name": food_name,
                    "ingredient": ingredient
                }
                made_of.append(made_of_singular)
                ingredient_link = ingredient_element.get_attribute('href')
                ingredient_links.append(ingredient_link)
            print(ingredient_links)

            # Click button 
            nutrition_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//button[@class='link facts__nutrition svelte-1dqq0pw']"))
            )
            nutrition_button.click()
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[@class='svelte-epeb0m']"))
            )

            # After button clicked  
            serving_size_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[@class='svelte-epeb0m']"))
            )
            serving_size_text = serving_size_element.text if serving_size_element else ""
            serving_size_match = re.search(r'\((\d+)\)', serving_size_text)
            serving_size = serving_size_match.group(1) if serving_size_match else ""

            calories_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[contains(@class, 'recipe-nutrition__item bold') and contains(text(), 'Calories')]"))
            )
            calories = calories_element.text.split(" ")[-1] if calories_element else ""

            total_fat_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Total Fat')]"))
            )
            total_fat = total_fat_element.text.split(" ")[-2] if total_fat_element else ""

            saturated_fat_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Saturated Fat')]"))
            )
            saturated_fat = saturated_fat_element.text.split(" ")[-2] if saturated_fat_element else ""

            total_fat_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Total Fat')]"))
            )
            total_fat = total_fat_element.text.split(" ")[-2] if total_fat_element else ""

            cholesterol_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Cholesterol']"))
            )
            parent_span = cholesterol_element.find_element(By.XPATH, "./..")
            cholesterol = parent_span.text.split(" ")[-2] if parent_span else ""

            cholesterol_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Cholesterol']"))
            )
            parent_span = cholesterol_element.find_element(By.XPATH, "./..")
            cholesterol = parent_span.text.split(" ")[-2] if parent_span else ""

            sodium_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Sodium']"))
            )
            parent_span = sodium_element.find_element(By.XPATH, "./..")
            sodium = parent_span.text.split(" ")[-2] if parent_span else ""

            carbohydrate_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Total Carbohydrate']"))
            )
            parent_span = carbohydrate_element.find_element(By.XPATH, "./..")
            carbohydrate = parent_span.text.split(" ")[-2] if parent_span else ""

            fiber_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Dietary Fiber')]"))
            )
            fiber = fiber_element.text.split(" ")[-2] if fiber_element else ""

            sugar_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Sugars')]"))
            )
            sugar = sugar_element.text.split(" ")[-2] if sugar_element else ""

            protein_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Protein']"))
            )
            parent_span = protein_element.find_element(By.XPATH, "./..")
            protein = parent_span.text.split(" ")[-2] if parent_span else ""

            recipe = {
                "food_name": food_name,
                "creator": creator,
                "serving_size": serving_size,
                "calories": calories,
                "total_fat": total_fat,
                "saturated_fat": saturated_fat,
                "cholesterol": cholesterol,
                "protein": protein,
                "carbohydrate": carbohydrate,
                "fiber": fiber,
                "sugar": sugar,
                "sodium": sodium
            }
            recipes.append(recipe)

        except Exception as e:
            logger.error(f"Error scraping {recipe_url}: {e}")
            logger.debug(f"Page source: {driver.page_source}")

    try:
        with open(r'Data Scraping/data/recipes.json', 'w') as jsonfile:
            json.dump(recipes, jsonfile, indent=4)

        with open('Data Scraping\data\creator_url.txt', 'w') as txtfile:
            for creator_link in creator_links:
                txtfile.write(creator_link + '\n')

        with open('Data Scraping\data\ingredient_links.txt', 'w') as txtfile:
            for ingredient_link in ingredient_links:
                txtfile.write(ingredient_link + '\n')

        with open(r'Data Scraping/data/made_of.json', 'w') as jsonfile:
            json.dump(made_of, jsonfile, indent=4)

        logger.info("Succed")

    except Exception as e:
        logger.error(f"Error: {e}")

    driver.quit()

if __name__ == "__main__":
    scrape_recipes()
