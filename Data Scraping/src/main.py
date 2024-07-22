import datetime
from scraper import *
from sql_loader import *

def log(message):
    with open("log.txt", "a") as log_file:
        log_file.write(f"{datetime.datetime.now()}: {message}\n")
        
def main():
    airlines = ["garuda-indonesia", "batik-air"]
    max_reviews_per_airline = 20
    all_reviews = []

    for airline in airlines:
        reviews = scrape_airline_reviews(airline, max_reviews_per_airline)
        all_reviews.extend(reviews)
        log(f"Scraped {len(reviews)} reviews from {airline}")

    save_to_json(all_reviews)
    log("Saved all reviews to JSON")
    
    create_schema()
    load_data()
    log("Loaded data to database")

if __name__ == "__main__":
    main()
