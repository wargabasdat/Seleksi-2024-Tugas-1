import json
import logging
import mysql.connector
from dotenv import load_dotenv
import os
from datetime import datetime, timedelta
import calendar

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load db environment variables from .env file and connect to db
load_dotenv()

db_host = os.getenv("DB_HOST")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_database = os.getenv("DB_DATABASE")

conn = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    database=db_database
)

# Load JSON data
with open("./Data Scraping/data/branches.json") as f:
    branches = json.load(f)

with open("./Data Scraping/data/classes.json") as f:
    classes = json.load(f)

with open("./Data Scraping/data/schedule.json") as f:
    schedule = json.load(f)

cursor = conn.cursor()

# Helper function to get or insert instructor
def get_or_insert_instructor(instructor_name):
    # Check whether the instructor exists
    cursor.execute("""
        SELECT instructor_id FROM instructor WHERE instructor_name = %s
    """, (instructor_name,))
    result = cursor.fetchone()
    
    if result: # Instructor exists, return ID
        return result[0]
    
    # Instructor doesn't exist, insert instructor data to database
    cursor.execute("""
        INSERT INTO instructor (instructor_name) VALUES (%s)
    """, (instructor_name,))

    conn.commit()
    return cursor.lastrowid  # Return ID of last row

# Helper function to get or insert class
def get_or_insert_class(class_name, category, difficulty, duration):
    # Check whether the class exists
    cursor.execute("""
        SELECT class_id FROM class WHERE class_name = %s
    """, (class_name,))
    result = cursor.fetchone()
    
    if result:
        # Class exists, return ID
        return result[0]
    
    # Class doesn't exist, insert class data to database
    cursor.execute("""
        INSERT INTO class (class_name, category, difficulty, duration)
        VALUES (%s, %s, %s, %s)
    """, (class_name, category, difficulty, duration))
    conn.commit()
    return cursor.lastrowid  # Return ID of last row

# Insert branches
for branch in branches:
    cursor.execute("""
        INSERT INTO branch (branch_name, address, region)
        VALUES (%s, %s, %s)
    """, (branch["branch_name"], branch["address"], branch["region"]))

conn.commit()
logging.info("Successfully saved branch data")

# Insert classes
for cls in classes:
    cursor.execute("""
        INSERT INTO class (class_name, category, difficulty, duration)
        VALUES (%s, %s, %s, %s)
    """, (cls["class_name"], cls["category"], cls["difficulty"], cls["duration"]))

conn.commit()
logging.info("Successfully saved class data")

# Get the current date and day of the week
current_date = datetime.now()
current_weekday = current_date.weekday()

# Helper function to get a date from this week's day of the week
def get_weekday_date(target_weekday, reference_date):
    days_ahead = target_weekday - reference_date.weekday()
    return reference_date + timedelta(days_ahead)

# Insert schedule
for day, day_schedule in schedule.items():
    target_weekday = list(calendar.day_name).index(day)
    target_date = get_weekday_date(target_weekday, current_date)
    
    for item in day_schedule:
        # Get corresponding branch_id from branch_name
        cursor.execute("""
            SELECT branch_id FROM branch WHERE branch_name = %s
        """, (item["branch_name"],))
        branch_id = cursor.fetchone()[0]

        # Get corresponding class_id from class_name
        class_id = get_or_insert_class(item["class_name"], item["category"], item["difficulty"], item["duration"])

        # Get corresponding instructor_id from instructor
        instructor_id = get_or_insert_instructor(item["instructor"])

        # Get class datetime
        class_time_str = item["class_time"]
        class_datetime = datetime.combine(target_date, datetime.strptime(class_time_str, "%H:%M").time())

        # Insert into schedule
        cursor.execute("""
            INSERT INTO schedule (branch_id, class_datetime, class_id, instructor_id)
            VALUES (%s, %s, %s, %s)
        """, (branch_id, class_datetime, class_id, instructor_id))

# Commit all changes to db
conn.commit()
logging.info("Successfully saved schedule and instructor data")

# Close db connection
cursor.close()
conn.close()
