import datetime
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
    with open(r'Data Scraping\data\creator_url.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    with open(r'Data Scraping\data\ingredient_links.txt', 'w+') as txtfile: 
        txtfile.truncate(0) 
    open(r'Data Scraping/data/made_of.json', 'w').close()
    with open(r'Data Scraping\data\recipe_links.txt', 'r') as file:
        links = file.readlines()
        
    recipes = []
    made_of = []
    creator_links = []
    ingredient_links = []
    comments = []
    question_list = []

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

            # STILL ERROR
            # layout_item = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".layout_item.rating-badge")))
            # stops = layout_item.find_elements(By.TAG_NAME, 'stop')
            # offsets = [stop.get_attribute('offset') for stop in stops if stop.get_attribute('offset') is not None]
            # print(offsets)

            # Ingredients
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

            # Questions
            question_id = 1
            questions = driver.find_elements(By.CLASS_NAME, 'conversation__post')
            for question in questions:
                print(question.get_attribute("class"))
                if question.get_attribute("class") == "conversation__post svelte-10quso3":
                    print("ini question")
                    question_id = 1
                    # section_id += 1
                elif question.get_attribute("class") == "conversation__post svelte-1f82czh":
                    print("ini reviews")
                    question_id = 1
                    # section_id += 1
                else:
                    print("ini tweaks")
                    question_id = 1

                username = question.find_element(By.CLASS_NAME, 'post__author-link').text
                quest = question.find_element(By.CLASS_NAME, 'text-truncate.svelte-1aswkii').text
                
                try:
                    likes = question.find_element(By.CLASS_NAME, 'recipe-likes').text
                except:
                    likes = None

                question_singular = {
                    "question_id": f"{food_name}_question_{question_id}",
                    "food_name": food_name,
                    "username": username,
                    "question": quest,
                    "likes": likes
                }

                question_list.append(question_singular)
                question_id += 1

                # STILL ERROR
                # The replies
                # try:
                #     reply_button = question.find_element(By.XPATH, ".//button[contains(@class, 'post__reply-action svelte-omstw2')]")
                #     reply_button.click()  
                #     WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.CLASS_NAME, 'post__reply-item')))
                    
                #     replies = question.find_elements(By.CLASS_NAME, 'post__reply-item')
                #     for reply in replies:
                #         replying_user = reply.find_element(By.CLASS_NAME, 'post__author-link').text
                #         reply_text = reply.find_element(By.CLASS_NAME, 'post__text').text
                #         reply_data = {
                #             "replying_user": replying_user,
                #             "reply_text": reply_text
                #         }
                #         question_singular["replies"].append(reply_data)
                # except Exception as e:
                #     print(f"No replies or error occurred: {e}")
                
            # Comment 
            # question_id = 1
            # questions = driver.find_elements(By.CLASS_NAME, 'conversation__post')
            # for question in questions:
            #     username = question.find_element(By.CLASS_NAME, 'post__author-link').text
            #     quest = question.find_element(By.CLASS_NAME, 'text-truncate.svelte-1aswkii').text
            #     try:
            #         likes = question.find_element(By.CLASS_NAME, 'recipe-likes').text
            #     except:
            #         likes = None
            #     question_singular = {
            #         "question_id": f"{food_name}_question_{question_id}",
            #         "food_name": food_name,
            #         "username": username,
            #         "question": quest,
            #         "likes": likes
            #     }
            #     question_list.append(question_singular)
            #     question_id += 1

            # STILL ERROR
            # comments = driver.find_elements(By.CLASS_NAME, 'text-truncate.svelte-1aswkii')
            # ratings = driver.find_elements(By.CLASS_NAME, 'five-star-rating.svelte-1n6w264')
            # users = driver.find_elements(By.CLASS_NAME, 'post__author-link caption svelte-omstw2')
            # likes = driver.find_elements(By.CLASS_NAME, 'recipe-likes__count caption svelte-omstw2')
            # for comment, rating, user, like in zip(comments, ratings, users, likes):
            #     comment_text = comment.text
            #     rating_value = rating.find_element(By.TAG_NAME, 'svg').get_attribute('title')
            #     username = user.text
            #     like_count = like.text
            #     print(f'Username: {username}\nComment: {comment_text}\nRating: {rating_value}\nLikes: {like_count}\n')

            # Click button 
            nutrition_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//a[@class='nutrition'][@data-target='#128_nutrition']"))
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

        with open(r'Data Scraping/data/questions.json', 'w') as jsonfile:
            json.dump(question_list, jsonfile, indent=4)

        logger.info("Succed")

    except Exception as e:
        logger.error(f"Error: {e}")

def scrape_ingredients():
    with open('Data Scraping\data\ingredient_links.txt', 'r') as file:
        links = file.readlines()
    
    ingredients = []

    for link in links:
        driver.get(link)
        id = re.findall(r'\d+', link)
        button_id = "#" + "_".join(id) + "_nutrition"
        print(button_id)

        try:
            # Before button clicked
            name_element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".ingredient-detail")))
            name = name_element.text.split('\n')[0]

            try:
                desc_element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".ingredient-definition")))
                desc = desc_element.text
            except:
                desc = ""

            try:
                season_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h6[text()='Season']/following-sibling::p")))
                season = season_element.text
            except:
                season = ""
        
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

            calories = float(re.search(r'Calories (\d+)', nutrition_info).group(1))
            total_fat = float(re.search(r'Total Fat ([\d.]+) g', nutrition_info).group(1))
            saturated_fat = float(re.search(r'Saturated Fat ([\d.]+) g', nutrition_info).group(1))
            cholesterol = float(re.search(r'Cholesterol ([\d.]+) mg', nutrition_info).group(1))
            sodium = float(re.search(r'Sodium (\d+) mg', nutrition_info).group(1))
            total_carbohydrate = float(re.search(r'Total Carbohydrate ([\d.]+) g', nutrition_info).group(1))
            dietary_fiber = float(re.search(r'Dietary Fiber ([\d.]+) g', nutrition_info).group(1))
            sugars = float(re.search(r'Sugars ([\d.]+) g', nutrition_info).group(1))
            protein = float(re.search(r'Protein ([\d.]+) g', nutrition_info).group(1))

            ingredient = {
                "ingredient_name": name,
                "description": desc,
                "season": season,
                "how_to_select": how_to_select,
                "how_to_store": how_to_store,
                "how_to_prepare": how_to_prepare,
                "matches_well_with": match_with,
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

            with open(r'Data Scraping/data/ingredients.json', 'w') as jsonfile:
                json.dump(ingredients, jsonfile, indent=4)

        except Exception as e:
            logger.error(f"Error: {e}")

def scrape_users():
    with open('Data Scraping/data/user_links.txt', 'r') as file:
        links = file.readlines()

    users = []

    for link in links:
        driver.get(link)
        try:
            name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".text-group .name-bio-message h3"))).text.strip()
        except Exception as e:
            name = None

        user_name = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".text-group .profileusername"))).text.strip()

        try:
            bio = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".text-group .bio"))).text.strip()
        except Exception as e:
            bio = None

        try:
            user_rating_avg = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".user-facts .gk-rating .rating-text"))).text.split(' ')[0]
        except Exception as e:
            user_rating_avg = None

        # STILL ERROR
        # try:
        #     location_element = wait.until(EC.presence_of_element_located((By.XPATH, "//i[contains(@class, 'icon-fdc-map-pin')]/following-sibling::div")))
        #     location = location_element.text.strip()
        #     user_state = location.split(',')[1].strip() if ',' in location else None
        # except Exception as e:
        #     print(f"error: {e}")
        #     location = None
        #     user_state = None

        joined_date_str = wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'Joined')]"))).text.strip()
        joined_date = datetime.datetime.strptime(joined_date_str.replace("Joined", "").strip(), '%m/%Y').strftime('%Y-%m')

        followers = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".user-followers .data .count"))).text.strip()

        following = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".user-following .data .count"))).text.strip()

        user = {
            "name": name,
            "user_name": user_name,
            "bio": bio,
            "user_rating_avg": user_rating_avg,
            # STILL ERROR
            # "location": location,
            # "state": user_state,
            "joined_date": joined_date,
            "followers": followers,
            "following": following
        }
        print(user)
        users.append(user)

    with open('Data Scraping/data/users.json', 'w') as json_file:
        json.dump(users, json_file, indent=4)


if __name__ == "__main__":
    
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
    wait = WebDriverWait(driver, 10)
    
    # Scraping
    scrape_recipes()
    
    # Quit driver
    driver.quit()