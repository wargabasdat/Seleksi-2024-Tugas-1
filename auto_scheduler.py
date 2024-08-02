# auto_scheduler.py

from apscheduler.schedulers.background import BackgroundScheduler
import datetime
import sys
import time

# Adding the path to the scrapper module
sys.path.append('Data Scraping/src')
import scrapper

def runner_function():
    try:
        print("Inside runner_function - calling scrapper.run_all()")
        scrapper.scrape_all()
        print(f"Running the scheduled task at {datetime.datetime.now()}")
    except Exception as e:
        print(f"Error in runner_function: {e}")

if __name__ == "__main__":
    scheduler = BackgroundScheduler()
    scheduler.add_job(runner_function, 'interval', minutes=1)
    
    try:
        print("Starting scheduler...")
        scheduler.start()
        # Keep the script running
        while True:
            time.sleep(2)
    except (KeyboardInterrupt, SystemExit):
        print("Shutting down scheduler...")
        scheduler.shutdown()
