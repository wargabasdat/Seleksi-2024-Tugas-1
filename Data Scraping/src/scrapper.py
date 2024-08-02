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
    with open('Data Scraping/data/root_link.txt', 'r') as file:
        links = file.readlines()

    # initiate the array needed
    coll_of_url = []

    for link in links:
        driver.get(link.strip())
        assert "Food" in driver.title

        wait = WebDriverWait(driver, 10)
        try:
            # find all link elements
            elements = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".smart-card.container-sm.recipe"))) 

            # append link to coll_of_url
            for elem in elements: 
                url = elem.get_attribute("data-url")
                if url:
                    coll_of_url.append(url)
        except Exception as e:
            print(f"Error: {e}")

    # save coll_of_url in txt file 
    with open('Data Scraping/data/recipe_link.txt', 'w') as txtfile: 
        for url in coll_of_url:
            txtfile.write(url + '\n')

def scrape_recipes(): 
    # clean all of txt files needed
    with open('Data Scraping/data/user_link.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open('Data Scraping/data/ingredient_link.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open('Data Scraping/data/recipe_link.txt', 'r') as file:
        recipe_links = file.readlines()

    # initiate array
    recipes = []
    made_of = []
    post_list = []
    reviews = []
    ingredient_links = set()
    user_links = set()

    for link in recipe_links:
        driver.get(link)
        # get the food id
        id = re.findall(r'\d+', link)[0]
        try:
            # Before button clicked
            # scrape food name 
            food_name_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//h1[@class='svelte-1muv3s8']"))
            )
            food_name = food_name_element.text if food_name_element else ""

            # scrape creator 
            creator_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//div[@class='byline svelte-176rmbi']/a"))
            )
            creator_link = creator_element.get_attribute("href")
            creator_id = re.findall(r'\d+', creator_link)[0]
            user_links.add(creator_link)

            # scrape ingredients link and made of array
            ingredients = driver.find_elements(By.CSS_SELECTOR, ".ingredient-text a")
            for ingredient_element in ingredients:
                ingredient_link = ingredient_element.get_attribute('href')
                ingredient_id = re.findall(r'\d+', ingredient_link)[0]
                made_of_singular = {
                    "food_id": id,
                    "ingredient_id": ingredient_id
                }
                if made_of_singular not in made_of and 'about' in ingredient_link:
                    made_of.append(made_of_singular)
                    ingredient_links.add(ingredient_link)

            # scrape post and review 
            post_id = 1
            posts = driver.find_elements(By.CLASS_NAME, 'conversation__post')
            time.sleep(10)                
            for post in posts:
                username_element = post.find_element(By.CLASS_NAME, 'post__author-link')
                user_link = username_element.get_attribute('href')
                user_id = re.findall(r'\d+', user_link)[0]
                user_links.add(user_link)
                content = post.find_element(By.CLASS_NAME, 'text-truncate.svelte-1aswkii').text
                likes = post.find_element(By.CLASS_NAME, 'recipe-likes').text
                if likes == "": likes = "0"

                # question
                if post.get_attribute("class") == "conversation__post svelte-10quso3":
                    question_singular = {
                    "post_id": post_id,
                    "food_id": id,
                    "user_id": user_id,
                    "content": content,
                    "likes": likes,
                    "type": "question"
                    }
                    post_id += 1
                    post_list.append(question_singular)

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
                    "post_id": post_id,
                    "food_id": id,
                    "user_id": user_id,
                    "content": content,
                    "likes": likes,
                    "type": "review"
                    }
                    post_list.append(review_singular)

                    review_specialization = {
                    "post_id": post_id,
                    "food_id": id,
                    "rating": rating_mean
                    }
                    reviews.append(review_specialization)
                    post_id += 1

                #tweak
                else:
                    tweak_singular = {
                    "post_id": post_id,
                    "food_id": id,
                    "user_id": user_id,
                    "content": content,
                    "likes": likes,
                    "type": "tweak"
                    }
                    post_id += 1
                    post_list.append(tweak_singular)

            # Click button 
            nutrition_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.CSS_SELECTOR, "button.link.facts__nutrition.svelte-1dqq0pw"))
            )
            nutrition_button.click()

            # After button clicked  
            #scrape serving size
            serving_size_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[@class='svelte-epeb0m']"))
            )
            serving_size_text = serving_size_element.text if serving_size_element else ""
            serving_size_match = re.search(r'\((\d+)\)', serving_size_text)
            serving_size = serving_size_match.group(1) if serving_size_match else ""
            # scrape calories
            calories_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//p[contains(@class, 'recipe-nutrition__item bold') and contains(text(), 'Calories')]"))
            )
            calories = calories_element.text.split(" ")[-1] if calories_element else ""
            # scrape total fat
            total_fat_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Total Fat')]"))
            )
            total_fat = total_fat_element.text.split(" ")[-2] if total_fat_element else ""
            # scrape saturated fat
            saturated_fat_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Saturated Fat')]"))
            )
            saturated_fat = saturated_fat_element.text.split(" ")[-2] if saturated_fat_element else ""
            # scrape cholesterol
            cholesterol_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Cholesterol']"))
            )
            parent_span = cholesterol_element.find_element(By.XPATH, "./..")
            cholesterol = parent_span.text.split(" ")[-2] if parent_span else ""
            # scrape sodium
            sodium_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Sodium']"))
            )
            parent_span = sodium_element.find_element(By.XPATH, "./..")
            sodium = parent_span.text.split(" ")[-2] if parent_span else ""
            # scrape carbohydrate
            carbohydrate_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Total Carbohydrate']"))
            )
            parent_span = carbohydrate_element.find_element(By.XPATH, "./..")
            carbohydrate = parent_span.text.split(" ")[-2] if parent_span else ""
            # scrape fiber
            fiber_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Dietary Fiber')]"))
            )
            fiber = fiber_element.text.split(" ")[-2] if fiber_element else ""
            # scrape sugar
            sugar_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[contains(text(), 'Sugars')]"))
            )
            sugar = sugar_element.text.split(" ")[-2] if sugar_element else ""
            # scrape protein
            protein_element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//span[@class='bold svelte-epeb0m' and text()='Protein']"))
            )
            parent_span = protein_element.find_element(By.XPATH, "./..")
            protein = parent_span.text.split(" ")[-2] if parent_span else ""

            # store the result
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

        except Exception as e:
            logger.error(f"Error scraping {link}: {e}")
            logger.debug(f"Page source: {driver.page_source}")

    #store all of the arrays in json and txt 
    try:
        with open('Data Scraping/data/recipes_' + generate_timestamp() + '.json', 'w') as jsonfile:
            json.dump(recipes, jsonfile, indent=4)

        with open('Data Scraping/data/madeof_' + generate_timestamp() + '.json', 'w') as jsonfile:
            json.dump(made_of, jsonfile, indent=4)

        with open('Data Scraping/data/posts_' + generate_timestamp() + '.json', 'w') as jsonfile:
            json.dump(post_list, jsonfile, indent=4)

        with open('Data Scraping/data/reviews_' + generate_timestamp() + '.json', 'w') as jsonfile:
            json.dump(reviews, jsonfile, indent=4)

        with open('Data Scraping/data/user_link.txt', 'a') as txtfile:
            for user_link in user_links:
                txtfile.write(user_link + '\n')

        with open('Data Scraping/data/ingredient_link.txt', 'a') as txtfile:
            for ingredient_link in ingredient_links:
                txtfile.write(ingredient_link + '\n')

        logger.info("Succeed")

    except Exception as e:
        logger.error(f"Error: {e}")

