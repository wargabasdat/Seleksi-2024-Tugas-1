import os
import shutil
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import undetected_chromedriver as uc
from datetime import datetime
import time
import json

def char_scrape():

    """
    Prosedur ini melakukan scraping dari main_url, yaitu laman top hated character dari anime-planet
    Hasil akhirnya adalah dibuatnya file hated_characters.json dan hated_characters_anime_url.json
    yang disimpan di folder data
    """

    driver.get(main_url)
    print("driver is running")
    time.sleep(10)  # Beri waktu untuk laman memuat

    # Mencari semua baris dari tabel karakter
    row_elements = driver.find_elements(By.TAG_NAME, "tr")

    char_list = []  # digunakan untuk menyimpan detail semua karakter
    anime_dict = {} # digunakan untuk menyimpan url anime yang ada di laman main_url
    char_details = {}   # digunakan untuk menyimpan detail karakter di setiap baris

    # Mengiterasi 51 elemen baris pertama pada tabel karena baris pertama adalah header tabel
    for i in range(len(row_elements)//2 + 2):
        
        # Mengambil dan menyimpan nama dan laman karakter
        try:
            name = row_elements[i].find_element(By.CSS_SELECTOR, "a.name").text.lower() # melakukan lowercasing sebagai bentuk data preprocessing (cleaning)
            char_url = row_elements[i].find_element(By.CSS_SELECTOR, "a.name").get_attribute("href")
            char_details["name"] = name
            char_details["char_url"] = char_url
        except:
            print(row_elements[i], "doesnt have a.name")
        
        # Mengambil dan menyimpan urutan ranking dari karakter
        try:
            rank = row_elements[i].find_element(By.CSS_SELECTOR, "td.tableRank").text.lower()
            char_details["rank"] = rank
        except:
            print(row_elements[i], "doesnt have td.tableRank")

        # Mengambil dan menyimpan avatar url karakter
        try:
            avatar_url = row_elements[i].find_element(By.TAG_NAME, "img").get_attribute("src")
            char_details["avatar_url"] = avatar_url
        except:
            print(row_elements[i], "doesnt have image tag")

        # Mengambil dan menyimpan jumlah hates user untuk karakter ini
        try:
            char_hates = row_elements[i].find_element(By.CSS_SELECTOR, "span.heartOff").text.lower().replace(",", "").replace(" ", "").strip()  # perlu menghapus koma karena website ini menggunakan koma sebagai separator ribuan
            char_details["char_hates"] = int(char_hates)    # casting dari teks ke int sebagai bentuk preprocessing (transformation)
        except:
            print(row_elements[i], "doesnt have heartOff")

        # Mengambil dan menyimpan jumlah komentar user untuk karakter ini
        try:
            char_comments = row_elements[i].find_element(By.CSS_SELECTOR, "span.fa.fa-comment").text.lower().replace(",", "").replace(" ", "").strip()   # penghapusan koma dan whitespace sebagai bentuk preprocessing (cleaning)
            char_details["char_comments"] = int(char_comments)
        except:
            print(row_elements[i], "doesnt have fa fa-comment")

        # Mengambil dan menyimpan traits dan tags dari karakter
        try:
            tags_div = row_elements[i].find_element(By.CSS_SELECTOR, "td.tableCharInfo").find_elements(By.CSS_SELECTOR, "div.tags")
            for j in range(len(tags_div)):
                h4_text = tags_div[j].find_element(By.CSS_SELECTOR, "h4").text.lower().strip().strip(":")
                if (h4_text == "traits" or h4_text == "tags"):
                    li_elements = tags_div[j].find_elements(By.CSS_SELECTOR, "ul li")
                    char_details[h4_text] = [li.text.lower() for li in li_elements]
        except:
            print(row_elements[i], "doesnt have traits and tags")

        # Mengambil dan menyimpan judul-judul anime di mana karakter berperan
        try:
            anime = row_elements[i].find_element(By.CSS_SELECTOR, "td.tableAnime").find_elements(By.CSS_SELECTOR, "div")[0] # perlu indexing 0 karena div nya ada 2, index 0 adalah anime dan index 1 adalah manga
            li_elements = anime.find_elements(By.CSS_SELECTOR, "ul li")
            char_details["appears_in"] = [li.text.lower() for li in li_elements[:3]]    # judul anime yang diambil hanya maksimal 3 judul agar tidak terlalu banyak
            
            anime_tooltip = anime.find_elements(By.CSS_SELECTOR, "a.tooltip")[:3]   # url anime yang disimpan sesuai judul yang diambil
            for tooltip in anime_tooltip:
                anime_dict[tooltip.text.lower()] = (tooltip.get_attribute("href"))
                
        except:
            print(row_elements[i], "doesnt have anime")
        
        if ((len(char_details) > 0) and (char_details not in char_list)):
            char_list.append(char_details.copy())   # Menambahkan detail karakter ke list (preprocessing: aggregation)
        
        print(f"Scraping row {i} done")

        # Menyimpan hasil scraping dari page karakter (preprocessing: storing)
        with open(f"./Data Scraping/data/generated_JSON/hated_characters_{timestamp}.json", 'w') as outfile:
            json.dump(char_list, outfile, indent=4)        
        with open(f"./Data Scraping/data/generated_JSON/hated_characters_anime_url_{timestamp}.json", 'w') as outfile:
            json.dump(anime_dict, outfile, indent=4)        


def anime_scrape():
    
    """
    Prosedur ini melakukan scraping terhadap laman-laman anime yang disimpan di hated_characters_anime_url.json
    Hasil dari prosedur ini adalah 3 file: anime_list.json, review_list.json, clists_list.json yang masing-masing merupakan
    data detail anime yang discrape, review yang ditemukan untuk semua anime yang discrape, dan semua custom list yang
    relevan dengan anime yang discrape
    """
    
    anime_list = [] # menyimpan detail semua anime yang discrape
    anime_details = {}  # menyimpan detail masing-masing anime

    review_list = []    # menyimpan detail semua review dari anime yang discrape
    review_details = {} # menyimpan detail masing-masing review di setiap anime

    clists_list = []    # menyimpan detail semua custom list yang discrape
    clists_details = {} # menyimpan detail masing-masing custom list yang discrape
    
    user_names = {} # menyimpan user names yang terkait dengan review dan custom lists yang discrape

    # Membaca url anime yang perlu dikunjungi
    with open(f'./Data Scraping/data/generated_JSON/hated_characters_anime_url_{timestamp}.json', 'r') as file:
        anime_dict = json.load(file)

    for title in anime_dict.keys():
        print("==========")
        print(f"Visiting {title}")
        print(f"at URL {anime_dict[title]}")
        start_time = time.time()
        
        time.sleep(5) # menunggu laman termuat
        
        driver.get(anime_dict[title])

        # Mengambil detail anime
        anime_details["title"] = title

        # Menunggu sampai elemen yang dibutuhkan termuat
        anime_details_element = wait.until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "section.pure-g.entryBar"))
        )
        
        # Mengambil dan menyimpan tipe anime
        try:
            # Melakukan preprocessing (parsing) pada teks untuk mengekstrak bagian yang relevan saja
            anime_type = anime_details_element.find_element(By.CSS_SELECTOR, "span.type").text.lower() # hasil anime type formatnya <tipe>(<episode>)
            anime_details["type"] = anime_type.split("(")[0].strip()    # split hasil anime type untuk mendapatkan tipenya saja
            anime_details["episode_count"] = int(anime_type.split("(")[1].split("ep")[0].strip())    # split hasil anime type untuk mendapatkan jumlah episodenya saja
        except:
            print("anime type not found")
        
        # Mengambil dan menyimpan nama studio
        try:
            anime_details_a_tag = anime_details_element.find_elements(By.TAG_NAME, "a")
            for atag in anime_details_a_tag:
                if ("studio" in atag.get_attribute("href")):
                    anime_details["studio"] = atag.text.lower()

        except Exception as e:
            print("studio not found")
            
        # Mengambil dan menyimpan tahun rilisnya
        try:
            anime_details_year = anime_details_element.find_element(By.CSS_SELECTOR, "span.iconYear").text.lower().split("-")[0].strip()
            anime_details["year"] = int(anime_details_year)
        except Exception as e:
            print("year not found")
        
        # Mengambil detail review
        try:
            anime_review_cards = driver.find_elements(By.CSS_SELECTOR, "a.ShortReview.rounded-card")
            review_details["anime_title"] = title
            for cards in anime_review_cards:
                reviewer = cards.find_element(By.CSS_SELECTOR, "span.user__username").text.lower()
                review_details["reviewer"] = reviewer
                user_names[reviewer] = "https://www.anime-planet.com/users/" + reviewer
                
                date = cards.find_element(By.CSS_SELECTOR, "time.ShortReview__date").get_attribute("datetime").split(" ")[0]   # dilakukan split karena detail jam, menit, detik tidak diperlukan
                review_details["date"] = date
                
                score = float(cards.find_element(By.CSS_SELECTOR, "span.ShortReview__rating").text)
                review_details["score"] = score
                
                first_sentence = cards.find_element(By.CSS_SELECTOR, "p.ShortReview__review").text.lower().split(".")[0]    # konten reviewnya dipangkas hanya kalimat pertama
                review_details["first_sentence"] = first_sentence
                
        except Exception as e:
            print(e)
            print("review cards not found")
        
        # Mengambil detail custom lists
        try:
            
            # Menunggu sampai elemen yang dibutuhkan termuat
            anime_clists_cards = wait.until(
                    EC.presence_of_all_elements_located((By.CSS_SELECTOR, "a.CustomList.rounded-card"))
            )
            
            curr_anime_clists = []
            
            for cards in anime_clists_cards:
                
                # Mencari judul custom list dari ref link nya
                list_href = cards.get_attribute("href").split("/")[-1]
                list_title = " ".join([x for x in (list_href.split("-")[:-1]) if "%" not in x])
                clists_details["list_title"] =  list_title # karena judul custom list ada yang memiliki karakter abnormal, maka diperlukan list comprehension seperti ini
                if list_title not in curr_anime_clists:
                    curr_anime_clists.append(list_title)
                
                # Mencari nama pembuat custom list dari ref link nya
                creator = cards.get_attribute("href").split("/")[4]
                clists_details["creator"] = creator
                user_names[creator] = "https://www.anime-planet.com/users/" + creator
                
                
                # Mengambil data jumlah komentar suatu custom list
                try:
                    clists_comments = cards.find_element(By.CSS_SELECTOR, "span.CustomList__comments").text.lower().replace(",", ".")
                    clists_details["list_comments"] = int(clists_comments.strip())
                except:
                    clists_details["list_comments"] = 0
                
                # Mengambil data jumlah likes suatu custom list
                try:
                    clists_likes = cards.find_element(By.CSS_SELECTOR, "span.CustomList__likes").text.lower().replace(",", ".")
                    clists_details["list_likes"] = int(clists_likes)
                except:
                    clists_details["list_likes"] = 0
                
        except Exception as e:
            print(e)
            print("clists not found")
        
        anime_details["contained_in"] = curr_anime_clists.copy()
        
        # Menyimpan detail dari suatu anime ke list anime
        if ((anime_details["title"], anime_details["year"]) not in [(anime["title"], anime["year"]) for anime in anime_list]):
            anime_list.append(anime_details.copy())
            
            print("anime_list done, length: " + str(len(anime_list)))
            
            # Menyimpan detail suatu entitas review ke dalam list review
            if (((review_details["reviewer"], review_details["date"]) not in [(review["reviewer"], review["date"]) for review in review_list])):
                review_list.append(review_details.copy())
                
                print("review_list done, length: " + str(len(review_list)))
            
            # Menyimpan detail dari suatu custom list ke list custom lists
            if (((clists_details["creator"], clists_details["list_title"]) not in [(clists["creator"], clists["list_title"]) for clists in clists_list])):
                clists_list.append(clists_details.copy())
                
                print("clists_list done, length: " + str(len(clists_list)))
                
        print(f"Scraping details for {title} is done")
        end_time = time.time()
        print(f"duration: {(end_time-start_time):.2f}s")    # Menghitung durasi scraping page saat ini
        print(f"progress: {len(anime_list)} / {len(anime_dict)} ; ETA: {(end_time-start_time)*(len(anime_dict)-len(anime_list)):.2f}s") # Menampilkan progress scraping agar bisa memberikan estimasi selesai
        print("==========")
        
        # Statemen di bawah boleh di uncomment untuk testing purposes
        # karena jumlah anime yang discrape ada sekitar 182 judul (~ 25 menit)
        # if (len(anime_list) == 5):
        #     break
        
        # Menyimpan semua informasi anime, review, dan custom list menjadi json    
        with open(f"./Data Scraping/data/generated_JSON/anime_list_{timestamp}.json", "w") as outfile:
            json.dump(anime_list, outfile, indent=4)        
        with open(f"./Data Scraping/data/generated_JSON/review_list_{timestamp}.json", "w") as outfile:
            json.dump(review_list, outfile, indent=4)   
        with open(f"./Data Scraping/data/generated_JSON/clists_list_{timestamp}.json", "w") as outfile:
            json.dump(clists_list, outfile, indent=4)
        with open(f"./Data Scraping/data/generated_JSON/users_url_{timestamp}.json", "w") as outfile:
            json.dump(user_names, outfile, indent=4)

