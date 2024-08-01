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

This ETL project focuses on analyzing passenger reviews for two major Indonesian airlines: Garuda Indonesia and Batik Air. By scraping data from airlinequality.com, this project aims to provide insights into passenger experiences, helping these airlines enhance their services and customer satisfaction. 

## Usage
1. Clone this repository
>
    git clone https://github.com/kaylanamira/TUGAS_SELEKSI_2_13522050.git
2. Install BeautifulSoup and requests library
3. Navigate to src directory
>
    cd Data\ Scraping/src
4. Modify the db config in ```sql_loader.py``` with your own user and password
5. Run python3 main.py
6. Additionally, the sql can be dumped by using ```mysqldump -u {your_user_name} -p {your_db_name} > airline.sql```

## Data Scraping
The primary objective of this project is to extract detailed review data from airlinequality.com, transform it into a JSON structured format, and load it into a MySQL database for comprehensive analysis. This analysis will provide a deep dive into various aspects of passenger experiences, such as service quality, comfort, and overall satisfaction.
#### 1. JSON Structure
The json file in ```Data Scraping/data/airline_reviews.json``` contains the pure data extracted from the scraping process.
>
    {
        "Reviewer": {
            "Name": "Jonathan Rodden",
            "Country": "United Kingdom",
            "Type": "elite"
        },
        "Flight": {
            "Route": "Amsterdam to Jakarta",
            "Aircraft": "Boeing 777-300-ER",
            "Date Flown": "July 2024"
        },
        "Airline": {
            "Name": "Garuda Indonesia",
            "Star": 5
        },
        "Review Details": {
            "Review Text": "an outstanding experience",
            "Review Date": "2024-07-03",
            "Overall Rating": 10,
            "Type Of Traveller": "Family Leisure",
            "Seat Type": "First Class",
            "Seat Comfort": 5,
            "Cabin Staff Service": 5,
            "Food & Beverages": 5,
            "Inflight Entertainment": 4,
            "Ground Service": 5,
            "Wifi & Connectivity": 5,
            "Value For Money": 5,
            "Recommended": true
        }
    }


## Data Modelling and Storing
#### 1. Design
The data is loaded to Mysql. The reason of choosing Mysql as the RDBMS is because 

Some assumptions regarding the db design is as stated in the diagram.

![ERD](./Data%20Storing/design/ERD.png)
![Relational](./Data%20Storing/design/relational.png)

For more detail of translation process, open
[ERD to Relational](https://docs.google.com/document/d/1YF99NFnt15oXDe_dA7ZArG0HlRCYbsNA4lst8M5uVzM/edit?usp=sharing)

#### 2. Constraints and functions
Triggers, constraints and functions are also applied to the db.
- Function to count average rating
- ...
- ...

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
1. Data scraping script
[text](<Data Scraping/screenshot/scraper1.png>)
[text](<Data Scraping/screenshot/scraper1.png>)
2. Data scraping process log
[text](<Data Scraping/screenshot/scrape_process.png>)
3. JSON loading script
4. Tables in database
[text](<Data Storing/screenshot/show_table.png>)
4. Description of tables
[text](<Data Storing/screenshot/all_airline.png>)
[text](<Data Storing/screenshot/all_flight.png>)
[text](<Data Storing/screenshot/all_review.png>)
[text](<Data Storing/screenshot/all_reviewer.png>)
[text](<Data Storing/screenshot/desc 1.png>)
[text](<Data Storing/screenshot/desc 2.png>)
5. Trigger and function
[text](<Data Storing/screenshot/trigger.png>)
[text](<Data Storing/screenshot/function.png>)
[text](<Data Storing/screenshot/function_demo.png>)

## Reference
1. BeautifulSoup
2. JSON
3. mysql.connector
4. mariadb

## Author

Kayla Namira Mariadi - 13522050
