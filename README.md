# Introduction
This is a repository for the phase 2 database lab assistant selection 2024 project. This project aims to perform Extract, Transform, and Load (ETL) on the [anime-planet](www.anime-planet.com) website with a focus on the 50 most hated anime characters according to the website's users. The final database will include a total of 9 tables, that you can import from `Data Storing/export`. Why choose this topic? Well... Japanese Animations (anime) are pretty trending since COVID-19 era, so the business is quite booming. Creating a "good" hate-able character or avoiding to make "bad" characters that become hated by the fans is definitely something anime producers have to look out for. So this project is really just so that Japanese animation studios can learn the traits and characteristics of the most hated characters. This can either lead them to make better villains (or characters that play the "hated" role) or maybe avoid these characteristics so that they make enjoyable characters.


This project was created by (Author): Dama Dhananjaya Daliman - 18222047 (18222047@std.stei.itb.ac.id)

# Table of Contents
- [Requirements](#requirements)
- [How to Use Scraper](#how-to-use-scraper)
- [JSON Structure](#json-structure)
- [ERD and RDBMS Structure](#erd-and-relational-dbms-structure)
- [Documentation](#documentation)
- [References](#references)

# Requirements
Python: v12 or newer, with libraries:
- os
- shutil
- selenium
- undetected_chromedriver (for bypassing cloudflare)
- datetime
- time
- json
- pandas
- psycopg2 (for python to interact with PostgreSQL)
PostgreSQL: v15 or newer

# How to Use Scraper
Clone this repository and open the root directory from your preferred IDE.

Run scraper.py in Data Scraping/src. You should see something like this when you run it:
![Data Scraping\screenshot\running (1).png](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/running%20(1).png)

and then voila! The results should be saved into Data Scraping/data

You can then use pandas to make dataframes from the JSONs and manipulate each row to create SQL Insert statements. Then these insert statements can be used to populate your anime_planet database 👍. ( I actually already have a python script for this contact me for more info on that )

# JSON Structure
So, in this project the data is scraped from the website using Python Selenium and then stored in JSON files located at:
```
Data Scraping/data/generated_JSON
```
then the latest scraped data will be transferred to the 
```
Data Scraping/data
```
path


There are 7 main JSON files that are generated through the scraping process:
1. anime_list_{timestamp}.json
2. clists_list_{timestamp}.json
3. hated_characters_anime_url_{timestamp}.json
4. hated_characters_{timestamp}.json
5. review_list_{timestamp}.json
6. users_url_{timestamp}.json
7. users_{timestamp}.json


with each file's contents are described below:

## anime_list_{timestamp}.json
This JSON contains the list of animes that features the top 50 most hated characters. The list contains dictionaries for each anime with these keys:
1. "title" (string): this is the name of the anime
2. "type" (string): this is the type of the anime (e.g. TV, DVD Special, Movie, etc.)
3. "episode_count" (integer): this is the number of episodes the anime has
4. "studio" (string): this is the name of the studio that owns the anime (e.g. Bones, Pierrot, Madhouse, etc.)
5. "year" (integer): this is the year the anime first aired
6. "contained_in" (list of string): list of custom lists that the anime is a part of

## clists_list_{timestamp}.json
This JSON contains the list of custom lists that features the animes scraped in anime_list_{timestamp}.json. The list contains dictionaries for each custom list with these keys:
1. "list_title" (string): this is the name of the custom list
2. "creator" (string): this is the username of the user that made the list
3. "list_comments" (integer): the number of comments that a list has
4. "list_likes" (integer): the number of likes that a list has

## hated_characters_anime_url_{timestamp}.json
This JSON is a dictionary of URLs for all the hated characters scraped in hated_characters_{timestamp}.json. The dictionary contains key-value pairs of strings for each anime with the format "anime_title" : "anime_URL".

## hated_characters_{timestamp}.json
This JSON contains the list of the 50 most hated characters from the website. The list contains dictionaries for each character with these keys:
1. "name" (string): the name of the character
2. "char_url" (string): the URL to the character's page
3. "rank" (string): the rank of the character
4. "avatar_url" (string): the URL to the character's image
5. "char_hates" (integer): the number of hates a character has gotten from the website's users
5. "char_comments" (integer): the number of comments a character has gotten from the website's users
6. "traits" (list of string): the traits assigned to a character by the website
7. "tags" (list of string): the tags assigned to a character by the website
8. "appears_in" (list of string): list of anime titles that features a character

## review_list_{timestamp}.json
This JSON contains the list of reviews from the animes scraped in anime_list_{timestamp}.json. The list contains dictionaries for each review with these keys:
1. "anime_title" (string): the title of the anime being reviewed
2. "reviewer" (string): the username of the user who wrote a review
3. "date" (date as string): the date when a review is written
4. "score" (float): the score given by the reviewer for the anime
5. "first_sentence" (text / string): the first sentence written in the review 

## users_url_{timestamp}.json
This JSON is a dictionary of URLs for all the users that made a review or made a custom list related to the scraped animes from anime_list_{timestamp}.json. The dictionary contains key-value pairs of strings for each user with the format "username" : "user_URL".

## users_{timestamp}.json
This JSON contains the list of user details that  made a review or made a custom list related to the scraped animes from anime_list_{timestamp}.json. The list contains dictionaries for each user with these keys:
1. "username" (string): the username of a user
2. "join_date" (date as string): the date when a user signed up on the website
3. "age" (integer): the age of the user
4. "gender" (char): the gender of the user

# ERD and Relational DBMS Structure
## ERD
The ERD made from the scraped data can be seen in the following diagram:


![ERD](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/ERD_Seleksi%20Basdat_18222047.png)


The ERD consists of 4 entities:
1. Custom_Lists (PK: username, list_title)
2. Users (PK: username)
3. Animes (PK: title, year)
4. Reviews (PK: username, date)
5. Characters (PK: name)
with 2 of them weak entities: Custom_Lists and Reviews. Both of which have the same identifying entity, Users. These entities are designed to be weak entities because with the attributes scraped of off themselves, we cannot uniquely identify each entity. As such, there needs to be an external attribute to help distinguish each entity, thus comes in the username. 


There are also 5 relationships:
1. Creator (weak): Custom_Lists x Users
2. Reviewer (weak): Reviews x Users
3. Contained_in: Custom_Lists x Animes
4. Reviewed: Reviews x Animes
5. Appears_in: Animes x Characters


A few assumptions were made when creating this ERD, those are:
1. The participation of entities in the relationships created here is generalized. Example: An anime in general may not be included in a custom list, but in the scraped dataset all anime must be contained in some custom list. So the participation is generalized to partial participation.

2. The primary key concept is adjusted according to the scraped dataset. Example: In reality two reviews may be created by the same user on the same date, but this phenomenon is not found in the scraped dataset. So it is assumed that the date of the review can be used as a discriminator.

3. Users can only create lists, comments and likes on custom lists are assumed to be inherent attributes of the custom list entity, not attributes derived from the results of "like" or "comment" interactions from users to custom lists.

4. In reality, char_hates and char_comments should be derived attributes from the results of "hate" or "comment" interactions from users to characters. But because the information of all users who "hate" or "comment" on a character cannot be obtained from the scraped website, it is assumed to be an inherent attribute of the character entity.

5. The review sample taken for each anime is only a maximum of 3 reviews that are "featured" on the "overview" page of the anime. So the rating which is a derived attribute on the anime entity does not reflect the overall rating and the actual rating on the anime-planet website.

## RDBMS
The RDBMS made from the ERD can be seen in the following diagram:


![RDBMS](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/Relational%20Diagram_Seleksi%20Basdat_18222047.png)


The final RDBMS design contains 9 relations (tables), namely:
1. Custom_Lists (PK: creator, list_title)
    - creator (varchar): foreign key to Users, describing the creator of the list
    - list_title (varchar): primary key of the relation, describing the name of the list
    - list_comments (int): number of comments a list has
    - list_likes (int): number of likes a list has
2. Users (PK: username)
    - username (varchar): primary key of the relation, describing the username of a user
    - join_date (date): the date a user signed up to the website
    - age (int): the age of the user
    - gender (char): the gender of the user
3. Reviews (PK: reviewer, date, anime_title, anime_year)
    - reviewer (varchar): foreign key to Users, indicating the user who wrote the review
    - date (date): date of the review
    - anime_title (varchar): foreign key to Animes, specifying the anime being reviewed
    - anime_year (int): foreign key to Animes, specifying the year of the anime being reviewed
    - score (float): rating given to the anime by the reviewer
    - first_sentence (text): initial summary of the review
4. Animes_in_Lists (PK: creator, list_title, anime_title, anime_year)
    - creator (varchar): foreign key to Users, indicating the list owner
    - list_title (varchar): foreign key to Custom_Lists, specifying the list where the anime is included
    - anime_title (varchar): foreign key to Animes, specifying the anime in the list
    - anime_year (int): foreign key to Animes, specifying the year of the anime in the list
5. Animes (PK: title, year)
    - title (varchar): primary key of the relation, describing the name of the anime
    - year (int): primary key of the relation, describing the year of the anime
    - type (varchar): describes the type of anime (e.g. "TV", "DVD Special", "Movie", etc.)
    - episode_count (int): number of episodes an anime has
    - studio (varchar): the name of the studio that owns the anime
6. Appears_in (PK: anime_title, anime_year, char_name)
    - anime_title (varchar): foreign key to Animes, specifying the anime where the character appears
    - anime_year (int): foreign key to Animes, specifying the year of the anime where the character appears
    - char_name (varchar): foreign key to Characters, indicating the character appearing in the anime
7. Characters (PK: name)
    - name (varchar): primary key, representing the character's name
    - char_url (varchar): URL link to the character's image
    - rank (varchar): character's hated rank (e.g., '1', '2', '3')
    - avatar_url (varchar): URL link to the character's avatar image
    - char_hates (int): number of users who dislike the character
    - char_comments (int): number of comments related to the character
8. Characters_Traits (PK: name, trait)
    - name (varchar): foreign key to Characters, indicating the character
    - trait (varchar): character's personality trait
9. Characters_Tags (PK: name, tag)
    - name (varchar): foreign key to Characters, indicating the character
    - tag (varchar): keyword or category associated with the character

## How did I get the Relational Design?
These relations or tables were a direct result of decomposing the ERD. The steps taken (roughly) are:
1. Every entity becomes a single relation
2. Any many-to-many relationships become a single relation
3. For one-to-many or many-to-one relationships, the primary key from the entity participating in the "one" side is carried into the relation of the entity participating in the "many" side as a new attribute.


# Documentation

## Scraping
![scrapersource](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/sourcecode.png)
![scraping](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/running%20(1).png)

## Querying
![Query1](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/querying%20(1).png)
![Query2](https://github.com/RunningPie/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/querying%20(2).png)

# References
Libraries used:
1. os
2. shutil
3. selenium
4. undetected_chromedriver (for bypassing cloudflare)
5. datetime
6. time
7. json
8. pandas
9. psycopg2 (for python to interact with PostgreSQL)


Website scraped: [www.anime-planet.com](http://www.anime-planet.com)

Honorable mentions: [StackOverflow](www.stackoverflow.com), [PostgreSQL Docs](https://www.postgresql.org/docs/), and [Draw.io](www.draw.io)
