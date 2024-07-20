from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

options = webdriver.ChromeOptions()
options.add_argument('--ignore-certificate-errors')
options.add_argument('--ignore-ssl-errors')

driver = webdriver.Chrome(options=options)

# Cuma ambil yang mediteranian sama keto (sama2 jenis diet)
links = ["https://www.food.com/ideas/mediterranean-diet-recipes-6794?ref=nav#c-666481","https://www.food.com/ideas/keto-recipes-6652?ref=nav"]
coll_of_url = []

with open('urls.txt', 'w') as txtfile:
    txtfile.write('')

for link in links:
    driver.get(link)
    assert "Food" in driver.title

    wait = WebDriverWait(driver, 10)
    elements = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".smart-card.container-sm.recipe")))

    with open('urls.txt', 'a') as txtfile: 
        for elem in elements:
            url = elem.get_attribute("data-url")
            if url:
                txtfile.write(url + '\n')

driver.quit()
