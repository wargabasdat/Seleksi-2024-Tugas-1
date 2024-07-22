import requests
import time
import pandas as pd
from bs4 import BeautifulSoup

def get_review(review):
    review_dict = {}
    try:
        review_dict['Review Date'] = review.find("meta").get("content")
    except:
        pass
    review_dict['Overall Rating'] = int(review.find('span', attrs={'itemprop':'ratingValue'}).get_text())
    review_dict['Review Title'] = review.find('h2', attrs={'class':'text_header'}).get_text().strip('"').strip('“').strip('“')
    # review_dict['review_content'] =review.find('div', attrs={'class':'text_content'}).get_text()
    table = review.find("table", { "class": "review-ratings" })

    data = table.find_all("td")
    keys = data[::2]
    values = data[1::2]
    for key, value in zip(keys, values):
        key = key.get_text()
        star_value = None
        try:
            star_value = value.find_all("span", { "class": "star fill" })[-1]
        except:
            pass
        if star_value:
            value = star_value.get_text()
        else:
            value = value.get_text()
        review_dict[key] = value
    # print(review_dict)
    return review_dict

def get_reviewer(review):
    reviewer_dict = {}
    reviewer_dict['Name'] = review.find('span', attrs={'itemprop':'name'}).get_text()
    reviewer_dict['Country'] = review.find('h3', attrs={'class':'text_sub_header userStatusWrapper'}).get_text().split('(')[1].split(')')[0]
    try:
        review.find('a', attrs={'a':'userStatus'})
        reviewer_dict['Status'] = 'elite'
        # reviewer_dict['Review Made'] = int(review.find('span', attrs={'itemprop':'author'}).get_text().split(' ')[0])
    except:
        reviewer_dict['Status'] = 'not_verified'
        # reviewer_dict['Review Made'] = 0
    # print(reviewer_dict)
    return reviewer_dict

def scrape_review(url: str) :
    """ Scrape the review from a url."""
    content = requests.get(url).content
    soup = BeautifulSoup(content, "html.parser")
    reviews = soup.find_all('article', attrs={'itemprop':'review'})
    # for review in reviews:
    #     get_reviewer(review)
    #     get_review(review)
    review = reviews[0]
    return review

def scrape_all_review(airline_name, max_reviews: int, pagesize=1):
    reviews_list = []
    review_count = 0
    try_count = 0
    current_page = 1
    while review_count < max_reviews:
        try:
            print(f"Scraping page {current_page}")
            url = f"https://www.airlinequality.com/airline-reviews/{airline_name}/page/{current_page}/?pagesize={pagesize}"
            review = scrape_review(url)
            if review:
                reviewer_data = get_reviewer(review)
                review_data = get_review(review)
                review_data.update(reviewer_data)
                reviews_list.append(review_data)
                try_count = 0  # Reset try count after successful scrape
                review_count += 1
            else:
                print(f"No reviews found on page {current_page}")
                try_count += 1  # Increment try count if no reviews found
            current_page += 1
        except Exception as e:
            print(f"Error on page {current_page}: {e}")
            try_count += 1
        if try_count >= 2:  # Break loop if too many consecutive failures
            print("Too many consecutive failures, stopping scrape.")
            break
        time.sleep(0.5)

    # Save collected reviews to CSV
    # df = pd.DataFrame(reviews_list)
    # df.to_csv(output_file, index=False)
    print(f"Scraped {review_count} reviews..")
    print(reviews_list)

url = 'https://www.airlinequality.com/airline-reviews/garuda-indonesia'
# scrape_review(url)
airline_name = 'garuda-indonesia'
max_reviews = 30
scrape_all_review(airline_name, max_reviews)