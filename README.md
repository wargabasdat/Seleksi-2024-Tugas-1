# Seleksi Tahap 2 Asisten Basis Data 2024
### ETL Project: Data Scraping, Database Modeling, and Data Storing

Hello! I'm Evelyn Yosiana with NIM 13522083. <br>

## Table of Contents
* [Topic and DBMS](#topic-and-dbms)
* [How to Run the Scrapper](#how-to-run-the-scrapper)
* [JSON Structure](#json-structure)
* [How to Convert ERD into Relational Diagram](#how-to-convert-erd-into-relational-diagram)
* [Acknowledgements](#acknowledgements)


## Topic and DBMS
Food is one of the most crucial things in daily life. For this reason, food is also one of the businesses that many people are involved in. Along with the times, many people are turning to healthier foods, one of which is Mediterranean diet foods. This field will be a pretty good prospect in the FNB field. So, in this database laboratory assistant selection task, I chose a topic about “Mediterranean Food Recipe” taken from the food.com web.  The data taken is data about food recipes, users, ingredients, and posts (questions, reviews, and tweaks). The database management system is used to manage the community website. <br>


## How to Run the Scrapper

Clone this repository with the command 
```shell
Git clone https://github.com/evelynnn04/Seleksi-2024-Tugas-1.git
```
Enter the src folder with the command 
```shell
cd Data Scraping/src
```
Run the scrapper with the command 
```shell
scrapper.py 
```
The output of the scrapper run is six json files that will be stored in the "Data Scraping/data" folder: <br>
- Ingredients_[timestamp].json <br>
- Madeof_[timestamp].json <br>
- Recipes_[timestamp].json <br>
- Reviews_[timestamp].json <br>
- Tweaksandquestions_[timestamp].json <br>
- Users_[timestamp].json <br>


## JSON Structure

The ingredients_[timestamp].json file contains a list of dictionaries with attributes: <br>
- ingredient_id: the unique code of the ingredient taken from the link on the web; <br>
- ingredient_name: the name of the ingredient in English; <br>
- season_start: harvest start month; <br>
- season_end: month of harvest end; <br>
- calories: total calories in kcal; <br>
- total_fat: total fat in grams; <br>
- saturated_fat: total saturated fat in grams; <br>
- cholesterol: total cholesterol in milligrams; <br>
- protein: total protein in grams; <br>
- carbohydrate: total carbohydrate in grams; <br>
- fiber: total fiber in grams; <br>
- sugar: total sugar in grams; <br>
- sodium: sodium level in milligrams. <br><br>

The file madeof_[timestamp].json contains a list of dictionaries with attributes:
- food_id: the unique code of the recipe retrieved from the link on the web; <br>
- ingredient_id: the unique code of an ingredient retrieved from a link on the web. <br><br>

The recipes_[timestamp].json file contains a list of dictionaries with attributes:
- food_id: the unique code of the recipe retrieved from the link on the web; <br>
- creator_id: unique code of the recipe author user retrieved from a link on the web; <br>
- food_name: the name of the food in English; <br>
- serving_size: the serving size of one serving in grams; <br>
- calories: total calories in kcal; <br>
- total_fat: total fat in grams; <br>
- saturated_fat: total saturated fat in grams; <br>
- cholesterol: total cholesterol in milligrams; <br>
- protein: total protein in grams; <br>
- carbohydrate: total carbohydrate in grams; <br>
- fiber: total fiber in grams; <br>
- sugar: total sugar in grams; <br>
- sodium: sodium level in milligrams. <br><br>

The file reviews_[timestamp].json contains a list of dictionaries with attributes:
- review_id: a unique code generated with the format review_[food_id]_[increment integer]; <br>
- food_id: the unique code of the recipe being reviewed; <br>
- user_id: the unique code of the user who posted the review; <br>
- content: the review posted by the user; <br>
- rating: the user's rating of the reviewed recipe; <br>
- likes: total accounts that have liked the review. <br><br>

The file tweaks_and_questions_[timestamp].json contains a list of dictionaries with attributes:
- tweak_and_question_id unique code generated with the format [tweak/question]_[food_id]_[increment integer]; <br>
- food_id: the unique code of the recipe being tweaked/questioned; <br>
- user_id: the unique code of the user who provided the tweak/question; <br>
- Content: the tweak/question posted by the user; <br>
- Likes: total accounts that liked the tweak/question; <br><br>

The users_[timestamp].json file contains a list of dictionaries with attributes:
- user_id: unique code of the user taken from a link on the web; <br>
- name: the name of the user; <br>
- username: the unique name used by the user; <br>
- user_rating_avg: the user's rating based on the accumulation of recipes written on a scale of 0 to 5 (in this code, the user_rating_avg data is taken directly from the web display); <br>
- city: the city where the user lives; <br>
- state: the user's country of residence; <br>
- joined_month: the month the user joined; <br>
- joined_year: the year the user joined; <br>
- followers: the total followers of the user (in this code, the followers data is taken directly from the web interface); <br>
- followers: total accounts followed by the user (in this code, the following data is taken directly from the web interface). <br><br>


## How to Convert ERD into Relational Diagram
1. Transform a many to many relations into a new table which contain the primary keys of the two initial tables (for example in a “madeof” relation). <br>
2. For one to many relations, insert the primary key from table “one” into table “many” (for example in the write relation, the primary key of the users table is inserted into the attribute in the recipes table). <br><br>


## Acknowledgements
- This project was based on [Seleksi Tahap 2 Asisten Basis Data 2024](https://docs.google.com/document/d/1Mi0OJNlCIp6ky1uDF-xzhgE-yos3b0ThI24Gvde70gM/edit).
