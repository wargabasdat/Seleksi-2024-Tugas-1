import datetime
import time
from requests import post
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import json
import logging
import re

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scrape_recipe_links():
    with open('Data Scraping/data/source_link.txt', 'r') as file:
        links = file.readlines()

    coll_of_url = []

    for link in links:
        driver.get(link.strip())
        assert "Food" in driver.title

        wait = WebDriverWait(driver, 10)
        try:
            elements = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".smart-card.container-sm.recipe")))

            for elem in elements:
                url = elem.get_attribute("data-url")
                if url:
                    coll_of_url.append(url)
        except Exception as e:
            print(f"Error: {e}")

    with open('Data Scraping/data/recipe_links.txt', 'w') as txtfile: 
        for url in coll_of_url:
            txtfile.write(url + '\n')

def scrape_recipes(): 
    with open(r'Data Scraping\data\user_links.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open(r'Data Scraping\data\ingredient_links.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    # open(r'Data Scraping/data/made_of.json', 'w').close()
    with open('Data Scraping/data/recipe_links.txt', 'r') as file:
        recipe_links = file.readlines()

    recipes = []
    made_of = []
    review_list = []
    tweak_and_question_list = []

    for link in recipe_links:
        with open('Data Scraping/data/user_links.txt', 'r') as file:
            pre_user_links = set(file.read().splitlines())
        with open('Data Scraping/data/ingredient_links.txt', 'r') as file:
            pre_ingredient_links = set(file.read().splitlines())
        user_links = []
        ingredient_links = []
        driver.get(link)
        id = re.findall(r'\d+', link)[0]
        try:
            # Before button clicked
            food_name_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//h1[@class='svelte-1muv3s8']"))
            )
            food_name = food_name_element.text if food_name_element else ""

            creator_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//div[@class='byline svelte-176rmbi']/a"))
            )
            # creator = creator_element.text if creator_element else ""
            creator_link = creator_element.get_attribute("href")
            creator_id = re.findall(r'\d+', creator_link)[0]
            user_links.append(creator_link)

            # Ingredients
            ingredients = driver.find_elements(By.CSS_SELECTOR, ".ingredient-text a")
            for ingredient_element in ingredients:
                ingredient_link = ingredient_element.get_attribute('href')
                ingredient_id = re.findall(r'\d+', ingredient_link)[0]
                made_of_singular = {
                    "food_id": id,
                    "ingredient_id": ingredient_id
                }
                if made_of_singular not in made_of:
                    made_of.append(made_of_singular)
                if ingredient_link not in pre_ingredient_links and ingredient_link not in ingredient_links:
                    ingredient_links.append(ingredient_link)

            # Post
            # Kalo mau ngescrape semua komennya ini tinggal di uncomment ajah
            try:
                while True:
                    try:
                        view_more_button = WebDriverWait(driver, 10).until(
                            EC.element_to_be_clickable((By.CSS_SELECTOR, "span.conversation__show-more__text.svelte-1f82czh"))
                        )
                        view_more_button.click()
                        time.sleep(10)
                    except:
                        break
            except Exception as e:
                print(f"Error: {e}")

            question_id = 1
            review_id = 1
            tweak_id = 1
            posts = driver.find_elements(By.CLASS_NAME, 'conversation__post')
            time.sleep(10)                
            for post in posts:
                username_element = post.find_element(By.CLASS_NAME, 'post__author-link')
                username = username_element.text
                user_link = username_element.get_attribute('href')
                if (user_link not in pre_user_links) and (user_link not in user_links):
                    user_links.append(user_link)
                content = post.find_element(By.CLASS_NAME, 'text-truncate.svelte-1aswkii').text
                likes = post.find_element(By.CLASS_NAME, 'recipe-likes').text
                if likes == "": likes = "0"

                # question
                if post.get_attribute("class") == "conversation__post svelte-10quso3":
                    question_singular = {
                    "tweak_and_question_id": f"question_{id}_{question_id}",
                    "food_id": id,
                    "username": username,
                    "content": content,
                    "likes": likes
                    }
                    question_id += 1
                    tweak_and_question_list.append(question_singular)

                # review
                elif post.get_attribute("class") == "conversation__post svelte-1f82czh":
                    stop_elements = post.find_elements(By.TAG_NAME, "stop")
                    rating_sum = 0
                    for stop_element in stop_elements:
                        rating = stop_element.get_attribute("offset")
                        rating = re.findall(r'\d+', rating)[0]
                        rating = int(rating)
                        rating_sum += rating
                    rating_mean = rating_sum/100
                    review_singular = {
                    "review_id": f"review_{id}_{review_id}",
                    "food_id": id,
                    "username": username,
                    "content": content,
                    "rating": rating_mean,
                    "likes": likes
                    }
                    review_id += 1
                    review_list.append(review_singular)

                #tweak
                else:
                    tweak_singular = {
                    "tweak_and_question_id": f"tweak_{id}_{tweak_id}",
                    "food_id": id,
                    "username": username,
                    "content": content,
                    "likes": likes
                    }
                    tweak_id += 1
                    tweak_and_question_list.append(tweak_singular)

            # Click button 
            nutrition_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.CSS_SELECTOR, "button.link.facts__nutrition.svelte-1dqq0pw"))
            )
            nutrition_button.click()

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
                "food_id": id,
                "food_name": food_name,
                "creator_id": creator_id,
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
            # print(recipe)
            try:
                with open('Data Scraping/data/user_links.txt', 'a') as txtfile:
                    for user_link in user_links:
                        txtfile.write(user_link + '\n')
                with open('Data Scraping/data/ingredient_links.txt', 'a') as txtfile:
                    for ingredient_link in ingredient_links:
                        txtfile.write(ingredient_link + '\n')
            except Exception as e:
                logger.error(f"Error: {e}")

        except Exception as e:
            logger.error(f"Error scraping {link}: {e}")
            logger.debug(f"Page source: {driver.page_source}")

    try:
        with open('Data Scraping/data/recipes.json', 'w') as jsonfile:
            json.dump(recipes, jsonfile, indent=4)

        with open('Data Scraping/data/made_of.json', 'w') as jsonfile:
            json.dump(made_of, jsonfile, indent=4)

        with open('Data Scraping/data/reviews.json', 'w') as jsonfile:
            json.dump(review_list, jsonfile, indent=4)

        with open('Data Scraping/data/tweaks_and_questions.json', 'w') as jsonfile:
            json.dump(tweak_and_question_list, jsonfile, indent=4)

        logger.info("Succeed")

    except Exception as e:
        logger.error(f"Error: {e}")

