from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def scrape_recipe_links():
    options = webdriver.ChromeOptions()
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--ignore-ssl-errors')

    driver = webdriver.Chrome(options=options)

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

    driver.quit()

if __name__ == "__main__":
    scrape_recipe_links()