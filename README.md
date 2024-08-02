## Table of Contents

- [Overview](#overview)
- [Program Specification](#program-specification)
- [Usage](#usage)
- [Data Scraping](#data-scraping)
- [Data Modelling and Storing](#data-modelling-and-storing)
- [Data Visualization and Analysis](#data-visualization-and-analysis)
- [Screenshots](#screenshots)
- [Reference](#reference)
- [Author](#author)

## Overview
Finding a kost (boarding house) in Bandung that fits your needs and budget can be challenging due to the vast number of options available. This ETL project aims to simplify this process by scraping detailed information about kosts in Bandung from infokost.id, cleaning and structuring the data, and then storing it in a MariaDB database. The project also provides insights and analysis on the available kost options through data visualization.

## Program Specification
- Python3: For web scraping, data cleaning.
- Libraries: BeautifulSoup, Requests, json
- MariaDB: For RDBMS

## Usage
1. Clone this repository
>
    git clone https://github.com/zultopia/TUGAS_SELEKSI_2_13522070.git
2. Install BeautifulSoup and requests library

## Data Scraping
1. Scraping Process
The scraping script targets the infokost.id website, extracting details about kosts in Bandung. It iterates through multiple pages to gather comprehensive data, including the name, address, price, facilities, and available room types for each kost.

2. Data Cleaning
The cleaning process includes:

Handling missing values and setting defaults for non-existent fields.
Extracting and normalizing room details such as size, amenities, and pricing.
Ensuring data consistency by standardizing terms (e.g., gender type, furnished status).

#### 3. JSON Structure
The scraped and cleaned data is stored in JSON format, structured to capture all relevant details about each kost and its rooms:
```
{
  "kost_id": {
    "name": "Kost Name",
    "address": "Kost Address",
    "gender": "Putra/Putri/Campur",
    "furnished": "Furnished/Not Furnished",
    "price": "Price Details",
    "facilities": ["Facility 1", "Facility 2"],
    "rooms": [
      {
        "room_name": "Room Name",
        "room_size": "Room Size",
        "room_price": "Room Price",
        "room_facilities": ["Facility 1", "Facility 2"]
      }
    ]
  }
}

```

## Data Modelling and Storing
1. Database Design
The data is stored in a MariaDB database with the following schema:

Owner: Stores details about the owners of kosts.
Kost: Main table for kost data, linked to the Owner.
Room: Stores room-specific details, linked to the Kost.
Facility: Stores general facilities available at each kost.
2. SQL Commands
The script creates the necessary tables in MariaDB, inserts the cleaned data, and applies relevant constraints:

Constraints: Ensures data integrity, such as ensuring non-null fields for essential kost details.
Triggers and Functions: Not implemented in this basic version but can be extended for additional logic (e.g., auto-updating fields).

## Data Visualization and Analysis
1. Key Performance Indicators (KPIs)
Average Room Price: Evaluates the cost distribution across different kosts.
Facilities Analysis: Identifies the most commonly available facilities in kosts.
Room Availability: Analysis of room availability across different kosts and their pricing.

## Screenshots
### 1. Data scraping
![Scraping](<Data Scraping/screenshot/Scraping.jpg>)
### 2. Data Storing
![Scraping](<Data Storing/screenshot/Storing.jpg>)

## Reference
1. BeautifulSoup
2. requests
3. JSON
4. mysql.connector
5. mariadb
6. infokost.id

## Author

Marzuli Suhada M - 13522070