def scrape_ingredients():
    with open('Data Scraping/data/ingredient_links.txt', 'r') as file:
        links = file.readlines()
    
    ingredients = []

    for link in links:
        driver.get(link)
        id = re.findall(r'\d+', link)[0]
        button_id = "#" + id + "_nutrition"
        try:
            # Before button clicked
            name_element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".ingredient-detail")))
            name = name_element.text.split('\n')[0]

            try:
                season_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='Season']/following-sibling::p")))
                season = season_element.text
            except:
                season = ""
            season = season.split("-")
            if "year" in season:
                season_start = season[0]
                season_end = season[1]
            else:
                season_start = "January"
                season_end = "December"
        
            # try:
            #     how_to_select_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to select']/following-sibling::p")))
            #     how_to_select = how_to_select_element.text
            # except:
            #     how_to_select = ""

            # try:
            #     how_to_store_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to store']/following-sibling::p")))
            #     how_to_store = how_to_store_element.text
            # except:
            #     how_to_store = ""


            # try:
            #     how_to_prepare_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='How to prepare']/following-sibling::p")))
            #     how_to_prepare = how_to_prepare_element.text
            # except:
            #     how_to_prepare = ""

            try:
                substitution_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='Substitution']/following-sibling::p")))
                substitution = substitution_element.text

            except:
                substitution = ""

            # Click button
            try:
                nutrition_button = wait.until(
                    EC.element_to_be_clickable((By.CSS_SELECTOR, f"a.nutrition[data-target='{button_id}']"))
                )
                nutrition_button.click()
            except Exception as e:
                print(f"Error:{e}")

            # After button clicked
            try:
                modal_content = wait.until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, "div.modal-body"))
                )
                nutrition_info = modal_content.text
            except Exception as e:
                print(f"Error:{e}")

            try : calories = float(re.search(r'Calories (\d+)', nutrition_info).group(1))
            except : calories = ""
            try : total_fat = float(re.search(r'Total Fat ([\d.]+) g', nutrition_info).group(1))
            except : total_fat = ""
            try: saturated_fat = float(re.search(r'Saturated Fat ([\d.]+) g', nutrition_info).group(1))
            except : saturated_fat = ""
            try : cholesterol = float(re.search(r'Cholesterol ([\d.]+) mg', nutrition_info).group(1))
            except : cholesterol = ""
            try : sodium = float(re.search(r'Sodium (\d+) mg', nutrition_info).group(1))
            except : sodium = ""
            try : total_carbohydrate = float(re.search(r'Total Carbohydrate ([\d.]+) g', nutrition_info).group(1))
            except : total_carbohydrate = ""
            try : dietary_fiber = float(re.search(r'Dietary Fiber ([\d.]+) g', nutrition_info).group(1))
            except : dietary_fiber = ""
            try : sugars = float(re.search(r'Sugars ([\d.]+) g', nutrition_info).group(1))
            except : sugars = ""
            try : protein = float(re.search(r'Protein ([\d.]+) g', nutrition_info).group(1))
            except :protein = ""

            ingredient = {
                "ingredient_id": id,
                "ingredient_name": name,
                # "description": desc,
                "season_start": season_start,
                "season_end": season_end,
                # "how_to_select": how_to_select,
                # "how_to_store": how_to_store,
                # "how_to_prepare": how_to_prepare,
                "substitution": substitution,
                "calories": calories,
                "total_fat": total_fat,
                "saturated_fat": saturated_fat,
                "cholesterol": cholesterol,
                "sodium": sodium,
                "total_carbohydrate": total_carbohydrate,
                "dietary_fiber": dietary_fiber,
                "sugars": sugars,
                "protein": protein
            }
            ingredients.append(ingredient)
            try:
                with open('Data Scraping/data/ingredients.json', 'w') as jsonfile:
                    json.dump(ingredients, jsonfile, indent=4)
            except Exception as e:
                logger.error(f"Error: {e}")
        except Exception as e:
            logger.error(f"Error: {e}")

