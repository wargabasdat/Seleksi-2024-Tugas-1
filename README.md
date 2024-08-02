<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project
  <br>
</h1>
<p align="center"> 13522102 Hayya Zuhailii Kinasih </p>

## Description
This project uses data of artworks within the collection of the <a href="https://www.metmuseum.org/">Metropolitan Museum of Art</a>, specifically works that are highlighted. The collection displays information on each individual artwork, from its title, where and when it was created, the people or institutions involved in the artwork's creation, the year in which the museum sourced the artwork, and etc. The data is obtained through scraping and then stored within an SQL database using MariaDB. 
## How to Use
1. This program uses the following libraries: requests, json, concurrent.futures, bs4, mariadb. Those libraries need to be installed.
2. Clone this repository.
3. Create a database in MariaDB.
4. Change the connection configuration in `Data Scraping/src/storing.py` according to your database.
5. Run the scraper
```
python 'Data Scraping/src/scraper.py'
```
6. Run the storer
```
python 'Data Scraping/src/storing.py'
```
## JSON Structure
An example of one entry in the JSON file
```json
{
    "id": 838202,
    "title": "Untitled",
    "gallery": 915,
    "date": "1997\u201399",
    "geography": null,
    "culture": null,
    "medium": "Wood, concrete and steel",
    "accnum": "2020.25",
    "credit": "Lila Acheson Wallace and Latin American Art Initiative Gifts",
    "year": 2020,
    "classifications": [
        "Sculpture"
    ],
    "constituents": [
        {
            "name": "Doris Salcedo",
            "role": "Artist"
        },
        {
            "name": "\u00a9 Doris Salcedo",
            "role": "Rights and Reproduction"
        }
    ]
},
```
- id = Unique identifier of an artwork
- title = Title of an artwork
- gallery = The gallery the artwork is being displayed in, if it is being displayed
- date = The date when the artwork was estimated to be created
- geography = The location where the artwork was created
- culture = The culture the artwork came from
- medium = The medium used to create the artwork
- accnum = The accession number of an artwork
- credit = Where the artwork was acquired from
- year = The year the artwork was acquired
- classifications = A list of the classifications of the artwork
- constituents = A list of the names and roles of those involved in the creation of the artwork

## ERD and Relational Diagram
![Entity Relationship Diagram](Data%20Storing/design/erd.png)
Above is the entity relationship diagram.
- The 'artwork' entity describes the attributes of a single artwork. It consists of id (primary key), title, date, geography, culture, medium, accnum, classifications, credit, and year.
- The 'constituent' entity describes the attributes of constituents. It consists of the name (primary key), begin date, and end date.
- The 'art_constituent' relationship connects an artwork and the constituent involved in it, as well as their role. Every constituent must have an artwork attached to them.
- The 'gallery' entity describes the galleries in the museum. It consists of id (primary key) and name.
- The 'on_view' relationship connects an artwork and the gallery it is being displayed in. An artwork can only be in one gallery at a time.
- The 'department' entity describes the departments in the museum. It consists of name (primary key) and begin date.
- The 'located' relationship connects a gallery and the department it resides in. A gallery must have one and only one department.

![Relational Diagram](Data%20Storing/design/relational.png)
Above is the result of the translation of the ERD into a relational database.
- The 'constituent' entity and the 'department' entity become tables with the same attributes as in the ERD.
- The 'gallery' entity becomes a table with the same attributes and an added attribute of 'department' which references the name of a department.
- The 'artwork' entity becomes a table with mostly the same attributes. It has the added attribute 'gallery' that references the id of a gallery. It also lost the 'classification' attribute due to it being multivalued.
- The 'art_constituent' relationship becomes a table because it is many-to-many. It has the primary keys id (referencing an artwork id) and name (referencing a constituent name). It also has the 'role' attribute.
- The classifications previously in the 'artwork' entity becomes it's own table called 'art_classification'. It's primary keys are id (referencing an artwork id) and classification.
## Screenshots

## Reference
1. json
2. bs4
3. mariadb
