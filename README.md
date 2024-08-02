<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  Data and the DBMS
  <br>
</h2>
The database I set up covers basic information about the top 100 stocks in the world at the moment. I took this subject because I'm interested in the stock market and because I believe it's important to know a company's past performance and how it relates to price. Consequently, this database was created. There are things like historical revenue and earnings performance, stock descriptions, stock categories, and other general data.
  <br>

## How to scrape

To scrape the data, I used the BeautifulSoup library in Python. The data was scraped from https://companiesmarketcap.com/. To scrape the 100 companies, i search for the div related to that data. I then, visit related links to extract extra data such as the company's description,category and past performance. The data is then stored in a dictionary and array, to be exported into JSON file.

By using Beautiful soup and some html knowledge, I was able to locate the exact thing I needed to scrape. I then used the requests library to get the data from the website. After that, I used the json library to store the data in a JSON file.

To run the scraper, you can run the following command in the terminal:

```bash
python 'Data Scraping/src/scrape.py'
```

To insert the data into the database, you can run the following command in the terminal:

```bash
python 'Data Scraping/src/insert.py'
```

Make sure you install all the nessecary dependencies before running the scrape code. In the reference section, I have listed all the dependencies used in this project.

To insert to database, you need to have a MySQL server running. You can change the database configuration in the .env file, based on the .env.example file.

If you encounter some sort of coallition error, you can run the following command, please make sure the version of the mysql-connector-python is 8.0.17.

## JSON Structure

After doing some transformation at the scraping process, here is the data that is stored in the final JSON file:

1. Categories.json

```

{
"category_name": string,
"category_description": string
}

```

2. Companies.json

```

{
"company_name": string,
"company_description": string,
"company_country": string
}

```

3. Stocks.json

```

{
"stock_code": string,
"current_price": number,
"current_marketcap": number,
"company_name": string
}

```

4. Performances.json

```

{
"stock_code": string,
"revenue": number,
"earnings": number
}

```

5. Countries.json

```

{
"country_name": string
}

```

6. Company_Category.json

```

{
"company_name": string,
"category_name": string
}

```

## ERD and Relational Model

### 1. ERD

![Alt text](/Data%20Storing/design/ERD.png)

There are 4 strong entities and 1 weak entitiy in this ERD. The strong entities are Company, Stock, Category, and Country. The weak entity is Performance. In short, this is the description for each entity:

1. Company: Contains the company's name and description. Basically the company's general information.
2. Stock: Contains the company's stock information such as the stock's name, price, and market cap.
3. Category: The category that is availabe in this scope
4. Performance: Contains the company's historical performance such as revenue and earnings.
5. Country : Contains the country where the company is located.

The relationship between the entities can be seen in the picture.

### 2. Relational Model

![Alt text](/Data%20Storing/design/Relational%20Model.png)

The relational model is derived from the ERD. The tables are as follows:

1. Company : Contains the company's name, description, and FK reference to Country as the country where the company is located.
2. Stock : Contains the stock's name, price, market cap, and FK reference to Company as the company that the stock belongs to.
3. Category : Contains the category's name and description.
4. Performance : Contains the year revenue, earnings, and FK reference to company table as the company that the performance belongs to.
5. Country : Contains the country's name.
6. Company_Category : Contains the company's name and category's name as the company's category.

## Translation process

The steps to translate from ERD to Relational Model are as follows:

1. Change all strong entities into tables.
2. Change all weak entities into tables with the composition of primary key of the strong entity and the discriminator of the weak entity as PK.
3. Make the many to many relationship into a new table with the primary key of the two entities as the primary key of the new table.

In detail, change the Category, Company, Stock, and Country entities into tables with the PK from ERD as their PK. Then, change the Stock Category relationship into a new table called Stock_category. After that, change the Performance entity into a table with the PK from Company and the year as the PK.

## Screenshots

## Reference

Some libraries used in this project:

1. BeautifulSoup V4.12.2
2. aiohttp V3.10.0
3. mysql-connector-python V8.0.17
4. python-dotenv V1.0.1
5. pandas V1.5.1
6. asyncio V3.4.3

The data is scraped from https://companiesmarketcap.com/

## Author

| Name                      | NIM      | Email                     |
| ------------------------- | -------- | ------------------------- |
| Imanuel Sebastian Girsang | 13522058 | imanuelgirsang1@gmail.com |
