CREATE DATABASE food;

\c food

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    "user_id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255),
    "username" VARCHAR(255),
    "user_rating_avg" FLOAT,
    "city" VARCHAR(255),
    "state" VARCHAR(255),
    "joined_year" INT,
    "joined_month" INT,
    "followers" INT,
    "following" INT,
    PRIMARY KEY ("user_id")
);

DROP TABLE IF EXISTS ingredients CASCADE;
CREATE TABLE ingredients (
    "ingredient_id" VARCHAR(255) NOT NULL,
    "ingredient_name" VARCHAR(255) NOT NULL,
    "season_start" VARCHAR(255),
    "season_end" VARCHAR(255),
    "calories" FLOAT,
    "total_fat" FLOAT,
    "saturated_fat" FLOAT,
    "cholesterol" FLOAT,
    "protein" FLOAT,
    "carbohydrate" FLOAT,
    "fiber" FLOAT,
    "sugar" FLOAT,
    "sodium" FLOAT,
    PRIMARY KEY ("ingredient_id"),
    CONSTRAINT "season_start_check"
        CHECK("season_start" IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')),
    CONSTRAINT "season_end_check"
        CHECK("season_end" IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'))
);

DROP TABLE IF EXISTS recipes CASCADE;
CREATE TABLE recipes (
    "food_id" VARCHAR(255) NOT NULL,
    "creator_id" VARCHAR(255) NOT NULL,
    "food_name" VARCHAR(255),
    "serving_size" FLOAT,
    "calories" FLOAT,
    "total_fat" FLOAT,
    "saturated_fat" FLOAT,
    "cholesterol" FLOAT,
    "protein" FLOAT,
    "carbohydrate" FLOAT,
    "fiber" FLOAT,
    "sugar" FLOAT,
    "sodium" FLOAT,
    PRIMARY KEY ("food_id")
);

DROP TABLE IF EXISTS madeof;
CREATE TABLE madeof (
    "food_id" VARCHAR(255) NOT NULL,
    "ingredient_id" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("food_id", "ingredient_id"),
    CONSTRAINT "fk_food_id_made_of"
   	 FOREIGN KEY ("food_id")
   	 REFERENCES recipes ("food_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE,
    CONSTRAINT "fk_ingredient_id_made_of"
   	 FOREIGN KEY ("ingredient_id")
   	 REFERENCES ingredients ("ingredient_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE
);

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    "review_id" VARCHAR(255) NOT NULL,
    "food_id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "rating" FLOAT,
    "likes" FLOAT,
    PRIMARY KEY ("review_id"),
    CONSTRAINT "fk_food_id_reviews"
   	 FOREIGN KEY ("food_id")
   	 REFERENCES recipes ("food_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE,
    CONSTRAINT "fk_user_id_reviews"
   	 FOREIGN KEY ("user_id")
   	 REFERENCES users ("user_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tweaksandquestions;
CREATE TABLE tweaksandquestions (
    "tweak_and_question_id" VARCHAR(255) NOT NULL,
    "food_id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "likes" FLOAT,
    PRIMARY KEY ("tweak_and_question_id"),
    CONSTRAINT "fk_food_id_tweaks_and_questions"
   	 FOREIGN KEY ("food_id")
   	 REFERENCES recipes ("food_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE,
    CONSTRAINT "fk_user_id_tweaks_and_questions"
   	 FOREIGN KEY ("user_id")
   	 REFERENCES users ("user_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE
);

INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('221', 'CHICKEN', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('125', 'LEMON', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('55', 'LEMON JUICE', 'January', 'December', '53.0', '0.6', '0.1', '0.0', '0.9', '16.8', '0.7', '6.1', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('495', 'OLIVE OIL', 'January', 'December', '1909.0', '216.0', '29.8', '0.0', '0.0', '0.0', '0.0', '0.0', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('165', 'GARLIC', 'January', 'December', '4.0', '0.0', '0.0', '0.0', '0.2', '0.9', '0.1', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('359', 'SALT', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '6976.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('337', 'PEPPER', 'January', 'December', '5.0', '0.1', '0.0', '0.0', '0.2', '1.5', '0.6', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('151', 'TOMATO', 'January', 'December', '79.0', '2.7', '0.5', '0.0', '2.0', '13.2', '1.7', '0.0', '459.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('13', 'CAPER', 'January', 'December', '1.0', '0.1', '0.0', '0.0', '0.2', '0.4', '0.3', '0.0', '254.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('317', 'BASIL', 'January', 'December', '1.0', '0.0', '0.0', '0.0', '0.2', '0.1', '0.1', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('190', 'AVOCADO', 'January', 'December', '321.0', '29.5', '4.3', '0.0', '4.0', '17.1', '13.5', '1.3', '14.0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('11176', 'SANDI (', '@Sandi From CA', '4.7', 'Arcadia', ' California', '2001', '06', '108', '12');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2003135967', 'SD S', '@<script>alert(document.cookie)</script>', NULL, NULL, NULL, '2024', '04', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001693157', NULL, '@cwiley55', NULL, NULL, NULL, '2017', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002470084', NULL, '@annagram54', NULL, NULL, NULL, '2019', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002091378', NULL, '@Lisa S.', NULL, NULL, NULL, '2018', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('239767', 'LIZ S', '@McGelby', '4.2', NULL, NULL, '2005', '08', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001492522', 'CHRISTOPHER C', '@Christopher C.', NULL, NULL, NULL, '2017', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002974579', NULL, '@Jackie B.', NULL, NULL, NULL, '2021', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('735767', NULL, '@Fighting Irish #7', NULL, NULL, NULL, '2008', '01', '2', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002012581', 'KELLI W', '@kelliwarrick16', NULL, NULL, NULL, '2018', '02', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('481092', 'VICKI B', '@Vicki in CT', '4.7', 'tolland', ' 45', '2007', '04', '46', '1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('178249', 'MEDITERRANEAN CHICKEN BREASTS WITH AVOCADO TAPENADE', '11176', '222', '277.1', '16.4', '2.5', '75.5', '26.4', '6.9', '3.2', '1.5', '914.6');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '221');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('178249', '190');
INSERT INTO reviews (review_id, food_id, user_id, content, rating, likes) VALUES ('review_178249_1', '178249', '239767', 'DH and I made this for dinner last night and our only complaint was that we ate too much becuase it was so good! Only change I made was used garlic powder instead of roasted garlic in the tapenade as we were short on time. Thank you for posting.
See More  ', '5.0', '3');
INSERT INTO reviews (review_id, food_id, user_id, content, rating, likes) VALUES ('review_178249_2', '178249', '2001492522', 'Great dish to make and serve right off the grill. Flavor was so wonderful.
 ', '5.0', '1');
INSERT INTO reviews (review_id, food_id, user_id, content, rating, likes) VALUES ('review_178249_3', '178249', '2002974579', 'Absolutely loved this! We fought over who was getting the left overs for lunch. It was equally as delicious as left overs. I added feta cheese. I may cut the lemon juice down in the veggies the next time.
 ', '5.0', '1');
INSERT INTO reviews (review_id, food_id, user_id, content, rating, likes) VALUES ('review_178249_4', '178249', '735767', 'This has so much flavor and easy to make! This is will be a new regular at our house!! I served it with some angel hair with a little garlic and olive oil....home run:)
 ', '5.0', '1');
INSERT INTO reviews (review_id, food_id, user_id, content, rating, likes) VALUES ('review_178249_5', '178249', '2002012581', 'This was ABSOLUTELY delicious!!! My family loved it and had seconds! I doubled it so my husband and I finished it last night. We sprinkled a little bit of feta on top as well. Thank you for sharing your recipe!
 ', '5.0', '1');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('question_178249_1', '178249', '2003135967', 'Can kalamata olives be substituted for the green olives?
 ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('question_178249_2', '178249', '2001693157', 'Can kalamata olives be substituted for the green olives?
 ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('question_178249_3', '178249', '2002470084', 'I know it would be delicious, but must the chicken be grilled? Can it be baked in the oven?
 ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('question_178249_4', '178249', '2002091378', 'How many calories sodium and carbs in this meal
 ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('tweak_178249_1', '178249', '2003135967', 'I bought a very cheap roast and stabbed it all over with a fork (just to make sure that it was dead).
 ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('tweak_178249_2', '178249', '239767', 'DH and I made this for dinner last night and our only complaint was that we ate too much becuase it was so good! Only change I made was used garlic powder instead of roasted garlic in the tapenade as we were short on time. Thank you for posting.
See More  ', '0');
INSERT INTO tweaksandquestions (tweak_and_question_id, food_id, user_id, content, likes) VALUES ('tweak_178249_3', '178249', '481092', 'Excellent! Perfect summer dish with the easy to grill chicken and the cool topping. I just used lemon pepper on the chicken instead of juice and peel. Very good. Thanks for posting.
 ', '0');