def users_scrape():
    
    """
    Prosedur ini melakukan scraping terhadap laman-laman user yang disimpan di users_url.json
    Hasil dari prosedur ini adalah users.json yang merupakan data detail user yang discrape
    """
    
    users_list = []
    user_details = {}
    
    with open(f'./Data Scraping/data/generated_JSON/users_url_{timestamp}.json', 'r') as file:
        users_dict = json.load(file)
    
    for name in users_dict.keys():
        print("==========")
        print(f"Visiting {name}")
        print(f"at URL {users_dict[name]}")
        start_time = time.time()
        driver.get(users_dict[name])

        user_details["username"] = name
        
        time.sleep(5)   # Menunggu laman termuat
        
        # Menunggu userStats termuat
        user_stats_elements = wait.until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "ul.userStats"))
        )
                
        user_stats = user_stats_elements.find_elements(By.CSS_SELECTOR, "li")
        for stats in user_stats:
            icon_class = stats.find_element(By.TAG_NAME, "i").get_attribute("class")
            if "calendar" in icon_class:    # mencari tanggal daftar user dengan patokan icon calendar
                join_date = " ".join(stats.text.split(" ")[1:])
                user_details["join_date"] = (datetime.strptime(join_date, "%b %d, %Y")).strftime("%Y-%m-%d")    # Mengubah format tanggal daftar user
            if "user" in icon_class:        # mencari umur dan gender user
                try:
                    user_details["age"] = int(stats.text.lower().split("/")[0].strip()) # Mengubah format data umur dari string ke int
                except:
                    user_details["age"] = None
                
                try:
                    user_details["gender"] = stats.text.lower().split("/")[1].strip()    
                    assert ((stats.text.lower().split("/")[1].strip() == "m") or (stats.text.lower().split("/")[1].strip() == "f"))          
                except:
                    user_details["gender"] = None
        
        print(f"Scraping details for {name} is done")
        end_time = time.time()
        print(f"duration: {(end_time-start_time):.2f}s")
        print(f"progress: {len(users_list)} / {len(users_dict)} ; ETA: {(end_time-start_time)*(len(users_dict)-len(users_list)):.2f}s")
        print("==========")
        
        if user_details not in users_list:
            users_list.append(user_details.copy())
        
        with open(f"./Data Scraping/data/generated_JSON/users_{timestamp}.json", 'w') as outfile:
            json.dump(users_list, outfile, indent=4)  
                        
        
