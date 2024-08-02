import time
import json
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Add user agent
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"

# Set up chrome options, service, and driver
chrome_options = Options()
chrome_options.add_argument(f"user-agent={user_agent}")

service = Service()

driver = webdriver.Chrome(service=service, options=chrome_options)

def to_camel_case(text):
    words = text.split()
    return ''.join(word.capitalize() for word in words)

try:
    # Make a GET request to the site
    logging.info("Navigating to https://fithub.id/class")
    driver.get("https://fithub.id/class")

    # Manually wait for the page to load and set up a waiting mechanism for the webdriver
    logging.info("Waiting for page to load")
    time.sleep(5)
    wait = WebDriverWait(driver, 10)
    
    # Wait until all class containers are present
    containers = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "div.CardClass_card-class-content__bmYWa")))

    results = []

    # Scrape data from all of the containers, missing data will be treated as null
    for index, container in enumerate(containers):
        try:
            category = None
            class_name = None
            difficulty = None
            duration = None

            try:
                category = container.find_element(By.CSS_SELECTOR, "div.CardClass_card-category-wrapper__bGTwA p").text
                category = category.replace("CLASSES", "").strip() # Remove the " CLASSES" prefix
            except Exception as e:
                logging.warning(f"Failed to get category for container {index + 1}")
                category = None

            try:
                class_name = container.find_element(By.CSS_SELECTOR, "h2").text
                class_name = to_camel_case(class_name).replace(" ", "") # Remove spaces to avoid spacing errors; add camel case for clarity
            except Exception as e:
                logging.warning(f"Failed to get class name for container {index + 1}")
                class_name = None

            try:
                difficulty = container.find_element(By.CSS_SELECTOR, "div.CardClass_card-class-diffulty__gbWBu p").text
            except Exception as e:
                logging.warning(f"Failed to get difficulty for container {index + 1}")
                difficulty = None

            try:
                duration = container.find_element(By.CSS_SELECTOR, "div.CardClass_card-class-duration__HKTy5").text
                duration = int(duration.replace(" MIN", "")) # Convert duration into integer form
            except Exception as e:
                logging.warning(f"Failed to get duration for container {index + 1}")
                duration = None

            results.append({
                "category": category,
                "class_name": class_name,
                "difficulty": difficulty,
                "duration": duration
            })

        except Exception as e:
            logging.error(f"Error processing container {index + 1}")

    # Save the results into a JSON file
    with open("./Data Scraping/data/classes.json", "w") as file:
        json.dump(results, file, indent=4)
        logging.info("Data successfully written to data/classes.json")

finally:
    # Stop scraping
    driver.quit()
    logging.info("Browser closed")