def scrape_ingredients():
    with open('Data Scraping/data/ingredient_link.txt', 'r') as file:
        links = file.readlines()
    
    # initiate the array needed
    ingredients = []

    for link in links:
        driver.get(link)
        # get the ingredient id 
        id = re.findall(r'\d+', link)[0]
        button_id = "#" + id + "_nutrition"
        try:
            # Before button clicked
            # scrape ingredient name 
            name_element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".ingredient-detail")))
            name = name_element.text.split('\n')[0]

            # scrape season start and end (Januari - December if available all year round)
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

            # Click button
            try:
                nutrition_button = wait.until(
                    EC.element_to_be_clickable((By.CSS_SELECTOR, f"a.nutrition[data-target='{button_id}']"))
                )
                nutrition_button.click()
            except Exception as e:
                print(f"Error:{e}")

            # After button clicked
            # scrape nutrition facts 
            try:
                modal_content = wait.until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, "div.modal-body"))
                )
                nutrition_info = modal_content.text
            except Exception as e:
                print(f"Error:{e}")

            # parsing nutrition facts
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

            # store the result into arr of dict
            ingredient = {
                "ingredient_id": id,
                "ingredient_name": name,
                "season_start": season_start,
                "season_end": season_end,
                "calories": calories,
                "total_fat": total_fat,
                "saturated_fat": saturated_fat,
                "cholesterol": cholesterol,
                "protein": protein,
                "carbohydrate": total_carbohydrate,
                "fiber": dietary_fiber,
                "sugar": sugars,
                "sodium": sodium
            }
            ingredients.append(ingredient)
        except Exception as e:
            logger.error(f"Error: {e}")

    # store the result into json
    try:
        with open('Data Scraping/data/ingredients_' + generate_timestamp() + '.json', 'w') as jsonfile:
            json.dump(ingredients, jsonfile, indent=4)
    except Exception as e:
        logger.error(f"Error: {e}")