if __name__ == "__main__":
    main_url = "https://www.anime-planet.com/characters/top-hated"
    timestamp = datetime.now().strftime('%Y-%m-%d_%Hh%Mm%Ss')

    # Buat objek options dari uc.ChromeOptions()
    options = uc.ChromeOptions()
    # Tambahkan header User-Agent ke dalam options
    # options.add_argument('user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36; 18222047@std.stei.itb.ac.id')
    # Disable pemuatan gambar untuk mempercepat scraping
    options.add_argument('--blink-settings=imagesEnabled=false')
    # Disable penggunaan js agar mempercepat pemuatan laman
    options.add_argument("--disable-javascript")
    # Strategi "eager" membuat selenium tidak menunggu semua sumber daya (resourece) dimuat
    options.page_load_strategy = 'eager'
    # Disable penggunaan ekstensi pada browser untuk mempercepat pemuatan laman
    options.add_argument("--disable-extensions")

    # Inisialisasi webdriver dengan options
    driver = uc.Chrome(options=options)
    # Tambahkan header User-Agent ke dalam options
    driver.header_overrides = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36 ; 18222047@std.stei.itb.ac.id',
    }
    overall_start = time.time()

    # Set dimensi window dan posisinya
    driver.set_window_size(720, 720)
    driver.set_window_position(150, 0)

    # Membuat webdriverwait object untuk digunakan pada expected condition
    wait = WebDriverWait(driver, 15)
    print("driver setup done")

    # Memanggil prosedur untuk scraping karakter
    char_scrape()
    
    # Memanggil prosedur untuk scraping anime
    anime_scrape()
    
    # Memanggil prosedur untuk scraping users
    users_scrape()

    overall_end = time.time()
    print(f"Total scraping duration: {(overall_end-overall_start)//60:.2f} minutes") # Menghitung durasi total proses scraping
    
    for file in os.listdir("Data Scraping/data"):
        if file.endswith('.json'):
            os.remove("Data Scraping/data/"+file)
    all_JSON = [file for file in os.listdir("Data Scraping/data/generated_JSON") if file.endswith('.json')]
    JSON_timestamps = ["_".join(filename.split("_")[-2:]) for filename in all_JSON]
    print(JSON_timestamps)
    for filename in all_JSON:
        print(filename)
        print(max(JSON_timestamps))
        print(filename.endswith(max(JSON_timestamps)))
        if filename.endswith(max(JSON_timestamps)):
            shutil.copy2(f"Data Scraping/data/generated_JSON/{filename}", f"Data Scraping/data/{filename}")
    print("Latest JSONs Refreshed")
            
    driver.quit()
    