## Table of Contents

- [Overview](#overview)
- [Setup](#setup)
- [Usage](#usage)
- [Author](#author)
- [References](#references)

## Overview
The airline industry is a vital part of global transportation, impacting millions of travelers worldwide. Understanding passenger satisfaction is crucial for airlines to improve their services and remain competitive.Understanding passengers feedback and where improvements are needed is critical for maintaining a competitive edge in the airline industry.

This ETL project focuses on analyzing passenger reviews for two major Indonesian airlines: Garuda Indonesia and Batik Air. By scraping data from airlinequality.com, this project aims to provide insights into passenger experiences, helping these airlines enhance their services and customer satisfaction. 

## How to Use

## JSON Structure


## Data Scraping
The primary objective of this project is to extract detailed review data from airlinequality.com, transform it into a JSON structured format, and load it into a MySQL database for comprehensive analysis. This analysis will provide a deep dive into various aspects of passenger experiences, such as service quality, comfort, and overall satisfaction.

## Data Modeling + Data Storing

## 📈 Data Visualization and Analysis
For data analysis, there are several KPIs to be considered.
#### Key Performance Indicators (KPIs)
- **Review Count**: This metric represents the total number of reviews submitted.
- **Recommendation Percentage**: This metric shows the percentage of reviewers who would recommend the airline.
- **Average Overall Rating**: This metric compares the performance of each airline based on overall ratings.
- **Average Rating per Category and Comparison for Each Airline**: This comparison helps airlines understand which service categories are essential for passenger satisfaction and identify areas for improvement.
- **Overall Rating Trends (in Year)**: This metric tracks the overall rating trends over the years.
- **Correlation between Ratings and Seat Type**: This metric determines how seat type (economy, business, first class) impacts overall satisfaction and identifies any seat-related issues.
- **Correlation between Travelling Type and Ratings**: This metric evaluates how different traveling purposes (business, family leisure, solo leisure, couple leisure) affect overall satisfaction.
- **Reviewer's Country Distribution**: This metric shows the geographic distribution of reviewers.

#### Visualization
The dashboard are developed using Tableau. Viewers can use filter to switch between airline data, hover over the charts for detailed information, and navigate to the Insights Page for a deeper analysis based on the KPIs.

For full dashboard view and interactivity, follow this link : [Airline Reviews Dashboard](https://public.tableau.com/views/AirlineReviews_17217096557510/OverviewDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The walkthrough of the dashboard's usage can be seen from 
![Dashboard Overview Page](./Data%20Visualization/dashboard_overview.png)
![Dashboard Insight Page](./Data%20Visualization/dashboard_insight.png)

#### Insights Conclusion
1. **Airline Comparison**:
   - Garuda Indonesia has higher overall rating and recommendation percentage compared to Batik Air.
   - Both airlines have strengths in Cabin Staff Service and Seat Comfort.
   - Both airlines need improvement in Wifi & Connectivity and addressing the declining trend in overall ratings.

2. **Seat Type**:
   - First Class and Business Class tend to have higher satisfaction rates.
   - Economy and Premium Economy Class requires significant improvements, especially because majority of the reviewers travel in Economy.

4. **Traveling Type**:
   -  Majority of reviewers travel in Solo and Business leisure. However, Solo and Family travelers tend to be more satisfied compared to Business and Couple travelers. This means that both airlines need to improve the service for both leisure, and keep up the service for Solo travelers.

## Author

Kayla Namira Mariadi - 13522050