def scrape_users():
    with open('Data Scraping/data/user_link.txt', 'r') as file:
        links = file.readlines()

    # initiate the array needed
    users = []

    for link in links:
        driver.get(link)
        # get the user id 
        id = re.findall(r'\d+', link)[0]

        # scrape name 
        try:
            name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.name-bio-message h3"))).text.strip()
        except: name = None

        # scrape username
        try:
            user_name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.profileusername"))).text.strip()
        except: user_name = ""

        # scrape city and state 
        try:
            user_fact = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.user-facts"))).text.strip()
            user_fact_list = user_fact.split("\n")
            for fact in user_fact_list:
                contains_comma = len(re.findall(", ", fact)) != 0
                if contains_comma:
                    city = fact.split(",")[0]
                    state = fact.split(",")[1]
                    break
            if not contains_comma:
                city = ""
                state = ""
        except:
            city = ""
            state = ""

        # scrape rating
        try:
            user_rating_avg = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.gk-rating span.rating-text"))).text.split(' ')[0]
        except: user_rating_avg = ""

        # scrape joined month and year
        try:
            joined_date_str = wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'Joined')]"))).text.strip()
            joined_date = datetime.datetime.strptime(joined_date_str.replace("Joined", "").strip(), '%m/%Y').strftime('%Y-%m').split("-")
            year = joined_date[0]
            month = joined_date[1]
        except:
            year = ""
            month = ""

        # scrape follower count 
        try:
            followers = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "a.user-followers span.count"))).text.strip()
        except: followers = "0"

        # scrape following count
        try: 
            following = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "a.user-following span.count"))).text.strip()
        except: 
            following = "0"

        # store the result into arr of dict
        user = {
            "user_id": id,
            "name": name,
            "username": user_name,
            "user_rating_avg": user_rating_avg,
            "city": city,
            "state": state,
            "joined_year": year,
            "joined_month": month,
            "followers": followers,
            "following": following
        }
        users.append(user)

    # store the result into json 
    with open('Data Scraping/data/users_' + generate_timestamp() + '.json', 'w') as json_file:
        json.dump(users, json_file, indent=4)\
        
def generate_timestamp(): 
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%Hh%Mm%Ss") # generate timestamp (now) for file naming
    return timestamp
        
def scrape_all(): # run all scraping code 
    scrape_recipe_links()
    scrape_recipes()
    scrape_ingredients()
    scrape_users()

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

    scrape_all() # run all code here 

    # Quit driver
    driver.quit()

    end = time.time()
    p = (end - start) / 60 
    print(f"{p} minutes")