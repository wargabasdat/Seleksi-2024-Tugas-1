# Melakukan import BeautifulSoup dan juga import requests serta json

from bs4 import BeautifulSoup
import requests, json

# Memberikan link tempat data scraping akan dilakukan
url = 'https://editorial.rottentomatoes.com/guide/best-disney-movies-to-watch-now/'

# Menambahkan header untuk melakukan HTTP request
headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'}

#Melakukan HTTP request kepada link untuk mendapatkan semua HTML file yang dibutuhkan
page = requests.get(url, headers=headers)

#Melakukan parsing data menggunakan beautifulsoup
soup = BeautifulSoup(page.text, 'html.parser')

# Menyimpan semua hasil parsing
movies_data = []

#Mencari part yag memiliki kode div dan memiliki kelas bernama articleContentBody, yang merupakan tempat dimana data tersebut disimpan
movies = soup.find('div', class_="articleContentBody").find_all('div', class_="row countdown-item")

for movie in movies:
    # Mencari rank movie dan menyimpannya di variabel movies
    # Memisahkan titik yang ada, dan hanya mengambil angkanya saja
    # Menjadikan semua huruf yang ada menjadi lowercase
    rank = movie.find('div', class_="countdown-index-resposive").text.split('#')[1].lower()

    # Mencari nama movie dan menyimpannya di variabel name
    # Menjadikan semua huruf yang ada menjadi lowercase
    name = movie.find('div', class_="article_movie_title").a.text.lower()

    # Mencari tahun dimana movie tersebut rilis dan menyimpannya di variabel movie
    # Menghilangkan tanda kurung ketika proses scraping
    # Menjadikan semua huruf yang ada menjadi lowercase
    year = movie.find('div', class_="article_movie_title").span.text.strip('()').lower()

    # Mencari rating movie dan menyimpannya di variabel rating
    # Menghilangkan tanda persen ketika proses scraping
    # Menjadikan semua huruf yang ada menjadi lowercase
    rating = movie.find('span', class_="tMeterScore").text.split('%')[0].lower()

    # Mencari artis yang memainkan movie tersebut dan menyimpannya di variabel starring
    # Hanya mengambil nama dari 1 artis saja agar memudahkan untuk pencarian di database
    # Menghilangkan tanda koma yang memisahkan setiap artis yang memainkan film tersebut
    # Menjadikan semua huruf yang ada menjadi lowercase
    starring = movie.find('div', class_="info cast").text.split('Starring: ')[1].split(',')[0].lower()

    # Mencari sutradara yang men-direct movie tersebut dan menyimpannya di variabel director
    # Hanya mengambil nama dari 1 sutradara saja agar memudahkan untuk pencarian di database
    # Menghilangkan tanda koma yang memisahkan setiap sutradara yang men-direct film tersebut
    # Menjadikan semua huruf yang ada menjadi lowercase
    director = movie.find('div', class_="info director").text.split('Directed By: ')[1].split(',')[0].lower()
    
    # Menggabungkan keenam variabel yang dicari ke dalam variabel movie_data
    movie_data = {
        "rank": rank,
        "movie_name": name,
        "year": year,
        "score": rating,
        "artist": starring,
        "director": director
    }
    movies_data.append(movie_data)
    
    # Output untuk memastikan proses scraping berjalan dengan baik
    print(rank, name, year, rating, starring, director)

# Men-dump proses scraping ke dalam file json
with open('Top 100 Disney RottenTomatoes.json', 'w') as json_file:
    json.dump(movies_data, json_file, indent=4)