def scrape_users():
    with open('Data Scraping/data/user_links.txt', 'r') as file:
        links = file.readlines()

    users = []

    for link in links:
        driver.get(link)
        id = re.findall(r'\d+', link)[0]
        try:
            name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.name-bio-message h3"))).text.strip()
        except Exception as e:
            name = None

        user_name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.profileusername"))).text.strip()

        # try:
        #     bio = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".text-group.bio"))).text.strip()
        # except Exception as e:
        #     bio = None

        try:
            user_rating_avg = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.gk-rating span.rating-text"))).text.split(' ')[0]
        except Exception as e:
            user_rating_avg = ""

        joined_date_str = wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'Joined')]"))).text.strip()
        joined_date = datetime.datetime.strptime(joined_date_str.replace("Joined", "").strip(), '%m/%Y').strftime('%Y-%m')

        followers = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "a.user-followers span.count"))).text.strip()

        following = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "a.user-following span.count"))).text.strip()

        user = {
            "user_id": id,
            "name": name,
            "user_name": user_name,
            # "bio": bio,
            "user_rating_avg": user_rating_avg,
            # STILL ERROR
            # "location": location,
            # "state": user_state,
            "joined_date": joined_date,
            "followers": followers,
            "following": following
        }
        users.append(user)

    with open('Data Scraping/data/users.json', 'w') as json_file:
        json.dump(users, json_file, indent=4)

if __name__ == "__main__":

    start = time.time()
    
    # Setup & run driver
    options = webdriver.ChromeOptions()
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--ignore-ssl-errors')
    options.add_argument('--allow-insecure-localhost')
    options.add_argument('--blink-settings=imagesEnabled=false')
    options.add_argument("--disable-javascript")
    options.page_load_strategy = 'eager'
    options.add_argument("--disable-extensions")

    driver = webdriver.Chrome(options=options)
    wait = WebDriverWait(driver, 20)
    
    # Scraping
    scrape_recipe_links()
    scrape_recipes()
    scrape_ingredients()
    scrape_users()
    
    # Quit driver
    driver.quit()

    end = time.time()

    p = (end - start) / 60 
    print(f"{p} minutes")