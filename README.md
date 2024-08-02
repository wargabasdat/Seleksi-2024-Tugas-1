## Table of Contents

- [Overview](#overview)
- [Usage](#usage)
- [Data Scraping](#data-scraping)
- [Data Modelling and Storing](#data-modelling-and-storing)
- [Data Visualization and Analysis](#data-visualization-and-analysis)
- [Screenshots](#screenshots)
- [Reference](#reference)
- [Author](#author)

## Overview
The airline industry is a vital part of global transportation, impacting millions of travelers worldwide. Understanding passenger satisfaction is crucial for airlines to improve their services and remain competitive.Understanding passengers feedback and where improvements are needed is critical for maintaining a competitive edge in the airline industry.

This ETL project focuses on analyzing passenger reviews for two major Indonesian airlines: Garuda Indonesia and Batik Air. By scraping data, this project aims to provide insights into passenger experiences, helping these airlines enhance their services and customer satisfaction. 

The primary objective of this project is to extract detailed review data from [airlinequality.com](https://www.airlinequality.com/), clean it, transform it into a JSON format, and load it into a MySQL database. Additionally, this project provide an analysis into various aspects of passenger experience by data visualization.

## Program Specification
- **Python3**: For web scraping, data cleaning.
Libraries: BeautifulSoup, Requests
- **MySQL**: For RDBMS
- **Tableau**: For data visualization and dashboard creation.

## Usage
1. Clone this repository
>
    git clone https://github.com/kaylanamira/TUGAS_SELEKSI_2_13522050.git
2. Install BeautifulSoup and requests library
3. Navigate to src directory
>
    cd Data\ Scraping/src
4. Modify the db config in ```sql_loader.py``` with your own user and password
5. Run main program
>
    python3 main.py
7. Additionally, the sql can be dumped by using command
>
    mysqldump -u {your_user_name} -p {your_db_name} > airline.sql

## Data Scraping
#### 1. Scraping process
#### 2. Data Cleaning
The cleaning process includes:
- Convert numerical value to int
- Handle missing values and change 'N/A' values to None
- Convert categorical values(yes/no) to boolean(true/false)
- Strip weird characters
- Strip whitespace
- Parse and format dates to datetime

#### 3. JSON Structure
The json file in ```Data Scraping/data/airline_reviews.json``` contains the pure data extracted and cleaned from the scraping process.
>
    {
        "Reviewer": {
            "Name": The name of the reviewer
            "Country": The country of the reviewer
            "Type": The membership type of the reviewer
        },
        "Flight": {
            "Route": The flight route, e.g., "Amsterdam to Jakarta"
            "Aircraft": The type of aircraft used for the flight, e.g., "Boeing 777-300-ER"
            "Date Flown": The month and year when the flight took place, e.g., "July 2024"
        },
        "Airline": {
            "Name": The name of the airline being reviewed (Garuda Indonesia or Batik Air).
            "Star": The star rating of the airline, e.g., 5
        },
        "Review Details": {
            "Review Text": The content of the review, e.g., "An outstanding experience"
            "Review Date": The date when the review was posted
            "Overall Rating": The overall rating given by the reviewer, on a scale from 1 to 10
            "Type Of Traveller": "The type of traveler, e.g., "Family Leisure"
            "Seat Type": The type of seat used, e.g., "First Class"
            "Seat Comfort": The rating for seat comfort, on a scale from 1 to 5
            "Cabin Staff Service": The rating for cabin staff service, on a scale from 1 to 5
            "Food & Beverages": The rating for Food & Beverages, on a scale from 1 to 5
            "Inflight Entertainment": 
            "Ground Service": The rating for ground service, on a scale from 1 to 5
            "Wifi & Connectivity": The rating for wifi and connectivity, on a scale from 1 to 5.
            "Value For Money": The rating for value for money, on a scale from 1 to 5
            "Recommended": A boolean indicating whether the reviewer recommends the airline
        }
    }


## Data Modelling and Storing
#### 1. ERD and Relational Design
The scraped data is stored in a MySQL database. The choice of MySQL was based on its efficiency, ease of use, and strong performance in handling read-heavy operations. The schema consists of 6 tables, but the the data from scraping will only be stored in 4 tables. 
There are some assumptions regarding the db design:
- A reviewer dont have to be a member to create a review
- There are 4 type of registered member: 'elite', 'flyer', 'globethrotter', and 'hiflyer'
- A reviewer can create many review
- An airline can have many reviewed flight
- A flight can be reviewed more than once
- A review corresponds to exactly one flight and one user
- 'overall_rating' in the Review schema is user-defined in this context, not from average rating calculation
- Some attributes are not informed, like the time of flight, reviewer's email and password
- Some rating attribute can be null because not all of them is rated by user
![ERD](./Data%20Storing/design/ERD.png)
![Relational](./Data%20Storing/design/relational.png)

The ERD is translated to Relational by process:
- Reduce strong entity set (Review, Airline, Flight) to schema with the same attributes
- Flatten composite attribute (‘Rating_component’ attribute in the Review entity)
- Represent User specialization by forming new schema for Reviewer and Airline_Staff with inherited attributes from User
- Represent many-to-one relationship by adding the primary key of “the one side” as extra attribute  to “the many side” 
   - Review and Reviewer: Add ‘reviewer_id’ to Review (many side)
   - Review and Flight: Add ‘flight_id’ to Review (many side)
   - Flight and Airline: Add ‘airline_id’ to Flight (many side)	
   - Review and Response: Add ‘response_id’ to Review (many_side)
   - Response and Airline_Staff: Add ‘staff_id’ to Response
   - Airline and Airline_Staff:  Add ‘airline_id’ to Airline_Staff(many side)

For more detail of translation process, open
[ERD to Relational](https://docs.google.com/document/d/1YF99NFnt15oXDe_dA7ZArG0HlRCYbsNA4lst8M5uVzM/edit?usp=sharing)

#### 2. Constraints and functions
Triggers, constraints and functions are also applied to the db.
- Check to ensure membership type of user  is 'elite', 'flyer', 'hiflyer', 'globetrotter', or 'nonmember'
- Trigger to prevent downgrading a reviewer's membership type to nonmember if it was previously a higher type
- Trigger to ensure that the review date is not in the future
- Trigger to ensure that the response date is not earlier than the review date
- Function to count average overall rating of an airline

## Data Visualization and Analysis
For data analysis, there are several KPIs to be considered.
#### 1. Key Performance Indicators (KPIs)
- **Review Count**: This metric represents the total number of reviews submitted.
- **Recommendation Percentage**: This metric shows the percentage of reviewers who would recommend the airline.
- **Average Overall Rating**: This metric compares the performance of each airline based on overall ratings.
- **Average Rating per Category and Comparison for Each Airline**: This comparison helps airlines understand which service categories are essential for passenger satisfaction and identify areas for improvement.
- **Overall Rating Trends (in Year)**: This metric tracks the overall rating trends over the years.
- **Correlation between Ratings and Seat Type**: This metric determines how seat type (economy, business, first class) impacts overall satisfaction and identifies any seat-related issues.
- **Correlation between Travelling Type and Ratings**: This metric evaluates how different traveling purposes (business, family leisure, solo leisure, couple leisure) affect overall satisfaction.
- **Reviewer's Country Distribution**: This metric shows the geographic distribution of reviewers.

#### 2. Visualization
The dashboard are developed using Tableau. Viewers can use filter to switch between airline data, hover over the charts for detailed information, and navigate to the Insights Page for a deeper analysis based on the KPIs.

For full dashboard view and interactivity, follow this link : [Airline Reviews Dashboard](https://public.tableau.com/views/AirlineReviews_17217096557510/OverviewDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The walkthrough of the dashboard's usage can be seen from 
![Dashboard Overview Page](./Data%20Visualization/dashboard_overview.png)
![Dashboard Insight Page](./Data%20Visualization/dashboard_insight.png)

#### 3. Insights Conclusion
- **Airline Comparison**:
   - Garuda Indonesia has higher overall rating and recommendation percentage compared to Batik Air.
   - Both airlines have strengths in Cabin Staff Service and Seat Comfort.
   - Both airlines need improvement in Wifi & Connectivity and addressing the declining trend in overall ratings.

- **Seat Type**:
   - First Class and Business Class tend to have higher satisfaction rates.
   - Economy and Premium Economy Class requires significant improvements, especially because majority of the reviewers travel in Economy.

- **Traveling Type**:
   -  Majority of reviewers travel in Solo and Business leisure. However, Solo and Family travelers tend to be more satisfied compared to Business and Couple travelers. This means that both airlines need to improve the service for both leisure, and keep up the service for Solo travelers.

## Screenshots
### 1. Data scraping
![Scraping](<Data Scraping/screenshot/scraper1.png>)
![Scraping](<Data Scraping/screenshot/scraper2.png>)
![Scraping](<Data Scraping/screenshot/scrapeprocess.png>)
### 2. JSON loading 
![Scraping](<Data Scraping/screenshot/scraper3.png>)
### 3. Tables in database
![Scraping](<Data Storing/screenshot/show_table.png>)
### 4. Description of table
![Scraping](<Data Storing/screenshot/desc_1.png>)
![Scraping](<Data Storing/screenshot/desc_2.png>)
![Scraping](<Data Storing/screenshot/all_airline.png>)
![Scraping](<Data Storing/screenshot/all_flight.png>)
![Scraping](<Data Storing/screenshot/all_review.png>)
![Scraping](<Data Storing/screenshot/all_reviewer.png>)
### 5. Trigger and function
![trigger](<Data Storing/screenshot/trigger.png>)
![function](<Data Storing/screenshot/function.png>)
![function](<Data Storing/screenshot/function_demo.png>)

## Reference
1. BeautifulSoup
2. requests
3. JSON
4. mysql.connector
5. mariadb
6. tableau
7. https://www.airlinequality.com/airline-reviews/garuda-indonesia/ and https://www.airlinequality.com/airline-reviews/batik-air/

## Author

Kayla Namira Mariadi - 13522050
