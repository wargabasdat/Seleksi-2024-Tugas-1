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
    logging.info("Navigating to https://schedules.fithub.id/")
    driver.get("https://schedules.fithub.id/")

    # Manually wait for the page to load and set up a waiting mechanism for the webdriver
    wait = WebDriverWait(driver, 10)

    weekly_schedule = {}

    days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    # Click the dropdown button to display the list of available regions
    logging.info("Waiting for and clicking the dropdown button")
    button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, "button.dropdown.dropdown-medium.justify-between")))
    button.click()
    time.sleep(1)

    # Wait until the menu is present
    logging.info("Waiting for the region menu to load")
    containers = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "div.menu-container.br-16.menu")))

    # Select BANDUNG DAN CIMAHI from the menu
    logging.info("Selecting BANDUNG from the menu")
    for container in containers:
        if container.text == "BANDUNG DAN CIMAHI":
            container.click()
            logging.info("Selected BANDUNG DAN CIMAHI")
            break
    
    # Wait until all daily schedules are loaded
    time.sleep(1)
    logging.info("Waiting for daily schedules to load")
    daily_schedules = wait.until(EC.presence_of_all_elements_located((By.CLASS_NAME, "daily-schedule-container")))

    # Process each daily schedule in a week
    for index, schedule in enumerate(daily_schedules):
        # Get all schedules from one day
        logging.info(f"Processing schedule for index {index}")
        class_boxes = schedule.find_elements(By.CLASS_NAME, "class-box")

        day_classes = []

        category_map = {
            "https://schedules.fithub.id/static/media/cardio.ea9eb3cb67fb37c84498.svg": "Cardio",
            "https://schedules.fithub.id/static/media/mind&body.a2802bb32fc1d2d22635.svg": "Mind & Body",
            "https://schedules.fithub.id/static/media/strength.b5323b1bf7ebf2f92991.svg": "Strength",
            "https://schedules.fithub.id/static/media/dance.a8beb8e8d31085ad09f04c3db99cedb3.svg": "Dance"
        }

        # Scrape data of each schedule
        for box in class_boxes:
            try:
                class_time = box.find_element(By.CSS_SELECTOR, "div.justify-end h6").text
                class_name = box.find_element(By.CSS_SELECTOR, "h6.overflow-text").text
                category_src = box.find_element(By.CSS_SELECTOR, "img").get_attribute("src")
                instructor = box.find_elements(By.CSS_SELECTOR, "div.text-start p")[0].text
                branch_name = box.find_elements(By.CSS_SELECTOR, "div.text-start p")[1].text
                difficulty = box.find_element(By.CSS_SELECTOR, "div.card-footer p").text
                duration = box.find_element(By.CSS_SELECTOR, "div.duration-container p").text

                # Remove the "By " prefix in the instructor tag
                instructor = instructor.replace("By ", "").strip()

                # Convert duration into integer form
                duration = int(duration.replace(" MIN", ""))

                # Replace "FH" with "FIT HUB"
                branch_name = branch_name.replace("FH", "FIT HUB").strip()

                # Remove spaces after "FIT HUB " to avoid spacing errors; add camel case for clarity
                branch_name = to_camel_case(branch_name).replace(" ", "").replace("FitHub", "FIT HUB ")

                # Remove spaces to avoid spacing errors; add camel case for clarity
                class_name = to_camel_case(class_name).replace(" ", "")

                # Get the actual category name from the image path
                category = category_map[category_src]

                day_classes.append({
                    "class_time": class_time,
                    "class_name": class_name,
                    "category": category,
                    "instructor": instructor,
                    "branch_name": branch_name,
                    "difficulty": difficulty,
                    "duration": duration
                })
            except Exception as e:
                logging.error(f"Error extracting class details: {e}")
        
        # Label the daily schedule with a day of the week
        day_name = days_of_week[index % 7]

        # Initialize the key if empty (processing morning classes)
        if day_name not in weekly_schedule:
            weekly_schedule[day_name] = []

        # Extend the schedule if a key is already initialized for that day (processing night classes)
        weekly_schedule[day_name].extend(day_classes)

    # Save the results into a JSON file
    with open("./Data Scraping/data/schedule.json", "w") as file:
        json.dump(weekly_schedule, file, indent=4)
        logging.info("Data successfully written to data/schedule.json")

finally:
    driver.quit()
    logging.info("Browser closed")
