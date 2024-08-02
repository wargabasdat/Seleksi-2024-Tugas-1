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

# Helper function to convert text to CamelCase
def to_camel_case(text):
    words = text.split()
    return ''.join(word.capitalize() for word in words)

try:
    # Make a GET request to the site
    logging.info("Navigating to https://fithub.id/location")
    driver.get("https://fithub.id/location")

    # Manually wait for the page to load and set up a waiting mechanism for the webdriver
    logging.info("Waiting for page to load")
    time.sleep(1)
    wait = WebDriverWait(driver, 10)

    # Wait until all link elements are present
    link_elements = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "div.locationButton_button-container__ima9F a")))
    region_links = [(link.get_attribute("href"), link.text) for link in link_elements]
    logging.info(f"Found {len(region_links)} region links")

    results = []

    # Traverse through all region links
    for link, region in region_links:
        logging.info(f"Processing region: {region} with link: {link}")
        driver.get(link)
        time.sleep(1)
            
        # Wait until all container elements are present
        containers = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "a.locationCard_location-card__So0Ze")))

        # Scrape data from all of the containers
        for index, container in enumerate(containers):
            try:
                branch_name = container.find_element(By.CSS_SELECTOR, "h3").text
                address = container.find_element(By.CSS_SELECTOR, "p").text

                # Remove the "(Coming Soon)" suffix if present
                if branch_name.endswith(" (Coming Soon)"):
                    branch_name = branch_name[:-15].strip()

                # Remove spaces after "FIT HUB " to avoid spacing errors; add camel case for clarity
                branch_name = to_camel_case(branch_name).replace(" ", "").replace("FitHub", "FIT HUB ")

                # Avoid name mismatches between branch page and schedule page
                if branch_name == "FIT HUB LengkongKecil":
                    branch_name = "FIT HUB Lengkong"

                results.append({
                    "branch_name": branch_name,
                    "address": address,
                    "region": region
                })
            except Exception as e:
                logging.error(f"Error processing container {index + 1} at {link}: {e}")

    # Filter out branches with region "Semua Club"
    results = [branch for branch in results if branch["region"] != "Semua Club"]
    logging.info(f"Filtered out branches with region 'Semua Club'")

    # Save the results into a JSON file
    with open("./Data Scraping/data/branches.json", "w") as file:
        json.dump(results, file, indent=4)
        logging.info("Data successfully written to data/branches.json")

finally:
    # Stop scraping
    driver.quit()
    logging.info("Browser closed")
