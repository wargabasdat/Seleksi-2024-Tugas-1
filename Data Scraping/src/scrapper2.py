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

    with open(r'Data Scraping\src\creator_url.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open(r'Data Scraping\src\recipes_url.txt', 'r') as file:
        links = file.readlines()

    recipes = []
    creator_links = []

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
            creator = creator_element.text if creator_element else "aaa"
            creator_link = creator_element.get_attribute("href")
            creator_links.append(creator_link)

            # stop_elements = WebDriverWait(driver, 10).until(
            #     EC.presence_of_all_elements_located((By.XPATH, "//stop"))
            # )

            # for element in stop_elements:
            #     offset_value = element.get_attribute("offset")
            #     print(f"Offset: {offset_value}")

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

            print(recipe)

            recipes.append(recipe)

        except Exception as e:
            logger.error(f"Error scraping {recipe_url}: {e}")
            logger.debug(f"Page source: {driver.page_source}")

    try:
        with open(r'Data Scraping/data/recipes.json', 'w') as jsonfile:
            json.dump(recipes, jsonfile, indent=4)
        with open('Data Scraping\src\creator_url.txt', 'w') as txtfile:
            for creator_link in creator_links:
                txtfile.write(creator_link + '\n')
        logger.info("Succed")
    except Exception as e:
        logger.error(f"Error: {e}")

    driver.quit()

if __name__ == "__main__":
    scrape_recipes()
