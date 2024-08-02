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

DROP TABLE IF EXISTS posts CASCADE;
CREATE TABLE posts (
    "post_id" VARCHAR(255) NOT NULL,
    "food_id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "likes" FLOAT,
    "type" VARCHAR(255) NOT NULL,
    PRIMARY KEY ("post_id", "food_id"),
    CONSTRAINT "fk_food_id_posts"
   	 FOREIGN KEY ("food_id")
   	 REFERENCES recipes ("food_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE,
    CONSTRAINT "fk_user_id_posts"
   	 FOREIGN KEY ("user_id")
   	 REFERENCES users ("user_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE,
    CONSTRAINT "post_type_check"
        CHECK("type" IN ('review', 'tweak', 'question'))
);

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    "post_id" VARCHAR(255) NOT NULL,
    "food_id" VARCHAR(255) NOT NULL,
    "rating" FLOAT,
    PRIMARY KEY ("post_id", "food_id"),
    CONSTRAINT "fk_post_id_posts"
   	 FOREIGN KEY ("post_id", "food_id")
   	 REFERENCES posts ("post_id", "food_id")
   	 ON DELETE CASCADE
   	 ON UPDATE CASCADE
);


INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('151', 'TOMATO', 'January', 'December', '79.0', '2.7', '0.5', '0.0', '2.0', '13.2', '1.7', '0.0', '459.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('315', 'YOGURT', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('349', 'TURMERIC', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('983', 'CORIANDER', 'January', 'December', '14.0', '0.9', '0.0', '0.0', '0.6', '2.7', '2.1', '0.0', '1.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('324', 'CINNAMON', 'January', 'December', '19.0', '0.1', '0.0', '0.0', '0.3', '6.3', '4.1', '0.2', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('512', 'CREMINI MUSHROOM', 'January', 'December', '3.0', '0.1', '0.0', '0.0', '0.6', '0.6', '0.2', '0.4', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('332', 'MUSTARD, PREPARED', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('26', 'FETA CHEESE', 'January', 'December', '396.0', '31.9', '22.4', '133.5', '21.3', '6.1', '0.0', '6.1', '1674.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('49', 'TAHINI', 'January', 'December', '85.0', '7.2', '1.0', '0.0', '2.7', '3.9', '1.4', '0.0', '11.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('467', 'PARMESAN CHEESE', 'January', 'December', '431.0', '28.6', '17.3', '88.0', '38.5', '4.1', '0.0', '0.9', '1529.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('224', 'CHOCOLATE', 'January', 'December', '145.0', '15.2', '9.4', '0.0', '3.7', '8.7', '4.8', '0.3', '6.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('746', 'MOZZARELLA', 'January', 'December', '159.0', '0.0', '0.0', '20.3', '35.8', '4.0', '2.0', '1.7', '839.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('657', 'TORTILLA', 'January', 'December', '52.0', '0.7', '0.1', '0.0', '1.4', '10.7', '1.5', '0.2', '10.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('220', 'CHICKPEA', 'January', 'December', '285.0', '2.7', '0.3', '0.0', '11.9', '54.3', '10.6', '0.0', '717.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('112', 'MANZANILLA OLIVE', 'January', 'December', '3.0', '0.4', '0.1', '0.0', '0.0', '0.1', '0.1', '0.0', '42.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('363', 'GREEN ONION', 'January', 'December', '32.0', '0.2', '0.0', '0.0', '1.8', '7.3', '2.6', '2.3', '16.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('359', 'SALT', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '6976.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('125', 'LEMON', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('350', 'VANILLA', 'January', 'December', '599.0', '0.1', '0.0', '0.0', '0.1', '26.3', '0.0', '26.3', '18.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('106', 'POTATO', 'January', 'December', '118.0', '0.1', '0.0', '0.0', '2.5', '27.4', '2.4', '1.2', '5.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('525', 'CIDER VINEGAR', 'January', 'December', '50.0', '0.0', '0.0', '0.0', '0.0', '2.2', '0.0', '1.0', '11.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('292', 'ROMAINE LETTUCE', 'January', 'December', '7.0', '0.1', '0.0', '0.0', '0.6', '1.5', '1.0', '0.6', '3.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('680', 'VINEGAR', 'January', 'December', '42.0', '0.0', '0.0', '0.0', '0.0', '0.1', '0.0', '0.1', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('498', 'BLACK OLIVE', 'January', 'December', '5.0', '0.5', '0.1', '0.0', '0.0', '0.3', '0.1', '0.0', '32.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('297', 'SHRIMP', 'January', 'December', '60.0', '0.9', '0.1', '107.1', '11.6', '0.8', '0.0', '0.0', '481.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('213', 'CARROT', 'January', 'December', '25.0', '0.1', '0.0', '0.0', '0.6', '5.8', '1.7', '2.9', '42.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('493', 'WINE VINEGAR', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('110', 'MUSHROOM', 'January', 'December', '2.0', '0.0', '0.0', '0.0', '0.3', '0.3', '0.1', '0.2', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('203', 'LAMB', 'January', 'December', '230.0', '15.3', '6.3', '81.6', '21.7', '0.0', '0.0', '0.0', '61.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('127', 'SHALLOT', 'January', 'December', '7.0', '0.0', '0.0', '0.0', '0.2', '1.7', '0.0', '0.0', '1.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('217', 'CHARD', 'January', 'December', '9.0', '0.1', '0.0', '0.0', '0.9', '1.8', '0.8', '0.5', '102.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('567', 'ZA''ATAR', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('209', 'BULGUR WHEAT', 'January', 'December', '478.0', '1.9', '0.3', '0.0', '17.2', '106.2', '25.6', '0.6', '23.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('155', 'HONEY', 'January', 'December', '1030.0', '0.0', '0.0', '0.0', '1.0', '279.3', '0.7', '278.4', '13.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('352', 'BACON', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('364', 'ZEST', 'January', 'December', '5.0', '0.0', '0.0', '0.0', '0.1', '1.5', '0.6', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('502', 'ONION POWDER', 'January', 'December', '23.0', '0.1', '0.0', '0.0', '0.7', '5.5', '1.0', '0.5', '5.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('310', 'TURKEY', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('259', 'LETTUCE', 'January', 'December', '1.0', '0.0', '0.0', '0.0', '0.2', '0.3', '0.2', '0.1', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('158', 'MACARONI', 'January', 'December', '368.0', '2.9', '0.4', '93.4', '14.5', '70.1', '0.0', '0.0', '33.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('317', 'BASIL', 'January', 'December', '1.0', '0.0', '0.0', '0.0', '0.2', '0.1', '0.1', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('307', 'SWEET POTATO', 'January', 'December', '111.0', '0.1', '0.0', '0.0', '2.0', '26.2', '3.9', '5.4', '71.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('301', 'SPINACH', 'January', 'December', '78.0', '1.3', '0.2', '0.0', '9.7', '12.3', '7.5', '1.4', '268.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('197', 'WHITE BEAN', 'January', 'December', '672.0', '1.7', '0.4', '0.0', '47.2', '121.7', '30.7', '4.3', '32.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('78', 'SALMON', 'January', 'December', '107.0', '3.7', '0.7', '39.1', '17.4', '0.0', '0.0', '0.0', '63.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('348', 'THYME', 'January', 'December', '11.0', '0.3', '0.1', '0.0', '0.4', '2.7', '1.6', '0.1', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('334', 'OREGANO', 'January', 'December', '2.0', '0.0', '0.0', '0.0', '0.1', '0.7', '0.4', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('330', 'MINT', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('515', 'BROWN RICE', 'January', 'December', '684.0', '5.4', '1.1', '0.0', '14.7', '142.9', '6.5', '1.6', '12.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('229', 'CORN', 'January', 'December', '241.0', '3.0', '0.5', '0.0', '7.8', '55.4', '6.0', '7.2', '962.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('507', 'RED PEPPER FLAKES', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('338', 'PISTACHIO', 'January', 'December', '3.0', '0.3', '0.0', '0.0', '0.1', '0.2', '0.1', '0.1', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('495', 'OLIVE OIL', 'January', 'December', '1909.0', '216.0', '29.8', '0.0', '0.0', '0.0', '0.0', '0.0', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('171', 'PARSLEY', 'January', 'December', '1.0', '0.0', '0.0', '0.0', '0.1', '0.3', '0.1', '0.0', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('139', 'SUGAR', 'January', 'December', '774.0', '0.0', '0.0', '0.0', '0.0', '200.0', '0.0', '199.6', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('459', 'WATER', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '7.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('142', 'EGG', 'January', 'December', '71.0', '4.8', '1.6', '186.0', '6.3', '0.4', '0.0', '0.2', '71.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('387', 'CANOLA OIL', 'January', 'December', '1927.0', '218.0', '16.1', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('148', 'ONION', 'January', 'December', '44.0', '0.1', '0.0', '0.0', '1.2', '10.3', '1.9', '4.7', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('473', 'SOY SAUCE', 'January', 'December', '10.0', '0.0', '0.0', '0.0', '1.9', '1.0', '0.1', '0.3', '1005.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('258', 'LENTIL', 'January', 'December', '271.0', '0.8', '0.1', '0.0', '19.9', '46.3', '23.5', '1.6', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('153', 'TOMATO SAUCE', 'January', 'December', '58.0', '0.4', '0.1', '0.0', '3.2', '13.2', '3.7', '10.4', '1283.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('314', 'WALNUT', 'January', 'December', '772.0', '73.8', '4.2', '0.0', '30.1', '12.4', '8.5', '1.4', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('227', 'COD', 'January', 'December', '82.0', '0.7', '0.1', '43.2', '17.8', '0.0', '0.0', '0.0', '1995.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('448', 'CANNELLINI BEAN', 'January', 'December', '215.0', '1.5', '0.4', '0.0', '13.4', '37.1', '13.6', '4.7', '757.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('20', 'CUMIN', 'January', 'December', '22.0', '1.3', '0.1', '0.0', '1.1', '2.7', '0.6', '0.1', '10.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('38', 'BARLEY', 'January', 'December', '704.0', '2.3', '0.5', '0.0', '19.8', '155.4', '31.2', '1.6', '18.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('154', 'BROTH', 'January', 'December', '30.0', '1.0', '0.5', '0.0', '5.0', '0.2', '0.0', '0.0', '1618.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('216', 'CELERY', 'January', 'December', '6.0', '0.1', '0.0', '0.0', '0.3', '1.2', '0.6', '0.7', '32.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('163', 'BAY LEAF', 'January', 'December', '1.0', '0.1', '0.0', '0.0', '0.0', '0.4', '0.2', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('340', 'ROSEMARY', 'January', 'December', '10.0', '0.5', '0.2', '0.0', '0.2', '2.1', '1.4', '0.0', '1.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('39', 'PINE NUTS', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('165', 'GARLIC', 'January', 'December', '4.0', '0.0', '0.0', '0.0', '0.2', '0.9', '0.1', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('164', 'DILL', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.1', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('190', 'AVOCADO', 'January', 'December', '321.0', '29.5', '4.3', '0.0', '4.0', '17.1', '13.5', '1.3', '14.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('455', 'OLIVE', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('188', 'ARTICHOKE', 'January', 'December', '63.0', '0.4', '0.1', '0.0', '3.5', '14.3', '10.3', '1.2', '72.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('6', 'BAKING POWDER', 'January', 'December', '2.0', '0.0', '0.0', '0.0', '0.0', '1.1', '0.0', '0.0', '363.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('185', 'ANCHOVY', 'January', 'December', '8.0', '0.4', '0.1', '3.4', '1.2', '0.0', '0.0', '0.0', '146.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('401', 'KIDNEY BEAN', 'January', 'December', '215.0', '1.5', '0.4', '0.0', '13.4', '37.1', '13.6', '4.7', '757.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('55', 'LEMON JUICE', 'January', 'December', '53.0', '0.6', '0.1', '0.0', '0.9', '16.8', '0.7', '6.1', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('13', 'CAPER', 'January', 'December', '1.0', '0.1', '0.0', '0.0', '0.2', '0.4', '0.3', '0.0', '254.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('395', 'TUNA', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('57', 'RAISIN', 'January', 'December', '433.0', '0.7', '0.1', '0.0', '4.5', '114.8', '5.4', '85.8', '15.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('128', 'EGGPLANT', 'January', 'December', '109.0', '0.9', '0.2', '0.0', '4.6', '26.1', '15.6', '10.8', '9.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('119', 'PLUM TOMATO', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('335', 'PAPRIKA', 'January', 'December', '19.0', '0.9', '0.1', '0.0', '1.0', '3.7', '2.4', '0.7', '4.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('731', 'TOMATO PUREE', 'January', 'December', '312.0', '1.7', '0.2', '0.0', '13.6', '73.8', '15.6', '39.7', '230.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('286', 'RADISH', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.2', '0.1', '0.1', '1.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('283', 'PROSCIUTTO', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('7', 'BAKING SODA', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '1258.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('304', 'STRAWBERRY', 'January', 'December', '3.0', '0.0', '0.0', '0.0', '0.1', '0.9', '0.2', '0.6', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('425', 'GHEE', 'January', 'December', '112.0', '12.7', '7.9', '32.8', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('673', 'EDAMAME', 'January', 'December', '376.0', '17.4', '2.0', '0.0', '33.2', '28.3', '10.8', '0.0', '38.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('150', 'SWEET PEPPER', 'January', 'December', '23.0', '0.2', '0.1', '0.0', '1.0', '5.5', '2.0', '2.9', '3.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('320', 'CAYENNE PEPPER', 'January', 'December', '16.0', '0.9', '0.2', '0.0', '0.6', '3.0', '1.4', '0.5', '1.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('236', 'CURRANT', 'January', 'December', '407.0', '0.4', '0.0', '0.0', '5.9', '106.7', '9.8', '96.9', '11.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('337', 'PEPPER', 'January', 'December', '5.0', '0.1', '0.0', '0.0', '0.2', '1.5', '0.6', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('64', 'FLOUR', 'January', 'December', '455.0', '1.2', '0.2', '0.0', '12.9', '95.4', '3.4', '0.3', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('16', 'CILANTRO', 'January', 'December', '4.0', '0.1', '0.0', '0.0', '0.4', '0.7', '0.6', '0.2', '9.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('347', 'TARRAGON', 'January', 'December', '14.0', '0.3', '0.1', '0.0', '1.1', '2.4', '0.4', '0.0', '2.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('52', 'CHIVES', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('375', 'BROWN SUGAR', 'January', 'December', '836.0', '0.0', '0.0', '0.0', '0.3', '215.8', '0.0', '213.4', '61.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('291', 'RICOTTA CHEESE', 'January', 'December', '0.0', '0.0', NULL, '0.0', '0.0', '0.0', '0.0', '0.0', NULL);
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('193', 'FAVA BEAN', 'January', 'December', '181.0', '0.6', '0.1', '0.0', '14.0', '31.8', '9.5', '0.0', '1159.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('235', 'CUCUMBER', 'January', 'December', '45.0', '0.3', '0.1', '0.0', '2.0', '10.9', '1.5', '5.0', '6.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('221', 'CHICKEN', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('32', 'KALAMATA OLIVE', 'January', 'December', '5.0', '0.5', '0.1', '0.0', '0.0', '0.3', '0.1', '0.0', '32.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('147', 'SOUR CREAM', 'January', 'December', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('273', 'PASTA', 'January', 'December', '311.0', '1.3', '0.2', '0.0', '11.0', '62.7', '2.7', '2.2', '5.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('214', 'CAULIFLOWER', 'January', 'December', '147.0', '1.6', '0.4', '0.0', '11.3', '29.2', '11.8', '11.2', '176.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('316', 'ZUCCHINI', 'January', 'December', '33.0', '0.6', '0.2', '0.0', '2.4', '6.1', '2.0', '4.9', '15.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('166', 'GINGER', 'January', 'December', '19.0', '0.2', '0.0', '0.0', '0.4', '4.3', '0.5', '0.4', '3.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('141', 'BUTTER', 'January', 'December', '1627.0', '184.1', '116.6', '488.1', '1.9', '0.1', '0.0', '0.1', '1620.0');
INSERT INTO ingredients (ingredient_id, ingredient_name, season_start, season_end, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('19', 'COUSCOUS', 'January', 'December', '650.0', '1.1', '0.2', '0.0', '22.1', '134.0', '8.7', '0.0', '17.0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000820349', NULL, '@Annina S.', NULL, NULL, NULL, '2016', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('900992', 'M G', '@Paris D', '4.7', NULL, NULL, '2008', '07', '4', '5');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('691407', 'NULL N', '@KariBunny', NULL, NULL, NULL, '2007', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('338451', NULL, '@msamyloo', NULL, NULL, NULL, '2006', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('942099', NULL, '@Chitown Foodie', NULL, NULL, NULL, '2008', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('392215', NULL, '@Miracle Miriam', '4.7', NULL, NULL, '2006', '11', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002180508', 'JEANNE C', '@meko819', NULL, NULL, NULL, '2018', '06', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001935726', NULL, '@tdudziak', NULL, NULL, NULL, '2018', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002398687', NULL, '@rwk5214', NULL, NULL, NULL, '2019', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('679953', 'DOUG K', '@weekend cooker', '4.7', NULL, NULL, '2007', '12', '36', '25');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('573325', NULL, '@Lalaloula', '4.7', NULL, NULL, '2007', '08', '42', '8');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('599450', 'LIISA R', '@mersaydees', '4.7', 'Bloomington', ' Indiana', '2007', '09', '73', '127');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('428885', 'ANDI PENA', '@Andi Longmeadow Farm', '4.8', NULL, NULL, '2007', '01', '156', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('15385', 'STEPHANIE', '@stephanie', '4.4', 'st-felix de kingsey', ' Quebec', '2001', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('137302', 'CARROL M', '@CarrolJ', '4.7', 'Slater', ' 54', '2004', '04', '39', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('252514', NULL, '@averybird', '4.8', NULL, NULL, '2005', '10', '4', '76');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002225290', 'CAPT T', '@Capt T.', NULL, NULL, NULL, '2018', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2284242', NULL, '@Mandy at Food.com', '3.7', NULL, NULL, '2012', '06', '4', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002480485', NULL, '@Vanessa H.', NULL, NULL, NULL, '2019', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('470351', 'SUSAN L', '@RedVinoGirl', '4.8', NULL, NULL, '2007', '03', '26', '8');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('383346', 'FRANCE P', '@Boomette', '4.7', NULL, NULL, '2006', '11', '131', '8');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('42651', 'GERRY SANS SANDDUNES', '@Gerry sans Sanddunes', '4.7', NULL, NULL, '2002', '06', '12', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1997017', NULL, '@judydeville', NULL, NULL, NULL, '2011', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001556102', NULL, '@Anonymous', NULL, NULL, NULL, '2017', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('133174', 'PAULAG W', '@PaulaG', '4.7', 'Hixson', ' Tennessee', '2004', '03', '305', '13');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('471290', NULL, '@Shock55', '4.6', NULL, NULL, '2007', '03', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1052873', 'JEAN', '@sheepdoc', '4.8', 'Caledonia', ' 0', '2008', '11', '3', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('829331', 'MON Z', '@Monzeeki', NULL, 'New York City', ' New York', '2008', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002044255', 'THOMAS M', '@thomas m.', NULL, 'ballston spa', ' NY', '2018', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('545825', 'HEATHER N', '@HeatherN', '4.4', NULL, NULL, '2007', '07', '0', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('697352', NULL, '@lisa.syverson', NULL, NULL, NULL, '2007', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001092295', NULL, '@debbielpayne', NULL, NULL, NULL, '2016', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('597999', NULL, '@Panebianco', '4.7', NULL, NULL, '2007', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('288146', 'KAYTE B', '@KLBoyle', '4.6', 'Frisco', ' Colorado', '2006', '01', '7', '8');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('131126', 'SUSIE D N', '@Susie D', '4.8', NULL, NULL, '2004', '03', '62', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000767449', NULL, '@lngtheone', NULL, NULL, NULL, '2015', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001468905', NULL, '@karenvjohnson09', NULL, NULL, NULL, '2017', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('15892', 'SIDNEY', '@sidMILB', '4.5', 'Burbank', ' CA', '2001', '08', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('546010', 'COLLEEN V', '@Chicagoland Chef du Jour', '4.8', 'Hinsdale', ' Illinois', '2007', '07', '59', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('171210', 'LEAH', '@Bugeah', '4.8', NULL, NULL, '2004', '11', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('282673', 'NULL N', '@graffeetee', '4.6', 'Sandy', ' Utah', '2006', '01', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('593513', 'NULL N', '@FrenchBunny', '4.6', NULL, NULL, '2007', '09', '22', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('779699', NULL, '@SarahBeth', '4.7', NULL, NULL, '2008', '03', '20', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('61863', 'MINDY S', '@Mindy Stillion', '4.4', NULL, NULL, '2002', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('444132', NULL, '@Katzen', '4.4', NULL, NULL, '2007', '02', '52', '17');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('15718', NULL, '@Steve P.', '4.4', NULL, NULL, '2001', '08', '75', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('452355', 'NULL N', '@Dr. Jenny', '4.8', NULL, NULL, '2007', '02', '18', '32');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1384367', 'MEGHAN', '@Meghan at Food.com', '3.9', NULL, NULL, '2009', '09', '2', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2156777', 'RANDI S', '@Funkymunky613', NULL, NULL, NULL, '2012', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('498271', NULL, '@loof751', '4.6', NULL, NULL, '2007', '05', '36', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('541842', NULL, '@LizzyGirl09', '4.8', NULL, NULL, '2007', '07', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002039866', NULL, '@estella_orion', NULL, NULL, NULL, '2018', '03', '0', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('109855', 'BARB W', '@Barb W.', '4.4', 'Pittsburgh', ' PA', '2003', '10', '18', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('14613', 'MILLA', '@Milla', '4.8', 'Los Angeles', ' CA', '2001', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('184530', NULL, '@Soobeeoz', '4.4', NULL, NULL, '2005', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('333017', NULL, '@Abby Girl', '4.6', NULL, NULL, '2006', '07', '29', '32');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('56181', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('197023', NULL, '@bluemoon downunder', '4.6', NULL, NULL, '2005', '02', '39', '10');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('469903', NULL, '@Brooke the Cook in', '4.7', NULL, NULL, '2007', '03', '25', '12');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('725350', NULL, '@kimjunae', '4.6', NULL, NULL, '2008', '01', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002470084', NULL, '@annagram54', NULL, NULL, NULL, '2019', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('37449', 'SHARON W', '@Sharon123', '4.7', 'Murphy', ' 73', '2002', '04', '393', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002770718', NULL, '@Linda Y.', NULL, NULL, NULL, '2020', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('191533', NULL, '@J-Lynn', '4.4', NULL, NULL, '2005', '01', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002974579', NULL, '@Jackie B.', NULL, NULL, NULL, '2021', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('815198', 'NULL N', '@nkoprince08', '4.8', NULL, NULL, '2008', '04', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('33186', 'FOOD.COM', '@Food.com', '3.7', NULL, NULL, '2002', '03', '566', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001755986', 'NULL N', '@mamaston', NULL, NULL, NULL, '2017', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('940393', NULL, '@eggleston', NULL, NULL, NULL, '2008', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('182010', 'KATE Q', '@Chef Kate', '4.7', 'Annapolis', ' 60', '2004', '12', '50', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002091378', NULL, '@Lisa S.', NULL, NULL, NULL, '2018', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('942456', 'JILL C', '@Jillyb', NULL, NULL, NULL, '2008', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('481092', 'VICKI B', '@Vicki in CT', '4.7', 'tolland', ' 45', '2007', '04', '46', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('292841', NULL, '@cinderelladressmaker', NULL, NULL, NULL, '2006', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1188676', NULL, '@plambago', NULL, NULL, NULL, '2009', '03', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('4439', 'RENEE H', '@mandabears', '4.5', 'Jenkintown', ' Pennsylvania', '2001', '01', '54', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('743849', 'JESSY R', '@jessymroberts', '4.5', NULL, NULL, '2008', '01', '29', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('47892', 'DOT. DOT. DOT. N', '@COOKGIRl', '4.7', NULL, NULL, '2002', '07', '99', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002786745', NULL, '@antcandy44', NULL, NULL, NULL, '2020', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('844554', 'SYLVIA D', '@nemokitty', '4.6', 'Mesquite', ' Nevada', '2008', '05', '8', '5');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2193767', 'NULL N', '@valentine0202', NULL, NULL, NULL, '2012', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('388248', NULL, '@TopfUziel', NULL, NULL, NULL, '2006', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1428015', NULL, '@neeserwoman', NULL, NULL, NULL, '2009', '10', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('239758', NULL, '@Leggy Peggy', '4.7', NULL, NULL, '2005', '08', '36', '5');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('56003', 'SUSANNAH W', '@Darkhunter', '4.6', NULL, NULL, '2002', '09', '11', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('514157', NULL, '@glwhitney', NULL, NULL, NULL, '2007', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('13593', 'AMBER OF AZ N', '@Amber of AZ', '4.4', 'Phoenix', ' Arizona', '2001', '07', '6', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('543977', NULL, '@Nannaextraordinaire', '5.0', NULL, NULL, '2007', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('27416', 'WILLIAM (UNCLE BILL) A', '@William Uncle Bill', '4.7', 'Burnaby', NULL, '2001', '12', '417', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('199792', 'GAYLA F', '@GaylaV', '4.7', NULL, NULL, '2005', '03', '8', '12');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002302245', 'NULL NULL', '@Natasha Feldman', '4.8', NULL, NULL, '2018', '10', '36', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000798550', NULL, '@Hippiebride', NULL, NULL, NULL, '2016', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001112113', 'JONATHAN M', '@Jonathan Melendez', '4.4', 'North Hollywood', ' California', '2016', '08', '297', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('965764', 'NULL N', '@Laughing in the Kit', '4.0', NULL, NULL, '2008', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1060667', 'MICHELLE W', '@mommyluvs2cook', NULL, 'La Marque', ' Texas', '2008', '04', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1182971', 'LISA S', '@Chef de Sucre', NULL, NULL, NULL, '2009', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('173976', 'NULL N', '@lusibari', NULL, NULL, NULL, '2004', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1580637', 'ELISSA M', '@emcquaid', NULL, 'Half Moon Bay', ' California', '2010', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1169750', 'NULL N', '@clevergirl3', NULL, NULL, NULL, '2009', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('166642', 'LANE M', '@CookingONTheSide', '4.7', 'Carnegie', ' Pennsylvania', '2004', '10', '255', '85');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('945248', NULL, '@MixingItAllUp', NULL, NULL, NULL, '2008', '09', '0', '8');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1849027', NULL, '@Mari_890', NULL, NULL, NULL, '2011', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2153320', 'MELISSA T', '@girlofthepuddle', NULL, NULL, NULL, '2012', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001492522', 'CHRISTOPHER C', '@Christopher C.', NULL, NULL, NULL, '2017', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('13796', 'DEE B', '@DeeBee', '4.7', 'Atco', ' NJ', '2001', '08', '15', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('169430', 'ELIZABETH L', '@Annacia', '4.7', NULL, NULL, '2004', '10', '169', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('579298', NULL, '@Peachie Keene', '4.9', NULL, NULL, '2007', '09', '7', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2851666', NULL, '@DanaPNY', NULL, NULL, NULL, '2013', '06', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001693157', NULL, '@cwiley55', NULL, NULL, NULL, '2017', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('61660', 'KIM127', '@Kim127', '4.7', NULL, NULL, '2002', '11', '55', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('285039', 'LISA F', '@Cook4_6', '4.7', NULL, NULL, '2006', '01', '62', '19');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('463858', 'STEPHANIE J', '@MamaJ', '4.7', NULL, NULL, '2007', '03', '4', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('207616', 'NANCY O', '@sassafrasnanc', '4.7', 'Fairview', ' 73', '2005', '04', '19', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('3288', 'TISH N', '@TishT', '4.4', 'Las Vegas', ' Nevada', '2000', '11', '313', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2003135967', 'SD S', '@<script>alert(document.cookie)</script>', NULL, NULL, NULL, '2024', '04', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('604906', NULL, '@CaliCook', '4.5', NULL, NULL, '2007', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2895155', 'NULL N', '@ameglio', NULL, NULL, NULL, '2013', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('223854', 'CHEF FLOWER N', '@Chef floWer', '4.7', NULL, NULL, '2005', '06', '51', '32');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000431901', 'DIANA J', '@DianaEatingRichly', NULL, 'Auburn', ' Washington', '2015', '08', '74', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('266635', 'DAILYINSPIRATION', '@DailyInspiration', '4.8', NULL, NULL, '2005', '11', '31', '70');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('644307', NULL, '@lovemycrock', NULL, NULL, NULL, '2007', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('199848', 'MARCIE N', '@*Parsley*', '4.6', NULL, NULL, '2005', '03', '140', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('735767', NULL, '@Fighting Irish #7', NULL, NULL, NULL, '2008', '01', '2', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('719083', NULL, '@tomsawyer', '4.7', NULL, NULL, '2008', '01', '3', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('880889', NULL, '@socholy', '3.5', NULL, NULL, '2008', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2332788', NULL, '@jlgorham', NULL, NULL, NULL, '2012', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('269829', NULL, '@Lianna Banana', '4.6', NULL, NULL, '2005', '12', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002305701', NULL, '@tcoulter1015', NULL, NULL, NULL, '2018', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2201427', NULL, '@Souxie', '4.9', NULL, NULL, '2012', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000165997', 'ADMIRAL S', '@Admiral Sparkles', NULL, NULL, NULL, '2015', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('464080', 'JEN D', '@januarybride', '4.7', 'Saint Louis', ' Missouri', '2007', '03', '113', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('135470', 'MOMAPHET N', '@momaphet', '4.8', NULL, NULL, '2004', '03', '28', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('145960', 'NATALIA G', '@Natalia 3', '4.7', NULL, NULL, '2004', '06', '2', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002912073', NULL, '@Elisabeth T.', NULL, NULL, NULL, '2021', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('39835', 'ELLIE2', '@ellie_', '4.6', NULL, NULL, '2002', '05', '76', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('117438', 'SYRAH', '@Sassy Syrah', '4.6', 'Sydney', ' 0', '2003', '12', '8', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('276108', NULL, '@vaflnc', '5.0', NULL, NULL, '2005', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002242767', NULL, '@k w.3416', NULL, NULL, NULL, '2018', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('402698', 'KELLY P', '@CHEF.OF.THE.EAST', NULL, NULL, NULL, '2006', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('11176', 'SANDI (', '@Sandi From CA', '4.7', 'Arcadia', ' California', '2001', '06', '108', '12');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('58104', 'RITA L', '@Rita1652', '4.7', 'Jamesburg', ' New Jersey', '2002', '10', '545', '20');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('456860', NULL, '@SuzieQutie', '5.0', NULL, NULL, '2007', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('222478', NULL, '@Peter J', '4.7', NULL, NULL, '2005', '06', '38', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1637137', 'NULL N', '@Jackshoe', NULL, NULL, NULL, '2010', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('296027', NULL, '@Mommy Diva', '4.6', 'Cornelius', ' 0', '2006', '02', '47', '45');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1666717', 'NULL N', '@kiss-a-suger', NULL, NULL, NULL, '2010', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2041603', 'NULL N', '@mMadness97', NULL, NULL, NULL, '2011', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1298125', NULL, '@other2222', NULL, NULL, NULL, '2009', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001959293', NULL, '@jimburch', NULL, NULL, NULL, '2018', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('169969', 'NULL N', '@ncmysteryshopper', '4.8', NULL, NULL, '2004', '10', '157', '19');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('539990', 'MELISSA M', '@Melissa and her Pan', '4.9', 'Vancouver', ' Washington', '2007', '07', '4', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('167225', NULL, '@Nose5775', '4.7', NULL, NULL, '2004', '10', '5', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('869184', NULL, '@Deantini', '4.7', NULL, NULL, '2008', '06', '12', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('126440', 'ADOPT A GREYHOUND N', '@adopt a greyhound', '4.8', NULL, NULL, '2004', '02', '4', '47');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('498487', NULL, '@Cuistot', '4.3', NULL, NULL, '2007', '05', '3', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('496803', 'NULL N', '@IngridH', '4.7', NULL, NULL, '2007', '05', '20', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('299608', 'NULL N', '@LeeDelaino', '4.7', NULL, NULL, '2006', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('503845', NULL, '@linpo', NULL, NULL, NULL, '2006', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('414452', NULL, '@adriennenewton', '5.0', NULL, NULL, '2006', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1223517', NULL, '@Samantha_Arestia', '5.0', NULL, NULL, '2009', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('231057', 'NADINE A', '@Milkman''s Daughter', '4.8', NULL, NULL, '2005', '07', '4', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('67656', 'TONI G', '@justcallmetoni', '4.6', NULL, NULL, '2003', '01', '113', '28');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('251917', 'SARAH M', '@Mom2Rose', '4.7', 'Flint', ' Michigan', '2005', '10', '48', '41');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('612622', NULL, '@lauren.a.rivera', NULL, NULL, NULL, '2007', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('8975', 'MARY H', '@Mary Hallen', '4.5', NULL, NULL, '2001', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('312679', NULL, '@jennicarmen', NULL, NULL, NULL, '2006', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('836852', 'NULL N', '@Mussmom', NULL, NULL, NULL, '2008', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('338124', NULL, '@alison.klein', '4.8', NULL, NULL, '2006', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('505731', 'NULL N', '@beady baker', NULL, NULL, NULL, '2007', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2003097947', 'MD SHOHEL R', '@Md Shohel R.', NULL, NULL, NULL, '2022', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001921429', NULL, '@Anna T.', NULL, NULL, NULL, '2018', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2216338', NULL, '@logansw', '5.0', NULL, NULL, '2012', '03', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001650017', NULL, '@Joe P.', NULL, NULL, NULL, '2017', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('7578910', 'GABRIELLE L', '@angel_gabrie_7578910', NULL, 'franklin', ' 82', '2007', '04', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('465829', 'NULL N', '@LilPinkieJ', '4.6', NULL, NULL, '2007', '03', '24', '34');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('866232', 'NULL N', '@pbo-09', NULL, NULL, NULL, '2008', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('55589', 'JANNY7', '@Janny7', '5.0', 'Orlando', ' Florida', '2002', '09', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2003001761', NULL, '@Laura M.', NULL, NULL, NULL, '2021', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('8629', 'MARIE N', '@Marie Nixon', '4.6', 'Villa Park', ' Illinois', '2001', '04', '9', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('37636', 'SUE L', '@PalatablePastime', '4.6', NULL, NULL, '2002', '04', '421', '15');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001736429', NULL, '@mhetrick', NULL, NULL, NULL, '2017', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('80353', 'EVELYN/ATHENS N', '@evelynathens', '4.6', NULL, NULL, '2003', '04', '364', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001038345', NULL, '@John C.', NULL, NULL, NULL, '2016', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('171790', 'DORRIE W', '@Dreamer in Ontario', '4.7', NULL, NULL, '2004', '11', '81', '9');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('27678', 'SACKVILLE GIRL', '@Sackville', '4.6', NULL, NULL, '2001', '12', '105', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2003034514', NULL, '@krausekelly61', NULL, NULL, NULL, '2021', '11', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001177335', NULL, '@Bonniejscaccia', NULL, NULL, NULL, '2016', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('36777', 'DOQU R', '@DoQu Russell', '4.7', 'Warrington', ' Florida', '2002', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('277434', NULL, '@Wu Newt', '5.0', NULL, NULL, '2005', '12', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('145352', 'CHARMIE F', '@Charmie777', '4.7', NULL, NULL, '2004', '06', '130', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('913360', NULL, '@melister', NULL, NULL, NULL, '2008', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('465911', NULL, '@FrVanilla', '4.8', NULL, NULL, '2007', '03', '11', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000449361', NULL, '@Barb J.', NULL, NULL, NULL, '2015', '09', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('5060', 'DERF', '@Derf2440', '4.6', NULL, NULL, '2001', '01', '230', '12');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('37779', 'CHARLOTTE L', '@ratherbeswimmin', '4.6', NULL, NULL, '2002', '04', '612', '70');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('148221', 'KINDCOOK', '@kindcook', '4.3', NULL, NULL, '2004', '06', '7', '7');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1802528797', 'CLAUDIA D', '@Claudia D.', NULL, NULL, NULL, '2014', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('401767', NULL, '@Katwyn', '5.0', NULL, NULL, '2006', '12', '0', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002064320', 'JEANETTE M', '@Jeanette M.', NULL, NULL, NULL, '2018', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('486725', 'MAITO 1', '@Maito', '4.7', NULL, NULL, '2007', '04', '14', '19');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1099264', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('246482', NULL, '@bigbadbrenda', '4.6', NULL, NULL, '2005', '09', '16', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('445442', NULL, '@MtlCarly', NULL, NULL, NULL, '2007', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1226388', 'NULL N', '@AlaskaPam', '4.6', NULL, NULL, '2009', '04', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('4399', 'N J', '@N Joyner', NULL, NULL, NULL, '2001', '01', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('704950', NULL, '@ChefLee', '4.5', NULL, NULL, '2007', '12', '24', '11');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000254857', 'NATURAL L', '@Natural Life', NULL, NULL, NULL, '2015', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('239767', 'LIZ S', '@McGelby', '4.2', NULL, NULL, '2005', '08', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('204024', 'LYNN C', '@Lavender Lynn', '4.7', NULL, NULL, '2005', '03', '90', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1038619', NULL, '@Halima Dances', NULL, NULL, NULL, '2008', '11', '0', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('953275', 'GENEVIEVE R', '@magpie diner', '4.8', NULL, NULL, '2008', '09', '25', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('463435', NULL, '@Chef Buggsy Mate', '4.7', NULL, NULL, '2007', '03', '27', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('143308', 'KIM M', '@MacChef', '4.6', NULL, NULL, '2004', '05', '24', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('220348', 'NULL N', '@Studentchef', '4.4', NULL, NULL, '2005', '06', '18', '7');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('552613', 'NULL N', '@Sarah_Jayne', '4.5', NULL, NULL, '2007', '08', '35', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('216999', 'NULL N', '@Michelle Berteig', '4.6', NULL, NULL, '2005', '05', '11', '2');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001650987', NULL, '@Cindy J.', NULL, NULL, NULL, '2017', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002012581', 'KELLI W', '@kelliwarrick16', NULL, NULL, NULL, '2018', '02', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('137838', 'JNAAMA', '@Cookie16', '4.6', NULL, NULL, '2004', '04', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('137911', 'PAM H', '@Pam-I-Am', '4.7', 'Camarillo', ' California', '2004', '04', '83', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('128473', 'BABY KATO', '@Baby Kato', '4.8', NULL, NULL, '2004', '02', '85', '33');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('394077', NULL, '@YungB', '4.5', NULL, NULL, '2006', '11', '8', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('305531', 'NULL N', '@lazyme', '4.7', 'Grapeview', ' Washington', '2006', '03', '136', '16');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('358796', 'NULL N', '@BerrySweet', '3.7', NULL, NULL, '2006', '10', '1', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2206320', NULL, '@Deezrecipeze', '5.0', NULL, NULL, '2012', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002929101', NULL, '@Andrea R.', NULL, NULL, NULL, '2021', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('400708', 'BONNIE', '@Bonnie G #2', '4.6', NULL, NULL, '2006', '12', '48', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001004241', 'CLUB FOODY F', '@clubfoody', '4.5', NULL, NULL, '2016', '05', '12', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002978494', NULL, '@Capecodkaren', NULL, NULL, NULL, '2021', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('25941', '*MARYL*', '@snazzycook', '4.6', 'peterborough', ' 0', '2001', '12', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('465460', NULL, '@momto3', NULL, NULL, NULL, '2007', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('914360', 'LORI M', '@lorimclain', NULL, 'Denton', ' 83', '2008', '08', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('494084', NULL, '@jennyblender', '4.4', NULL, NULL, '2007', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('64667', 'DEBBER', '@Debber', '4.6', NULL, NULL, '2002', '12', '104', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('885216', NULL, '@SnowMonkey', NULL, NULL, NULL, '2008', '07', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('225426', NULL, '@blucoat', '4.5', NULL, NULL, '2005', '06', '47', '4');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('42413', 'BELLEOFPA', '@BelleofPA', NULL, 'Philadelphia', ' PA', '2002', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('148316', 'CARLA C', '@Carla C.', '4.6', NULL, NULL, '2004', '06', '79', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000407935', 'CAROLYN B', '@Caddy Lady', NULL, 'Easton', ' Pennsylvania', '2015', '08', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001067738', NULL, '@lharnois', NULL, NULL, NULL, '2016', '06', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('174096', NULL, '@Starrynews', '4.8', NULL, NULL, '2004', '11', '27', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1072593', NULL, '@gailanng', '4.8', NULL, NULL, '2008', '12', '174', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('21752', 'MIRJ', '@Mirj2338', '4.5', 'Givat Ze''ev', ' 0', '2001', '10', '248', '6');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('440735', NULL, '@Ck2plz', '4.8', NULL, NULL, '2007', '01', '3', '10');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001985209', NULL, '@lucymcelroy184', NULL, NULL, NULL, '2018', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('278639', 'MARY M', '@cookin mimi', '4.7', 'Satellite Beach', ' Florida', '2005', '12', '2', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('351711', NULL, '@Umberle', '4.5', NULL, NULL, '2006', '09', '0', '3');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('121690', 'EEBRAG', '@echo echo', '4.6', 'Phippsburg', ' Maine', '2004', '01', '107', '82');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('189280', 'STEPHANIE S', '@Recipe Reader', '4.5', NULL, NULL, '2005', '01', '14', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('1802555155', 'T$', '@t7995', NULL, NULL, NULL, '2014', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('12657', 'ANU', '@Anu_N', '4.3', NULL, NULL, '2001', '07', '19', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('89831', 'KITTENCAL', '@Kittencalrecipezazz', '4.7', NULL, NULL, '2003', '06', '4538', '31');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('10033', 'MEOW!', '@spatchcock', '4.6', NULL, NULL, '2001', '05', '67', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2000898883', 'STEVEE D', '@Stevee D.', NULL, NULL, NULL, '2016', '03', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002417202', NULL, '@sapioangela', NULL, NULL, NULL, '2019', '02', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002526386', 'COLLEEN M', '@colleen.gray3903', NULL, NULL, NULL, '2019', '10', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001556398', NULL, '@Yusuke U.', NULL, NULL, NULL, '2017', '05', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001831916', 'BILLY G', '@Billy Green', NULL, NULL, NULL, '2017', '11', '6', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2002430634', 'DEBRA R', '@Debra R.', NULL, NULL, NULL, '2019', '03', '1', '5');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2001160057', 'GRANT C', '@LOWELL C.', NULL, NULL, NULL, '2016', '09', '0', '1');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('168282', NULL, '@happyday49', NULL, NULL, NULL, '2004', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('2032489', 'NULL N', '@StarFire22', '4.7', NULL, NULL, '2011', '10', '0', '0');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('386585', 'SHEILA D', '@JackieOhNo!', '4.7', 'Stormville', ' New York', '2006', '11', '93', '171');
INSERT INTO users (user_id, name, username, user_rating_avg, city, state, joined_year, joined_month, followers, following) VALUES ('542159', 'DEBBWL', '@Debbwl', '4.7', NULL, NULL, '2007', '07', '40', '0');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('178249', 'MEDITERRANEAN CHICKEN BREASTS WITH AVOCADO TAPENADE', '11176', '222', '277.1', '16.4', '2.5', '75.5', '26.4', '6.9', '3.2', '1.5', '914.6');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('293197', 'CRISPY FRIED FALAFEL', '223854', '521', '29.4', '0.3', '0', '0', '1.8', '5', '1.7', '0.8', '55.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('487593', 'MEDITERRANEAN TILAPIA POCKETS #RSC', '2216338', '182', '261.9', '17', '2.8', '62.5', '25.7', '3', '1.3', '0.8', '212.6');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('47961', 'LEBANESE LENTIL SALAD', '61863', '280', '378.1', '30.2', '9.6', '40.2', '11.6', '17.1', '5', '5.1', '515.4');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('229948', 'MEDITERRANEAN BALSAMIC MUSHROOMS', '64667', '93', '155.3', '13.9', '1.9', '0', '3.6', '5.8', '1.2', '4.1', '590.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('537245', 'SHAKSHUKA BURRITO WITH ROASTED PEPPER SALSA AND TZATZIKI', '2002302245', '311', '267.1', '18.7', '3.6', '186', '10', '18.1', '8.1', '5.8', '690.7');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('158351', 'PAN SEARED MOROCCAN SALMON', '37449', '62', '87.3', '3.8', '0.6', '25.8', '11.8', '1.2', '0.5', '0.2', '121.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('537248', 'MEDITERRANEAN LASAGNA', '2002302245', '376', '366.4', '17.1', '7.8', '39.9', '19.2', '36.9', '6.6', '8.1', '1340.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('537249', 'MEDITERRANEAN CHOPPED SALAD', '2002302245', '573', '568.8', '42.5', '13.1', '53.6', '18.7', '32', '13.1', '9.6', '1120');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('537246', 'OLIVE OIL CHOCOLATE CHIP COOKIES', '2002302245', '71', '334.2', '18.6', '2.6', '15.5', '2.7', '40.1', '0.6', '24.2', '253.7');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('138183', 'MEDITERRANEAN SALMON', '4439', '262', '321.6', '17.7', '2.8', '77.4', '35.4', '3.8', '1.2', '2.1', '693.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('537247', 'STRAWBERRY TRIFLE', '2002302245', '182', '116', '0.4', '0', '0', '1', '28.6', '2.9', '24.6', '293.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('428004', 'ROASTED MEDITERRANEAN VEGETABLES', '174096', '226', '197.6', '7.2', '1.1', '0', '4.3', '31.6', '8.3', '8.2', '13.7');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('12684', 'MEDITERRANEAN LEMON COUSCOUS SALAD', '15385', '237', '448.6', '21.2', '7.1', '33.4', '16.1', '50', '7.1', '5', '592.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('536387', 'GREEK TURKEY BURGERS', '33186', '1270', '460.8', '20.9', '4', '78.3', '29.2', '39.8', '3.2', '3.1', '777.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('131988', 'MEDITERRANEAN KALAMATA HUMMUS', '169969', '124', '357.7', '24.8', '3.4', '0', '8', '29.4', '7', '1.3', '596.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('299973', 'MEDITERRANEAN CHICKPEA SALAD', '469903', '272', '272.5', '11.1', '4.4', '22.4', '12.7', '31.5', '5.8', '4.2', '648');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('304166', 'TZATZIKI SAUCE-- GREEK CUCUMBER/YOGURT SAUCE', '392215', '30', '5', '0', '0', '0', '0.2', '1.3', '0.1', '0.5', '582');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('536714', 'LAMB & CARROT MEATBALLS WITH CAULIFLOWER TABBOULEH', '33186', '722', '758.9', '58.5', '20.2', '154.1', '30.6', '33.1', '10.5', '14.6', '804.7');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('39195', 'EGGPLANT (AUBERGINE) CAPONATA', '15718', '381', '348', '6.1', '0.9', '0', '5.9', '73.5', '14.2', '53.8', '816.2');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('382432', 'SPINACH AND BULGAR SALAD', '542159', '185', '183.2', '13.5', '5.5', '26.8', '7', '9.6', '2.9', '1.7', '385.4');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('111865', 'STUFFED AVOCADO SALAD', '145352', '217', '334', '29.9', '7.3', '22.3', '6.6', '14.6', '9', '3.6', '291.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('220089', 'CROCK POT CHICKEN CASABLANCA (WW FLEX AND ALMOST CORE)', '67656', '472', '335.4', '7.1', '1.3', '81.7', '33.1', '35.7', '7.5', '12.3', '358.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('316925', 'ITALIAN EGGPLANT RAGOUT', '351711', '366', '196.5', '5.9', '0.8', '0', '6.5', '32.9', '10.8', '8', '2632.2');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('280466', 'TOMATO AND BARLEY SOUP', '199792', '313', '134.1', '5.3', '0.8', '0', '4.1', '18.7', '3.8', '5.3', '439.6');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('81419', 'UNCLE BILL''S VEGETARIAN MINESTRONE SOUP', '27416', '323', '172.4', '4.4', '0.7', '0', '6.7', '28.6', '7', '9.2', '577.8');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('514034', 'SHAKSHUKA WITH SWISS CHARD', '2284242', '502', '337.7', '21.4', '5.3', '375.3', '19.3', '20.4', '5.6', '12.4', '1639.8');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('379639', 'WORLD''S BEST TABBOULI / TABOULI / TABBOULEH / TABOULEH SALAD', '225426', '198', '203.7', '7.4', '1', '0', '5.5', '31.8', '7.7', '2.6', '140.2');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('364493', 'BROWN RICE & PEPPERS PILAF', '166642', '179', '182.2', '3.7', '0.6', '0', '4.3', '33.4', '2.1', '1.6', '18.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('156662', 'MEDITERRANEAN CHICKEN WITH TOMATOES, KALAMATA AND MUSHROOMS', '89831', '716', '666', '37', '13.5', '208.5', '69.4', '14.2', '3.8', '7.7', '690.4');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('183768', 'LENTIL AND COUSCOUS SALAD', '137838', '237', '214.5', '11', '1.5', '0', '5.4', '24', '3.6', '1.2', '10.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('455488', 'MEDITERRANEAN HUMMUS APPETIZER', '1072593', '138', '317.1', '20.3', '2.8', '0', '7.5', '28.6', '5.9', '0.3', '618.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('82509', 'MEDITERRANEAN LENTIL SOUP WITH SPINACH', '37636', '143', '184.1', '0.9', '0.2', '0', '11.6', '34.3', '13.4', '4.2', '65.6');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('182935', 'MEDITERRANEAN SHRIMP WITH GARLIC CHIPS', '189280', '136', '147.3', '8', '1.1', '142.9', '15.7', '3', '0.5', '0.4', '642.7');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('244722', 'COD WITH MEDITERRANEAN SALSA', '463858', '151', '133.4', '4.3', '0.6', '48.9', '20.7', '2.4', '0.6', '0.5', '208.8');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('220025', 'MEDITERRANEAN CHICKEN SALAD', '463858', '246', '500.3', '27.9', '4.8', '78.8', '31.7', '31.9', '4.5', '9.9', '241.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('131972', 'MEDITERRANEAN TUNA STUFFED TOMATO', '131126', '283', '299.4', '16.7', '3.7', '44.8', '27.9', '10.4', '3.2', '5.1', '567.3');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('323422', 'MEDITERRANEAN CORN SALAD', '464080', '109', '155.7', '5.8', '2.6', '13.4', '6.1', '21.4', '3.6', '0.7', '680.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('221237', 'MEDITERRANEAN SALAD', '171790', '230', '499.1', '21.2', '2.8', '0', '13.9', '64.9', '12.7', '2.5', '862.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('8892', 'MEDITERRANEAN SPINACH', '8975', '132', '72', '2.9', '1.7', '9.5', '6.2', '8.1', '3.9', '2.1', '298.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('317056', 'MEDITERRANEAN DIP DUO', '719083', '174', '413.6', '34.4', '14.5', '53.1', '11.5', '18', '5', '3.2', '846.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('179813', 'MEDITERRANEAN EDAMAME SALAD', '338124', '195', '422.1', '30.8', '5.2', '8.3', '19.6', '22.4', '7.5', '4.4', '437.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('7968', 'MEDITERRANEAN WHITE BEAN SOUP', '148316', '362', '342.4', '4.2', '0.7', '0', '19.1', '59.5', '13.6', '3.1', '28.1');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('243354', 'MEDITERRANEAN SALAD WITH LEMON CAPER VINAIGRETTE', '481092', '158', '334.7', '33.1', '6.8', '16.7', '3.7', '8', '1.7', '2.2', '472.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('84978', 'MEDITERRANEAN SALAD', '27678', '381', '818.8', '45', '6.3', '0', '20.3', '94.4', '35.9', '9', '762.8');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('290384', 'MEDITERRANEAN FRITTATA', '463435', '184', '288.5', '22.8', '7.7', '301.8', '15.3', '5.6', '1.2', '3.4', '656.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('304676', 'MEDITERRANEAN MAHI MAHI WITH OLIVE AND SHALLOT TAPENADE', '725350', '229', '468.5', '35.1', '5', '124.2', '32.6', '5.7', '0.9', '0.2', '589.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('214004', 'MEDITERRANEAN FETA DIP', '296027', '108', '122.6', '9.8', '4.1', '21.2', '5', '5.1', '1', '2.7', '319.5');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('538870', 'EASY FALAFEL', '2001004241', '110', '546.7', '55.2', '4.1', '0', '2.7', '12.7', '2.4', '0.1', '571.9');
INSERT INTO recipes (food_id, food_name, creator_id, serving_size, calories, total_fat, saturated_fat, cholesterol, protein, carbohydrate, fiber, sugar, sodium) VALUES ('70005', '" SUN-DRIED " TOMATOES', '42651', '13', '0.1', '0', '0', '0', '0', '0', '0', '0', '0');
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
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '193');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '16');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '983');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '349');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('293197', '7');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '283');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('487593', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '258');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('47961', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('229948', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('229948', '110');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('229948', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('229948', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('229948', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '525');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '335');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '128');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '307');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '657');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '142');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537245', '190');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '16');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '335');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('158351', '78');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '128');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '512');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '291');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '153');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537248', '467');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '332');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '127');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '52');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '292');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '448');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537249', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '64');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '7');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '139');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '155');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '142');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '350');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537246', '224');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '455');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '78');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('138183', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537247', '304');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537247', '155');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537247', '350');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('537247', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '106');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '128');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '52');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('428004', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '19');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '401');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '39');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('12684', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '310');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '259');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '235');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536387', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '49');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131988', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '235');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '746');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('299973', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '235');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304166', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '214');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '425');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '141');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '286');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '203');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '142');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '324');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('536714', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '128');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '185');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '375');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '731');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('39195', '112');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '209');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('382432', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('111865', '190');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '166');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '221');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '307');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '106');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '236');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '57');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '349');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '324');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220089', '16');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '128');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '139');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('316925', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '216');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '38');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '154');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '163');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('280466', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '448');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '197');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '216');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '119');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('81419', '158');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '352');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '217');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '153');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '142');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('514034', '467');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '209');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '473');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('379639', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '515');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '154');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '348');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('364493', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '221');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '110');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '154');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '119');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '141');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('156662', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '258');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '459');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '19');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('183768', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '49');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '315');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '147');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '320');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '16');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('455488', '335');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '258');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '216');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '106');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '154');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '301');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('82509', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '340');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '297');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('182935', '125');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '119');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '127');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '364');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('244722', '227');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '680');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '347');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '332');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '273');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '236');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('220025', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '395');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '338');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '467');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '502');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '139');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '340');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('131972', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '229');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('323422', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '332');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '112');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('221237', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '363');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '164');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '301');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('8892', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '235');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '119');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('317056', '147');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '673');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '498');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '493');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('179813', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '154');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '106');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '213');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '448');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '348');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '340');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('7968', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '127');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '332');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '155');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '13');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '680');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('243354', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '150');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '188');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '190');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '567');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('84978', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '316');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '148');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '142');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('290384', '467');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '52');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '127');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('304676', '348');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '26');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '314');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '334');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '32');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('214004', '235');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '220');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '171');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '330');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '16');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '20');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '6');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '359');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '337');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '507');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '64');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '55');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('538870', '387');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('70005', '151');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('70005', '495');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('70005', '165');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('70005', '317');
INSERT INTO madeof (food_id, ingredient_id) VALUES ('70005', '334');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '178249', '2003135967', 'Can kalamata olives be substituted for the green olives?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '178249', '2001693157', 'Can kalamata olives be substituted for the green olives?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '178249', '2002470084', 'I know it would be delicious, but must the chicken be grilled? Can it be baked in the oven?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '178249', '2002091378', 'How many calories sodium and carbs in this meal
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '178249', '239767', 'DH and I made this for dinner last night and our only complaint was that we ate too much becuase it was so good! Only change I made was used garlic powder instead of roasted garlic in the tapenade as we were short on time. Thank you for posting.
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '178249', '2001492522', 'Great dish to make and serve right off the grill. Flavor was so wonderful.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '178249', '2002974579', 'Absolutely loved this! We fought over who was getting the left overs for lunch. It was equally as delicious as left overs. I added feta cheese. I may cut the lemon juice down in the veggies the next time.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '178249', '735767', 'This has so much flavor and easy to make! This is will be a new regular at our house!! I served it with some angel hair with a little garlic and olive oil....home run:)
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '178249', '2002012581', 'This was ABSOLUTELY delicious!!! My family loved it and had seconds! I doubled it so my husband and I finished it last night. We sprinkled a little bit of feta on top as well. Thank you for sharing your recipe!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('10', '178249', '2003135967', 'I bought a very cheap roast and stabbed it all over with a fork (just to make sure that it was dead).
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('11', '178249', '239767', 'DH and I made this for dinner last night and our only complaint was that we ate too much becuase it was so good! Only change I made was used garlic powder instead of roasted garlic in the tapenade as we were short on time. Thank you for posting.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('12', '178249', '481092', 'Excellent! Perfect summer dish with the easy to grill chicken and the cool topping. I just used lemon pepper on the chicken instead of juice and peel. Very good. Thanks for posting.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '293197', '2002480485', 'What can the falafel be served with?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '293197', '465829', 'This is good Falafel! I could not find dried fava beans, so I used well drained canned. The blend of spices were so good. I served with Recipe #59336 and some red onions sliced very thinly inside pita bread. I will make again. Made and Reviewed for ANZ Recipe Swap #25 - Thanks! :)
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '293197', '2001112113', 'I love falafel so much and this recipe makes them so easy to do at home. The key is to remember to soak the beans the night before! Followed the recipe exactly and it was great.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '293197', '599450', 'These are as good as any falafel I''ve eaten from American west to east coasts (i.e., San Francisco to NYC). I, too, couldn''t find "broad beans", aka "fava beans", so I used all garbanzo beans, which is fairly traditional from my understanding. Great flavors! I served them in recipe #187699. Thanks, Che floWer! Made for PRMR.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '293197', '498487', 'No stars because I really didn''t know what to expect from this recipe. I''ve never had Falafel before and just thought this would be a nice change of pace. It didn''t go over as well as I''d hoped. We found them bland, which surprised me given the delectable spices that went into them, and dry. Now a friend of mine who has had Falafel in Israel liked them though she agreed they were a bit dry and suggested adding a small amount of extra virgin olive oil to the mix. I may try this again adding oil and doubling the spices, if I do I''ll update my review.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '293197', '1580637', 'First time making (though long time eating!) falafel and this was surprisingly easy and really really good (I used all dried garbanzos though). They were crispy on the outside and super tender in the middle. They had really good flavor too even though I had no coriander nor cilantro. A couple things I''d do different next time, and recommend to others: 1) Careful not to chop/puree the chickpea mixture too much. I over-did it and they were a bit too runny. Stop when the mixture is still a bit course. 2) When deep-frying I found they did best at 350 degrees for 5 minutes (though I found another recipe telling me 375, I thought they came out too dark at that temp). 3) Sprinkle with course salt immediately after removing from the frier, the salt will stick better when they are still hot.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '293197', '2001112113', 'I served them on top of some hummus with pita. So good!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '293197', '2001112113', 'I served them on top of some hummus with pita. So good!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '487593', '2001112113', 'Loved these little fish foil packets so much. They were so easy and the oven does all the work for you which is always a nice bonus. These would be great thrown on the grill as well.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '487593', '612622', 'Sooooo good! I rarely write reviews but this one is worth it. Very quick and easy. I did find that I needed to cook it about 28 min instead of the suggested 15-20. I probably ended up doubling the amount of veggies to just because I love zucchini so much. Very happy I have another new fish recipe in my cookbook! Oh also, I wasn''t able to find an actual Greek seasoning so I got a seasoning that had similar ingredients.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '487593', '2201427', 'Looks (and sounds) awesome!!! Love tilapia!!!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '487593', '914360', 'This looks really delicious !
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '487593', '2206320', 'Awesome recipe ~ mouthwatering!!!!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '47961', '2001112113', 'I love lentils so much, and wanted to try something new. This recipe is a keeper. I''ve never had anything like this before and will definitely be making it again!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '47961', '282673', 'i have made this salad several times now and love it! i use the french puy lentils but don''t cook them as long as the recipe states. i use dried mint, and also reduce the garlic since in this recipe it is not cooked. i founf that this makes great leftovers, the flavors blend and intensify. i plan to make this a lot over the summer.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '47961', '1182971', 'This was really good. I didn''t know what to expect since it is my first experience with lentil salad, but it certainly won''t be the last. The only change I made to the recipe was to lower the amount of oil. I do agree with one review that it is best served in smaller quantities since it is quite bold. I will be making this again.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '47961', '13796', 'I liked this. It was easy to prepare as I had all of the ingredients on hand. I used mint AND fresh basil. I cut out 1 tablespoon each of the oil and lemon juice and it was just right. I brought the lentils to a boil and then turned them down to a very low simmer for 25 minutes. They were almost a little too soft but most of them held their shape really well. I poured ice water over them to stop the cooking process. Good recipe and good for you, too.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '47961', '2002526386', 'I actually tried this recipe because I adore all kinds of varieties and flavors of Salsa that adds to my main dishes. It could be PASTA, a Baked Potato, not just meat, and this particular salsa is DELICIOUS!! Very filling. I highly recommend this salsa recipe if you love Lentils like myself.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '47961', '2002242767', 'For my next meal/leftovers, I added garlic powder, extra lemon juice, salt and pepper to taste, and lemon zest to add a little extra flavor. Those changes helped make it better but still not excellent.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '47961', '167225', 'This is delicious; I''ve had the recipe for a while and made it several times (most recently for a 4th of July barbecue) and everyone who tries it is impressed. I really like the flavor of the mint. This time, I found there was too much dressing (I think this may be in part because I didn''t use the full amount of cheese), so if your measurements are a bit loose, it might be a good idea to whisk those ingredients together and then add as needed. I''ve successfully used balsamic vinegar instead of lemon juice; it''s a different flavor, but still very tasty.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '229948', '844554', 'I''m starting to cook more with balsamic vinegar and this one hit the spot. I used white button, less oil and no salt. Delicious! Made for Zaar Cookbook Tag Game 2011.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '229948', '21752', 'These were wonderful! I used generic button mushrooms on sale at the supermarket and a healthy dash of Moroccan paprika as well. Made for ZWT 5.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '229948', '135470', 'These were good mushrooms, but in making several varieties at once, found them of be lacking in flavor comparatively. The addition of garlic or shallots, would definitely make an improvement. Thanks for sharing your recipe made for ZWT 5 for the Cooks With Dirty Faces
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '229948', '2156777', 'This was quick and easy. I have another similar recipe but it has more spices...garlic, parsley, oregano and such. This is better if I need to put soemthing together quickly though.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '229948', '1060667', 'These were delicious! I do think some chopped garlic would be a great addition, but great as is :)
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '158351', '2002044255', 'What is the bed the salmon is placed upon ?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '158351', '1188676', 'The best salmon recipe on Zaar. I make it over and over again. Sometimes I double the marinade since that is the best part and add a bit of water at the end to have some gravy.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '158351', '277434', 'I baked instead of seared this, mainly because I had a whole side of salmon and was feeling lazy, but it was excellent. I made a fairly large amount of the paste (using the proportions in the recipe of course) which I spread on the flesh side and baked in a rimmed baking sheet at 450Âº for 10 minutes (it was about 1" thick at the thickest). As an aside, the paste did not burn when baking it.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '158351', '137911', 'Awesome recipe!!! I was looking for a pan-seared recipe for salmon and this is wonderful! I did add about 1/2 tsp of tumeric to the marinade, but other than that, it was as listed. I seared it in my stainless steel pan with just a spray of canola oil. I had no problem with sticking. Served this with some jasmine rice and beets (at my dd''s request). Pam
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '158351', '2003097947', 'https://worldfashiontips.com/
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '158351', '496803', 'This was a great flavor combination with the fish. A bit spicy, but not enough to blow your head off, and very easy to mix up. I left the skin on, put the marinade on the flesh side, and let it sit for about 1/2 hour. Then I grilled it skin side down. A wonderful meal, made for ZWT9
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '537248', '2003034514', 'This was almost perfect! I didn''t have a mandolin, so I hand sliced, and loved how delicious the vegetable blend was. The only thing I will change next time is to reduce the lemon zest to about a tablespoon. the zest of one whole lemon almost overpowered the recipe, and my guys didn''t like that. Might also add mozarella cheese to make it a little richer.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '537248', '2002978494', 'To be honest I do not care for lasagna at all but this recipe sounded wonderful so gave it a shot last night. . I did make a few changes from the original. I hand sliced the eggplant and zucchini and were much thicker than Natasha’s so roasted both in the oven for 10 minutes before assembling the dish. I also added lots of mozzarella and Parmesan because I love Gooey food. I used my homemade marinara put the dish together baked and it was beyond fabulous. Will definitely Make again.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '537248', '2002770718', 'Loved cooking this! It was delicious.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '537249', '2000407935', 'There are directions for making the vinaigrette but the ingredients for the vinaigrette are not listed. How much vinegar, orange juice, Dijon mustard, shallots, and garlic?
 ', '3', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '138183', '2001112113', 'Okay, one of the best salmon dishes on this site! I cooked it under the broiler since it''s easier but honestly the salad topping is what really makes it! I love this recipe.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '138183', '8629', 'Loved this! I used kalamata olives. I prepared the topping (less the fresh basil) a day in advance and refrigerated it. I brought the topping to room temperature the next day and added the fresh basil just before serving. I served this with the couscous. I''m glad I have leftovers.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '138183', '2001755986', 'Trying to get my husband to like salmon. He will eat it if I make fresh salmon patties and tolerate one other recipe. I made this last night and he can’t stop raving about it. I did ours on the stove and it was perfect. Crispy on the outside and juicy inside. As I sautéed it I did cut off the thinner ends as they got done and placed them on top of the thicker ends so they’d stay warm. The tomato/olive tepanade was great !
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '138183', '2002039866', 'The salad was good enough to hide the fact that I was using 1.5-year-old frozen salmon fillets, but I bet this would be out of this world with fresh, bbq’d salmon! I used Kalamata olives and dried basil.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '138183', '285039', 'Loved it! Quick and easier version of the copycat Buca Di Beppo Salmon Siracusa I often make! Delish
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '428004', '836852', 'Really liked these veggies! Didn''t have eggplant and used sweet potatoes and threw in some mushrooms, but it was still sooo good. Was even better in leftovers the next day.
 ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '428004', '128473', 'My dh & I really enjoyed this dish. It was the first time that we tried eggplant and we loved it. It was quick and easy to make, tender and crisp with a slightly sweet, yet savory flavor. I used white balsamic vinegar and green onions instead of chives, I also added a small sweet potato. Thank you starrynews for sharing a recipe that we will enjoy again and again.
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '428004', '1226388', 'I love roasted vegetables, but this was even better than I expected. The marinade flavors really come thru, it was sweet and tangy, and really delicious! Thanks for posting this, it really hit the spot tonight! Made for ZWT 9
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '428004', '1169750', 'This was wonderful. There was not one morsel left! Next time, more eggplant, less potatoes. Thanks for posting.
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '428004', '131126', 'We really enjoyed this tasy dish & will make it again. The eggplant was divine & paired wonderfully with the potatoes. The balsamic gave a nice undertone with a slightly sweet highlight. Thank you for sharing the recipe!
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '428004', '2001556102', 'I replaced Eggplant with courgettes and added cherry tomatoes 10 minutes before the end.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '428004', '148221', 'So easy and soooo good! I made a few changes; I used two large potatoes and 2 large zucchini in place of the eggplant, and I didn''t have any chives so I bumped the basil up to 1 tsp in it''s place. I cut my potatoes in smaller chunks to reduce the cooking time, and ended up cooking it 22 minutes, stirring it, then 10 minutes more and my veggies were all nice and soft. I also skipped the cooking spray part and coated my veggies in a large bowl with the oil and herbs. I was a little scared of 2 TBS of vinegar, but it wasn''t a problem at all. I''m extremely excited about this because, to me, I felt like I was eating vegetarian hash but wasn''t missing the meat a bit. Thanks so much!!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '428004', '815198', 'Love this recipe!! It tasted like I the vegetables were grilled, perfect for when it''s not grilling season. I made this as is, except I chickened out on the eggplant and substituted mushrooms instead. We''ll be making this again for sure, so maybe next time I''ll try it out with the eggplant :)
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '428004', '128473', 'My dh & I really enjoyed this dish. It was the first time that we tried eggplant and we loved it. It was quick and easy to make, tender and crisp with a slightly sweet, yet savory flavor. I used white balsamic vinegar and green onions instead of chives, I also added a small sweet potato. Thank you starrynews for sharing a recipe that we will enjoy again and again.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '12684', '2002470084', 'Is there anything else you can substitute for the beans besides chickpeas? I''m not a bean fan but would like to have the protein.
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '12684', '12657', 'This was great! I omitted the feta cheese, and used walnuts instead of pine nuts. Also, I wasn''t sure if you meant dried oregano or fresh, and all I had was dried, so I used the given amount of dried oregano, even though it looked like a bit much! However, it all came together in the end, with the crunch of the walnuts complimenting the kidney beans, tomatoes, and cousous to perfection! Thanks stephanie!
See More  ', '6', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '12684', '143308', 'Yumbo! I used Isreali couscous, which is bigger than other types of couscous and it was fab!
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '12684', '171210', 'I really enjoyed this dish, it was very light and refreshing. The only reason I''m not giving it a 5 star is because my kids weren''t really fans and my husband was indifferent. I will still make this again, but to take for lunch instead of for the whole family. Thanks for the recipe!
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '12684', '126440', 'Loved this salad with Mediterranean Tilapia Pockets. Easy and such great flavors.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '12684', '452355', 'I loved this fresh tasting couscous salad! Perfect combination of ingredients and flavors and it was so easy. I made no modifications. I''ll definitely be making this again! Thanks!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '12684', '2001831916', 'This salad was so good, I used garbanzos instead of the kidney beans, and chopped kalamata olives instead of the pine nuts because the store was out, and a teaspoon of dried oregano because I think the original recipe calls for fresh, but it was perfect! I''d definitely serve it up with some grilled steak or chicken next time.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '12684', '539990', 'Everybody loved it! My daughter had a blast helping make it. We used chickpeas instead of kidney beans. Will make again, thanks!! :)
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '12684', '465460', 'we really enjoyed this, especially with the chickpeas instead of the kidney beans.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('10', '12684', '3288', 'Nice tasting recipe! I fought my need to mess with the recipe and did as posted with the exception of using red beans instead of kidney beans - just what I had on hand. This was subtle, and I can''t wait to see how the tastes meld overnight. Thanks for a great summer salad!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('11', '12684', '145960', 'Very good. I made this ahead of time (8 hours or so) and it was great. I''m eating it today as leftovers. I used toasted slivered almonds instead of pine nuts. Next time I will add sliced kalamata olives. I think it would enhance the recipe alot.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '536387', '2001038345', 'These were awesome! Very quick and easy. And the Tzatziki sauce is very good. This recipe is worth it for that alone.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '536387', '2001736429', 'Easy, delicious, full of flavor. Will put this in the rotation! I do think the turkey burgers need more than 4 mins per side but I am going to grill them the next time.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '131988', '900992', 'The 3-star rating if for the recipe as is. After the following changes, we would rate it 5 stars. <br/>We roasted the red pepper and removed the skin. However, we found the flavor of the kalamata olives to be very overpowering. To fix this, we added an extra half of a red pepper (raw, not roasted), 2 tablespoons of plain yogurt, 1 extra tablespoon of lemon juice, 1 extra tablespoon of tahini, and 1 extra tablespoon of parsley. It was fine after these additions... and this resulted in more hummus :-)
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '131988', '292841', 'Oh my word, thank you for this absolutely fabulous recipe! I thought it was the best hummus I have ever had the pleasure to have tasted. And I made it!<br/>The only thing I did to change it was pour boiling water on my chick peas a couple of times, stir it around a bit to get the skin like covering off the peas. The skin coverings float to the top. <br/>It may take a wee bit more time, but it allows for a more creamier hummus. Again, thank you!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '131988', '402698', 'I made it for myself and a couple of moms I had over for lunch. It was sooo delicious. I like the spiciness...just right!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '131988', '312679', 'OOOH My goodness this is so so yummy! Try this! My friend loved it too!! I also love #117045, #35625, and #11424.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '131988', '89831', 'this hummus is SOOOOOOOO good! I have been wanting to try this recipe for quite sometime and I''m so glad I finally got to making it, it''s just delicious! I increased the garlic and added in lots black pepper, I can''t wait to make this again, thanks for sharing this great hummus recipe hon!...Kitten :)
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '299973', '444132', 'So simple, so delicious, so fresh - this is perfect for such a beautiful sunny spring day! I added some fresh ground pepper, used pearl boccocini for the mozzerella, and vidalia onion for my sweet onion. I love it! Thanks for posting, Brooke! Made for Zaar Stars Tag.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '299973', '494084', 'THis was easy, healthy and good! THe flavor was missing something for me (that I can''t quite put my finer on) but since it was so easy and good for you I''ll probably make it again. Thanks so much Brooke!!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '299973', '191533', 'I was actually surprised at how much my husband ate of this. He''s not big on vinegar. I did think it was lacking flavor so I added sugar, salt, and garlic powder. (didn''t use fresh garlic)
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '299973', '604906', 'Had some chickpeas I cooked myself and this looked like a good recipe to try. I made it twice, added a lot more balsamic vinegar because it didn''t have enough flavor for me. Also left out the cheese the second time, it was just as good.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '299973', '169430', 'This was a most enjoyable salad. With the cheese this could easily be a full meal on it''s own but it was great with grilled chicken. A wonderful balance of flavors.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '299973', '13593', 'I do not hesitate to rate this recipe with five stars. This is so easy, refreshing, and healthy. I followed the directions as written, but did use yellow onion and Kosher salt instead of sweet onion and sea salt. I don''t think it really changed the recipe. This is a nice cooling recipe that is great for summer and lunch boxes. Thank you for sharing.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '299973', '691407', 'I took this salad to a backyard BBQ this weekend as my side dish. It was served with burgers, brats, ribs, hot dogs, etc. The crowd loved it and finished it off. Very easy to make, literally chop everything and throw it into one bowl. I used feta cheese instead of mozzarella, and waited to add it until right before it was served. I also used table salt instead of sea salt, tasted great!!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '299973', '216999', 'Easy to prepare and delicious, this one is a keeper! I left out the parsley and basil and we do not care for them, and used fresh goat-milk feta instead of the mozzarella. Made for the Dining Daredevils for ZWT5.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '299973', '197023', 'A wonderfully delicious - and SO healthy - summer salad. I made this exactly to the recipe - except for using chives instead of the sweet onion and doubling the garlic (a matter of availability and personal taste preferences) and served it on a bed of baby spinach leaves. I''ll be making this again during the summer months. Thank you for sharing another fabulous recipe, Brooke!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('10', '299973', '89831', 'very good although it needed a few amount adjustments and fresh ground black pepper, I used green onions in place of the sweet onion as I have a huge crop in my garden, thanks for sharing Brooke!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '304166', '2001556398', 'I have a couple of quick questions I have never really dealt with english cucumbers. I''ve read about the differences. Can you use plain cucumbers instead? Does it significantly alter the taste of the sauce?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '304166', '2000898883', 'Love this recipe for an easy tzatziki. I don’t salt my cucumber, instead I grate and squeeze them in a dish towel to remove all the liquid. Have never had an issue with watery leftovers. I don’t use a blender, instead I just mix everything in one bowl. And refidgerate for a while. Easy to adjust this to taste.
See More  ', '6', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '304166', '2001160057', 'I worked for a Greek/Lebanese restaurant, and we would make this with sour cream instead of yogurt. Really tasty!
 ', '5', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '304166', '2001067738', 'For 14+ years I lived in Tarpon Springs, FL which has a very large population of Greeks. So, I''ve had real, authentic Greek-style food and my favorite was their gyros. I LOVED those gyros which, of course, are served with tzaztiki sauce. This recipe is amazing! I made it exactly as the recipe stated and it was so good I''m making more for dipping veggies for our Fourth of July party this weekend! I did use an English cucumber because of its mild flavor (I don''t like cucumbers) but I changed NOTHING in this recipe because it was perfect! Thank you so much for such a delicious recipe!
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '304166', '2002225290', 'Made the recipe here''s what I''d change. Use 1 container full fat Greek yogurt as is don''t bother with squeezing. Peel, seed and finely grate 3 cucumbers. Squeeze out liquid from cukes. Using a garlic press take around 10 garlic cloves to start press add more to your preference. Juice of 1 lemon 2 tablespoons each finely chopped mint and dill salt white pepper mix in bowl all ingredients omit blender
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '304166', '2001650017', 'I wanted a garlicy tzatziki so I had to add 11 cloves of garlic. Great recipe! Edit: Tried it an hour later and it was too spicy. Probably should stick to 5-6 cloves
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '304166', '2000165997', 'Don’t Salt the cucumber. Made this recipe per directions. Way too watery and way too salty. Grate the cucumber and squeeze in a towel to get the water out. Unless you’re feeding an army make 1/3 or 1/4 recipe. Don’t process the cucumber - just the other seasonings.
See More  ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '304166', '2895155', 'This was an okay sauce. I''ve made other versions of tzatziki sauce that I liked better. This one came out a little thinner than I would have liked. I think it''s because the recipe has you blend the cucumber and spices before adding to the yogurt. In previous recipes I''ve tried, you just dice the cucumber and add the seasonings to the yogurt instead of blending it all up to make a puree. I probably won''t be making this recipe again.
See More  ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '536714', '505731', 'The last ingredient for the tabbouleh is listed as " 1 other seeds or nuts". What measurement is this "1" referring to? One Tablespoon, One Cup, ??
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '39195', '58104', 'I just love this! I also put raisins(golden) in along with the capers.
 ', '6', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '39195', '2003001761', 'This is a delicious dish, however your recipe is not in the traditional way. This is a Sicilian dish and we don''t use peppers, nor balsamic vinegrette or brown sugar. The authentic way is to use cut whole tomatoes, ONLY Green olives, not the pimentos, red wine vinegar and white sugar to taste. This is a sweet/sour dish. Room temperature over a nice crusted bread or toasted crusted bread is ideal. This is a rustic dish and no pre-manufactured products are needed (puree & balsamic vinegrette)
See More  ', '4', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '39195', '10033', 'I have now made this several times. This is an excellent and versatile recipe--I even froze a bunch of it and have reheated it to serve with pasta or as relish for a main dish. I did leave the skin on the eggplant for color and fiber. I also added a bit of white wine. thanks for posting!
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '39195', '2001112113', 'Such a delicious recipe! I made it just as directed and it turned out great. Perfect as a side or a light summer meal with some crusty bread on the side.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '39195', '37779', 'This caponata was excellent. Very fresh tasting and had lively flavors. I skinned the eggplant because I don''t like the toughness the skin sometimes has. Skipped the anchovies, although next time, I might get brave and try them. I served this on lightly toasted sliced baguette. Made a perfect light supper with a chilled bottle of white wine. Thanks 1Steve.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '39195', '2002180508', 'chiffinade is strips, not finely chopped..like ribbons
 ', '2', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '382432', '573325', 'WOW, absolutely DELICIOUS!!!! Debbie I have eaten quite a number of bulgur salads (always using millet in place of the bulgur), but this one really is one of the best! The flavours mingle perfectly and the dill and feta combined with the tomatoes and spinach are just super yummy! :) I used your recipe #415662 in place of the bulgur and it was very nice. Added a slightly nutty flavour to the salad. I will most definitely make this again as everyone just raved about it! THANKS SO MUCH for sharing this surpreme recipe here with us! Made and reviewed for my chosen chef in Veggie Swap #21 April 2010.
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '382432', '440735', 'Wow! This was delicious. I was worried when I saw the amount of bulgar in the bowl soaking. I had to "nuke" the bulgur because after 40 minutes it was still crunchy. I reduced the dill to one tablespoon because dill is overpowering. I would add a1 tablespoon and a half next time. This salad was surprisingly Fantastic. I only added 3 ounces of Feta because that is what I had on hand. I did add the tomatoes which is a MUST in my opinion. It was so good. Did I say this was good?
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '382432', '42413', 'This was fantastic! My only regret was that I couldn''t get fresh dill (I did use some dill weed though), as I am sure that would have put it into a whole other dimension. Having said that, I loved this recipe! I will definitely be making this for the next gathering I attend. Thanks for posting!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '382432', '358796', 'I made this recipe but tweaked the amounts on ingredients. Only used 2 Tablespoons fresh dill and that was plenty. 1/3 cup would be too much for us. Overall it was good, but can''t give stars since I changed the amounts so much from the original recipe.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '382432', '869184', 'I cannot believe how delicious this salad is! The dill really makes the salad. Do NOT omit the dill when making this salad. I added a bit of lemon juice to the Bulgar wheat before platting, otherwise made as stated. Made for PRMR Tag.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '382432', '2002912073', 'Red onion, bell peppers, and white cheddar instead of green onion, dill, and feta. Also cooked bulgur according to packaging. It was delicious!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '111865', '2001112113', 'I love this recipe! The little salad on top of the avocados is SO flavorful. It goes perfectly with the butteriness of the avocados. It''s a great simple and healthy weeknight meal, or perfect as a side dish! Can''t wait to make again.
 ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '111865', '503845', 'The second time I made this I cheated and bought precut mixture of tomato, onion and jalapeno. Turned out great in half the time. I love bruschetta so this is my new go to item. Also used basil instead of oregano as I love basil.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '111865', '942456', 'So good! We eat lots of avocados here in So. Cal. I see this recipe being used often. I did use cilantro but besides that followed the recipe as written. Can''t wait to try it with balsamic vinegar next time.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '111865', '400708', 'Made these as my contribution to a bar-b-q and they were a big hit. So simple, tasty and looked elegant. I was so pleased. Made exactly as directed except forgot to add the feta cheese. Bought it and all, just plain forgot. It was still awesome and I''ll be making it again. May try balsamic vinager next time as I love the taste. Thanks for posting a wonderful recipe.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '111865', '543977', 'I also added a few olives - and used white wine vinegar instead of red since I didn''t have any - I will definitely be making this again
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '111865', '503845', 'The second time I made this I cheated and bought precut mixture of tomato, onion and jalapeno. Turned out great in half the time. I love bruschetta so this is my new go to item. Also used basil instead of oregano as I love basil.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '111865', '579298', 'Yum!! I even got my little brother (11) to eat this healthy treat :) I subbed red wine vinegar for balsamic. Delicious!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '220089', '2001935726', 'I may have missed it, but is there a list of the nutritional information (including calorie count)?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '220089', '829331', 'So i got excited that i had all the ingredients on hand for a change and prepped this without realizing the crockpot part. ha! So for those without one also, here is a useful tip I found.... "A recipe needing 4-6 hours on HIGH in the crock will need about 90 minutes+ in the oven."
See More  ', '12', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '220089', '39835', 'Very good dinner - I cooked it on low all day and added the beans and cilantro after I came home from work. Very easy to make on a busy day! Thanks for sharing!
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '220089', '541842', 'really delicious and healthy, makes you feel good all the way around :)
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '220089', '388248', 'This was great! My husband, a little picky, liked it as is, but did suggest that a little lemon juice might be good. A definite winner in my house!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '220089', '579298', 'This was AMAZING! I''m not on WW or Core but thought we could use a little more veggies in our diet. I never was a fan of sweet potatoes or cooked carrots before but this dish changed my mind! I simply couldn''t get enough :) the only change I made was subbing the turmeric for saffron. I served this with olive oil and garlic couscous. YUM!
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '316925', '2000798550', 'I am sorry, but this is horrible! First, I should have been instructed to peal the eggplant. Second, 15 minutes, and my eggplant was basically still raw. I threw out all the leftovers, including what would have been my husband’s dinner, as he does not get home until about 9:15. There was no way I was going to serve him this after a hard days work! I really wanted to love this, but following the instructions ver batim, yielded me no dinner for me, or, my husband. I could think of ways to improve this, but seriously, I am still too hungry after no dinner, to even think about it.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '316925', '913360', 'Even my husband liked this recipe and he usually doesn''t get excited over vegetarian meals. I added extra tomatoes and capers; additionally, my mother made this without salting the eggplant (high blood pressure) and it was also very yummy. I served over brown rice and added a bit of asiago at the table. Don''t skip the parsley (sometimes I find parsley is not necessary, I really think in this recipe it is).
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '316925', '1038619', 'This was delicious. I served it over a bowl of polenta, and it was the ultimate comfort-food meal. I''ll be making this again and often.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '316925', '704950', 'So delicious!!!!!! Ragouts are some of my favorite dishes, they have such depth of flavor and the veggies are usually the stars!!! I added a few things to enhance it even further for myself and for fun!!! First, I salted and removed the bitterness of the eggplant then roasted it using recipe # 357852 , recipe#357852,,that I really love the method and flavor of. This really sent the flavor of the eggplant into the stratosphere and lessened the time it needed to be in the skillet. I used fire-roasted tomatoes, threw in some chopped black olives and in place of parsley, I used arugula. This recipe is wonderful, it has great flavor, balance and you can tweak it with a few different veggies here and there that won''t change the delicious outcome!!! Thanks so much for the recipe!!!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '316925', '597999', 'I was going to post this and here it is. This is wonderful. Only change I made was I added crushed red peppers to the onions which spiced it up. We had it over rigatoni. It''s good on it''s own, but I would add a small can of tomato sacue if using over pasta. This is a keeper!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '280466', '552613', 'We are big fans of barley soups and this is a very good barley soup. It was very filling and warming which was perfect for a cold almost summer''s night in London. The only changes I made were to go for the vegetable stock because it was what I had and to skip the oil and use a cooking spray instead to lower the fat of the soup to next to nothing. Made for ZWT4.
 ', '5', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '280466', '137302', 'This is a pretty good soup. The only thing I added was about a half pound of cooked lean ground beef and some kitchen bouquet for a more brown color. The only thing I wasn''t real fond of was that it did have a bit of an acidic taste to it that I kept trying to correct...I wondered if it had a potato or two in it if the flavors would have been blended more. Made for ZWT #6 - 2010
 ', '4', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '280466', '1298125', 'Very good basic barley tomato soup. I make it regularly. I often add more tomatos, barley or peppers, kale, spinach, chicken, beef,whatever moves me.I regularly change up the spicing, adding oregano, basil, sage, whatever I grab out of the spice cupboard.This recipe never fails me, whatever I add or delete it always turns out.
 ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '280466', '401767', 'Very good recipe just as it is, and also lends itself well to using up other orphaned produce in the fridge, or odds and ends in the freezer, cupboard or pantry. It''s hearty, warming, and inviting, and has a greatly satisfying texture and consistency. Last night, I''d added some diced red & green bell peppers and finely chopped baby spinach. If sodium isn''t an issue for someone, a bouillon cube adds a flavor boost, as does 1/2 tsp. of crushed Italian seasoning. It''s tasty with Middle Eastern spices added or great with curry powder or curry paste added for a more exotic faux Mulligatawny variation. Your favorite salsa, picante sauce, a small can of green chilies, or Southwest-style diced tomatoes can change it up easily for a different twist on it, with a handful of crushed tortilla chips or even a few Fritos also tossed into it. Wonderful way to use up any leftover roasted or rotisserie chicken too. Beans, lentils, and peas work great in it also, and when I''m feeling particularly decadent, I quarter 2 hotdog-sized Polska kielbasa sausage links length-wise, and then dice the quarters into small pieces, to give it a hint of rich sausage flavor. Diced leftover Italian sausage or meatballs work well in it, also. It''s hard to go wrong with this soup, since the recipe is both so good and also extremely versatile, so it can be made often and enjoyed in a variety of ways.
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '280466', '2000820349', 'Thank you for posting this! I was looking for inspiration on how to use up my barley and get my kids to like it in the process. I couldn''t follow the recipe to a t, as i was almost out of celery, but it still turned out very well. I think this is a great basic recipe that can me adapted any way you like. Two of my kids did not like it (they are picky eaters, judging food before even tasting it, drives me crazy sometimes). But both my oldest and my husband asked me to make this again. And best of all: my almost 15 month old daughter, who is 99% breastfed because she refuses most food, gobbled this up! She has never before eaten like this and I might even get a good night''s sleep out of that full tummy of hers! And thanks to two of her brothers not eating any, we have leftovers she can feast on tomorrow :-D
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '280466', '2000431901', 'Just needed some salt added. I also topped with fresh parsley.
 ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '81419', '2002430634', 'In another minestrone recipe they use a borlotti bean. Is there another name for it ? Also your recipe is the best I''ve found so far. It''s the oregano definitely. I add more pepper as well. Plus I''ll only add the pasta needed and then freeze the soup. I can boil some pasta as needed in vegetable broth for more flavor. Thanks in advance for your expertise. ?????????? !!! I
See More  ', '2', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '81419', '2001468905', 'Should you drain the beans or add the entire can, undrained. Has anyone used chicken or vegetable broth instead of water?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '81419', '2000767449', 'I made this for Christmas Eve dinner, and it was FABULOUS!!!! My husband loved it, and he''s not a big fan of my cooking! ? That proves this recipe is the real deal. I did use vegetable broth instead of 3 cups of water, and put about 14 fresh spinach leaves in at the last minute. Will definitely make this many times in the future.
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '81419', '25941', 'Uncle Bill, this is fantastic. I followed your recipe exactly but I used vegetable stock instead of water because I had some I needed to use up. My husband takes soup for lunch in the winter and he raved about this when he came home. Thanks for another great recipe.
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '81419', '252514', 'Yum yum! A very warming and tasty minestrone with lots of zucchini (a plus!) It is also very tomato-ey, so if you love tomatoes you will enjoy this very much. My only suggestion is to cook the celery a little longer (with the onions maybe?) so they become more tender. I had to cook my soup awhile more until they softened. Also added some fresh spinach and basil from the garden. Thanks, Uncle Bill. [Made for All You Can Cook Tag]
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '81419', '2002064320', 'I used organic lentils instead of cannellini beans and used fresh tomatoes instead of canned. All the ingredients were fresh and organic and it turned out great! Your recipe was the inspiration for my own version. Thank you for making it easy to follow.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '81419', '2001985209', 'Awesome, easy recipe. It''s super flavorful. I used macaroni instead because that''s what I had. I added a splash of spicy pickle juice because it seemed like a good idea and it turned out nicely. Upped the beans because I love beans. Recommended for cold and rainy days! Thanks Uncle Bill!
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '81419', '173976', 'I don''t understand the excitement and rave reviews about this recipe. It''s just a plain vegetable soup with too much zucchini and celery, and rather bland even with the addition of broth instead of water and extra spices.
 ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '81419', '2000767449', 'I made this for Christmas Eve dinner, and it was FABULOUS!!!! My husband loved it, and he''s not a big fan of my cooking! ? That proves this recipe is the real deal. I did use vegetable broth instead of 3 cups of water, and put about 14 fresh spinach leaves in at the last minute. Will definitely make this many times in the future.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('10', '81419', '1802528797', 'Thank you Uncle Bill for this recipe. So simple and delicious! I was looking for a vegetarian version for minestrone soup. I used chicken stock instead of vegetable, because well I''m not a vegetarian and wanted the flavor of chicken stock. My husband and two small children ate this up with crusty french bread for dipping.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('11', '81419', '697352', 'Mmmmm! Delish! I used chicken broth instead of water and added the whole can of beans. I love this recipe. I will make again and again. Thanks!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('12', '81419', '1997017', 'I cook this every three or four weeks, it''s delicious. I use 1/2 a teaspoon of oregano instead of 1/4, a dash of Worcestershire and Tabasco sauces and a teaspoon of Vegeta. My boyfriend loves it for dinner with hot toast and butter. Yum!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '514034', '1802555155', 'Being half-Israeli, I am immediately skeptical of all shakshuka recipes. This one surpassed all expectations. Great job, Mandy!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '379639', '2001921429', 'Hi everyone, just wondering if this would still be good if kept in the fridge for 24hrs? Would like to prepare day before a party.
 ', '1', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '379639', '2001092295', 'Is Tabouli Gluten free?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '379639', '2153320', 'This recipe totally lives up to its name. The best! I made it with Quinoa instead of bulgar wheat and it was FABULOUS. I just prepared one cup of dry organic Quinoa per the packaging instructions and proceeded as stated. I kept all of the veggies and other ingredients the same as I think Quinoa poofs up a bit more than the bulgar wheat. Plus I like lots of stuff in my salad. I eased up by just a bit on the olive oil and red wind vinegar but I don''t think the whole amount would make much difference. Also, I used about 4 parts parsley to 1-2 parts mint which I got from my garden and is stronger than the stuff you buy in the store. I probably had at least a full 3/4 cup of parsley when chopped. To me, it is hard to determine how much "one bunch" is, so that''s how I handled it. GREAT, GREAT recipe. Seriously the best Tabouleh Salad I have ever made.
See More  ', '5', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '379639', '2032489', 'A most excellent recipe! I cut the recipe in half. No rice wine vinegar - used balsamic instead... and added cucumbers. It is the perfect balance of bulgar to parsley ratio. A few years ago,I needed a last minute dish to take to a gathering. Looking at what I had on hand and following a whim, I stumbled across a fantastic combo of mixing tabouli with a container of classic tuna salad (not mayonaisy) from Whole Foods. The flavors came together perfectly and it was a huge hit! The whole room wanted the "recipe". Since then, when I make tabouli, I often add a can of Albacore tuna to the mix and Wa La(!) - an excellent meal that is appreciated by all. Top with a slice of avocado and you have heaven on a plate. Without fail, recipe requests follow the first bite. It just works. In-joy.
See More  ', '4', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '379639', '394077', 'I love this salad. So refreshing and clean tasting...I can eat it with everything and everyday...so good...thanks for posting it.
 ', '4', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '379639', '1428015', 'I made this recipe 3 times and after experimenting with a couple of additions, I love it. I followed the recipe exactly and then added 1/2 of an english cucumber, chopped, and 1 1/2 packets of raw sugar. This reduced the acidity a little. Shared with others who loved it also. Thanks for posting the recipe.
See More  ', '4', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '379639', '126440', 'I loved the flavor of this salad. I''m not sure if my bulgur was #1 grind so let it sit for one hour, then added the other ingredients. Loved the kick from the cayenne pepper. Served it with Recipe #303946 and Recipe #93401.
 ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '379639', '2032489', 'A most excellent recipe! I cut the recipe in half. No rice wine vinegar - used balsamic instead... and added cucumbers. It is the perfect balance of bulgar to parsley ratio. A few years ago,I needed a last minute dish to take to a gathering. Looking at what I had on hand and following a whim, I stumbled across a fantastic combo of mixing tabouli with a container of classic tuna salad (not mayonaisy) from Whole Foods. The flavors came together perfectly and it was a huge hit! The whole room wanted the "recipe". Since then, when I make tabouli, I often add a can of Albacore tuna to the mix and Wa La(!) - an excellent meal that is appreciated by all. Top with a slice of avocado and you have heaven on a plate. Without fail, recipe requests follow the first bite. It just works. In-joy.
See More  ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '379639', '7578910', 'Tabbouleh has always been something I wanted to make, and this recipe is the one I will use every time! I substituted Quinoa in place of the bulgur, using 1 1/2 cups of dry Quinoa to 3 cups of water and cooking it according to the directions on its package. This made the perfect amount of Quinoa to veggie ratio since I prefer a more balanced salad. Any less Quinoa and I think the parsley would have been too dominant. I used curly leaf parsley, which to me seemed to be just as flavorful as flat leaf but not as pungent. I chopped it very finely and took other''s advice and measured 3/4 cup to 1 cup loosely packed. My "1 bunch" of green onions was 6 onions, and I used the whole onion-- both the green and the white. Where the recipe calls for 1 medium onion chopped, I only added 1/4 chopped to the salad, and it was a little too strong even with such a small amount. So I suggest using a mild or sweet onion or leaving it out altogether; I thought the green onions gave it great flavor on their own. I used fresh garden mint as well and only needed 1/4 cup or less after it was chopped. I used 16oz fresh cherry tomatoes quartered, and kept the olive oil and red wine vinegar as stated. Quinoa can be a little sticky so the oil really helped keep the texture of traditional tabbouleh. My only additions were 1 English cucumber finely chopped, which boosted the texture and flavor immensely, and about 2Tbls of balsamic vinegar to give the salad just a little bit of sweet without having to worry about granules of sugar showing up in the salad. I served this wonderful dish with hummus, pita bread, kalamata olives, and marinated Greek chicken kabobs (recipe was from a different website). Everyone loved it all!! Thank you for sharing this recipe blucoat!!
See More  ', '1', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('10', '379639', '2332788', 'Yummy! I substituted cilantro for one half of the parsley, because that is what I had and used garlic instead of the cayenne....wow.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '364493', '743849', 'We really enjoyed this healthier version of rice pilaf. Great flavor! The extra cooking time (for the brown rice) is worth it - the rice was fluffy and scrumptious! I followed the recipe EXACTLY and I wouldn''t change a thing! Made for Photo Tag.
 ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '364493', '1384367', 'I cut the recipe in half (because there are only two of us in the house), and it came out perfectly. The rice cooked in about 35 minutes and tasted great. Thank you for helping me make fluffy brown rice that my husband will eat without complaining!
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '364493', '1099264', 'Really easy and really tasty. I used all chicken stock instead of water for extra flavor. Also great with mushrooms sautÃ©ed with the onion and pepper.
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '364493', '465911', 'Great recipe.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '364493', '514157', 'Crazy good !!! I used mostly chicken stock for this for more flavor. I used mushrooms as well and red bells too as the others stated . Oh my goodness , The smell of it cooking , is enough to make you faint !! Yummo!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '364493', '1849027', 'Absolutely Perfect! Because of the main dish I was making, I used Beef broth instead of chicken broth. It cooked perfectly and looked beautiful and my family loved it!
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '364493', '1099264', 'Really easy and really tasty. I used all chicken stock instead of water for extra flavor. Also great with mushrooms sauted with the onion and pepper.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '156662', '2002470084', 'Would you cook bone-in, skin on chicken thighs a little longer to thoroughly cook?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '156662', '2001177335', 'A truly simple delicious dinner, husband loved it, definitely make a again!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '156662', '471290', 'Delicious recipe. Wive loves olives and chicken thighs, so this recipe hit the spot. Will make again for sure.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '156662', '288146', 'Fantastic! I subbed a can of diced tomatoes for the fresh as that was all I had on hand and it was awesome! I''m sure it would be better as written but it is great in a pinch. Thanks for the awesome recipe Kitten!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '156662', '885216', 'Great recipe! All the flavors work so well together, it makes a great Mediterranean dish. Wonderful served over cous cous.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '156662', '456860', 'Excellent meal! Easy to prepare and I was able to chop and cut as I went along. The only changes that were made was an increase in garlic, 1.5 teaspoon of chili flakes, and I omitted the grape tomatoes (seemed like a lot of tomatoes already) and the parsley. (I didn''t have any) It reminds me so much of pasta puttanesca which I love. I served it with rice and garlic toast. Mm!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '183768', '2000449361', 'Quick, easy summer meal. I''ve made couscous salad before, using a different recipe. I was looking for something I could make with items I had on hand and this was a winner.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '183768', '1052873', 'Very good. I didn''t have any mint and I think that was needed. It''s a little bland.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '183768', '452355', 'This was a flavorful, easy to make salad. We served as a side to Dolmathes. I had to use shallot in place of red onions, because I was out. We easily halved the recipe ingredients to make a smaller amount. Made for Sun and Spice 2013
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '183768', '299608', 'Super nice twist on a cous cous salad...I used less mint and more parsley than indicated in the recipe b/c i thought equal proportions would be too minty for my liking. The only thing i added was diced tomatoes (which i added at the table so the leftover salad would keep better without tomatoes). If i were serving this as a meal on it''s own I would also add feta cheese! Yum, thanks for a great recipe!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '183768', '47892', 'I added garlic and used this delicious salad as a filling for pita pockets! Use both fresh mint and fresh parsley from the garden, too! I wish I knew what indigo lentils are. They sound delish! Thanks for sharing! cg ;)
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '183768', '452355', 'This was a flavorful, easy to make salad. We served as a side to Dolmathes. I had to use shallot in place of red onions, because I was out. We easily halved the recipe ingredients to make a smaller amount. Made for Sun and Spice 2013
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '455488', '2000254857', 'AMAZING!!!! Licked the bowl clean!
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '455488', '266635', 'Fantastic Hummus recipe -- the best I have tried to date! I doubled the recipe and served it with recipe#427044 (equally delicious). This will be my new "go to" recipe when I want a healthy, delicious appetizer or snack. Thanks for posting this great recipe. Made for Everyday is a Food Holiday tag, October, 2011.
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '455488', '573325', 'Wow, this really is a very tasty hummus! I liked it a lot. It had just the right amount of cumin and tanf from the yoghurt. Next time I would use a bit less garlic but thats just personal prefernce I guess. I reduced the oil a tad cause I like it when my hummus is a bit sturdier instead of super creamy. Its amazing how versatile this recipe is because of the various topping options. This time I used olives and cayenne pepper on top. Mmm! :)<br/>THANK YOU SO MUCH for sharing this keeper with us, Gail Ann!<br/>Made and reviewed for Aussie/NZ Recipe Swap #54 July 2011.
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '455488', '37449', 'I really enjoyed this with chips. It''s the first time my DS has tried hummuus and he couldn''t get enough and has asked me to make more. I was stumped as I had no yogurt or sour cream so subbed mayonnaise. It worked just fine. Thanks! Made for PRMR game.
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '455488', '2001959293', 'This is much better than Zea''s hummus! Best recipe that I have used. Fry up some flour tortillas for dipping. Cut into quarters, fry for about 1 1/2 minuets, better that bagged chips.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '82509', '2002929101', 'keto friendly ?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '82509', '2002786745', 'Why do you put a potato that you shred into the recipe.? Is it to give it an added creaminess?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '82509', '278639', 'I read recipes for Lentil Soup all day looking for just the right one to take to a Soup Luncheon ..... then I found this one and it was perfect. I used a pound package of lentils and it made a huge pot. Very tasty!! Thanks for posting.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '82509', '445442', 'This was delicious! My fiance (the vegetarian) and I (the carnivore) loved it - it was earthy, substantial and flavourful! We made a few tiny adjustments - we used a handful of brown rice instead of the potato, and after the 10 hours of cooking, we added an extra 2 cups or so of broth, and almost double the lemon juice, as well as freshly cracked black pepper. We then cooked it on low for 15 minutes, then on high for another 20-30.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '82509', '109855', 'Loved this stuff. Very easy to throw in the crockpot, wonderful flavors. I love healthy recipes and especially soup that I can take to work. I will definitely make this again - many times! Thanks for posting/ Barb
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '82509', '445442', 'This was delicious! My fiance (the vegetarian) and I (the carnivore) loved it - it was earthy, substantial and flavourful! We made a few tiny adjustments - we used a handful of brown rice instead of the potato, and after the 10 hours of cooking, we added an extra 2 cups or so of broth, and almost double the lemon juice, as well as freshly cracked black pepper. We then cooked it on low for 15 minutes, then on high for another 20-30.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '182935', '498271', 'These shrimp were delicious!! So quick and easy to make and just loved the garlic chips! Didn''t serve it over anything, just ate ''em as they were. Wonderful dish - thanks for posting!
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '182935', '11176', 'Mmm! I used 4 cloves of garlic to 3/4 lb shrimp (it''s the Italian in me), cut back on the red pepper and served it over ramen noodles for a quick, pressed-for-time dinner. Honestly, I could eat those garlic chips all day, every day, but then I suppose I''d lose friends quickly. ;o) Thank you for posting this delicious and fast feast, Recipe Reader!
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '182935', '338451', 'awesome.....my only change would be MORE GARLIC!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '182935', '37636', 'Quick, tasty, and oh so easy! Can I say any more? Everyone loved this, especially the combination of rosemary with garlic, which is a favorite in our house! Thanks for posting- ~Sue
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '182935', '182010', 'Delicious! We all loved the garlic chips. The shrimp were perfectly done, the rosemary just right. Served over linguini with some lemon olive oil.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '244722', '33186', 'Congrats! Your recipe is featured on our homepage today as the "Recipe of the Day" ! (07/29/11)
 ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '244722', '2002398687', 'Great recipe! Will be a go-to for us. I gave it 4 stars instead of 5 for one reason. Spraying a non-stick pan with cooking spray will cause the non-stick surface to lose its non-stick properties. If the pan is non-stick, it shouldn''t be necessary.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '244722', '900992', 'What a delicious recipe! I love the flavors - they do overpower the flavor of the fish a bit, but it doesn''t matter because they are so GOOD!!! This is definitely a keeper. We used a little bit of leftover minced red onion instead of a shallot. It was great.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '244722', '644307', 'I liked the salsa but think it would be better on chicken-probably won''t make this again. There are much better cod recipes here with less prep.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '244722', '133174', 'A delicious and healthy way to serve cod. After getting into the recipes I discovered that I did not have capers so had to leave them out. Also, I used minced red onion in place of the shallots. Even with my subs and omissions this is wonderful. Something I will repeat in the future.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '244722', '452355', 'We loved this recipe! 5 stars all the way! I substituted sea bass for the cod because that is what I had on hand. Also, I grilled the fish on the BBQ instead of cooking it on the stovetop. That is the beauty of this recipe--because the salsa goes on top of the fish after it is cooked, you really can prepare the fish any way you like. I highly recommend grilling it. The salsa had excellent flavor. This is definitely a recipe that I will be making again. Made for ZWT4.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '220025', '452355', 'We liked this chicken salad. DH actually liked it better the next day when he took it for lunch after the flavors had awhile to meld more. This was very easy to prepare as well. We grilled some extra chicken (when making another grilled chicken recipe) to use in this salad, which worked well. I made no modifications to the ingredients. Thanks!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '220025', '679953', 'MamaJ this is one tasty salad . We did halve the recipe for fear our kids would not like. None the less, We have to agree with Toni, the tarragon, lemon, and mustard combo was great. Unbelievable flavors, with great taste. Very enjoyable. Made for PRMR tag.,
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '220025', '305531', 'Wonderful salad! I used some leftover chicken, made as directed otherwise, except that I halved the recipe for 2 of us. Very simple and very tasty. I love tarragon and the combination of the tarragon vinegar, the marinated artichokes, capers and currants was really a great combo. Thanks Mamma J. Made for ZWT4.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '220025', '67656', 'This was so easy to prepare and simply delicious. Looking to make this a little lighter in calories, I only used 2 tablespoons of olive oil and 4 tablespoons of fat free chicken broth. The tarragon, lemon and mustard blended just beautifully and elevated the components of the salad. Thanks!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '220025', '21752', 'To echo Chef echo echo (LOL), loved this, loved this! I used craisins instead of the dried currants, and added a handful of chopped coriander. We served this up with pita and hummous and techina and it was a wonderful lunch on a hot summer''s day.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '220025', '21752', 'To echo Chef echo echo (LOL), loved this, loved this! I used craisins instead of the dried currants, and added a handful of chopped coriander. We served this up with pita and hummous and techina and it was a wonderful lunch on a hot summer''s day.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '220025', '121690', 'Love this, love this! Chicken with tarragon is always a favorite of mine. I used yellow raisins instead of the currants. I do think that next time I might leave out the orzo--it was fine, but didn''t really add anything much for me. That way it would be good stuffed into a pita, I think.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '131972', '2002470084', 'Since you''re not using mayonnaise, could you use tuna packed in oil so it''s hopefully not dry?
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '131972', '386585', 'This was fantastic and really hit the spot! I had some beautiful ripe garden tomatoes, which were perfect in this dish. I also added some minced kalamata olives, which is the only change I made. What a wonderful lunch I enjoyed! I wished I''d taken a photo, but I ate it too fast! Made for Culinary Quest 2016.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '131972', '80353', 'Made a 1/2 recipe of this and cut each tomato in half so we each got a half with Recipe #428353 for lunch. Really good, bright flavours here. I especially enjoyed the addition of pistachios here. Thanks.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '131972', '305531', 'Yum! This was great. I''ve never had a tuna salad before that didn''t have mayo so this was a refreshing contrast. After reading the previous reviews, I added a few more pistachios that I really enjoyed. Since I halved the recipe the ingredients were too few to reach the blade in my mini processor, lol, so I just manually crushed them a bit. Thanks Susie for a nice treat. Made by an Unruly Under the Influence for ZWT6.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '131972', '207616', 'mmmm....I loved it especially since it has some of my favorite ingredients in it. I didn''t have pistachios nuts though :(. Made for ZWT4.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '131972', '5060', 'Delish Susie!! DH loved them as did I. Served them with your recipe #98849, a lovely match! I just made half a recipe for the two of us and used walnuts as that is what I had. It was a lovely cool supper and i will be making them again, thanks for posting!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '323422', '2851666', 'This corn salad was heavenly! The only thing I added was pitted kalamata olives. I also decided to throw in the feta just before serving rather than letting it marinate with everything overnight. Such a great side dish (but I can easily see myself eating a whole bowl of this as a meal, lol)! I featured this recipe in my blog - http://danasfoodblog.com/?p=970.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '323422', '239758', 'Fabulous salad and a great way to use up leftover corn. I cut the kernels off three large cobs that I boiled yesterday. That gave me more than a pound of corn, so I used 2 tablespoons of oil and 3 of red wine vinegar. Also used a little extra feta and about 2/3 of a large red onion, finely chopped. Added lots of basil (don''t forget the basil)! Thanks very much for posting. This is going straight in my 100-star cookbook.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '323422', '383346', 'This salad is so good and the basil really adds ton of flavor. The corn and chickpeas are great together. That''s a great filling lunch. I used fresh red bell pepper. Thanks JanuaryBride :) Made for ZWT8 for Diners, Winers and Chives
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '323422', '869184', 'This was a nice and fresh salad. I opted for fresh orange and green bell peppers, and added chives and parsley for the herb part. I also doubled the vinegar as other reviewers have suggested but I felt that something was missing, or that perhaps the chick peas were a bit out of place in the salad. Perhaps some lemon or lime juice would pick up the flavours as well. Made by Bistro Babes, for ZWT 8
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '323422', '2193767', 'I used the basic recipe as a springboard, and made these changes:<br/>1. Cooked corn from 3 cobs instead of using frozen<br/>2. Included roasted red pepper, marinated artichoke hearts, and sun dried tomatoes<br/>3. Instead of red wine vinegar, I used Pesto sauce. <br/><br/>The salad was a little green due to the Pesto, but the taste was awesome. Will definitely make this repeatedly.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '323422', '2193767', 'I used the basic recipe as a springboard, and made these changes:<br/>1. Cooked corn from 3 cobs instead of using frozen<br/>2. Included roasted red pepper, marinated artichoke hearts, and sun dried tomatoes<br/>3. Instead of red wine vinegar, I used Pesto sauce. <br/><br/>The salad was a little green due to the Pesto, but the taste was awesome. Will definitely make this repeatedly.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '221237', '199848', 'Fantastic salad. The chickpeas make it filling enough to be a complete meal. I made this according to the recipe and included the optional capers and added some sliced onion. Simple but great. Thanx!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '221237', '80353', 'Just the kind of salad my whole family enjoys eating! I had boiled up a batch of chickpeas and cannelini beans to make hummous and used equal amounts of each of those. All the veggies were great - each bite was delightful and different, and the dressing was fabulous. Thanks.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '221237', '953275', 'This was a huge hit, and as it was so quick to make too that made it a hit all round. I made half the batch, exactly as written (ok, yellow pepper instead of red...), and I had a tin of mixed beans instead of just chickpeas. My daughter nearly finished off the entire batch. I imagine cutting the oil back would be equally good, but as is was nice and rich and I liked that the vinegar didn''t overpower the dressing. Thanks Dreamer, I''m sure I''ll make this again again and again.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '221237', '56003', 'Loved this salad! The flavors complemented each other very well. I used some giant garlic stuffed green olives and extra capers. I could eat this every week! Thnx for sharing, Dreamer. Made for KcK''s Forum.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '221237', '386585', 'OMG - this is delicious!!! It makes a super lunch to pack and is very portable. I made it exactly as written, except I did not use stuffed green olives, but a olive combination that included green, kalamata, etc. and I increased the olives to a full cup (because I love olives). I also did not julienne the peppers, but chopped them instead. Anyway...this was delightful and will be made regularly. Thanks for posting. Made for All New Zaar Cookbooks Tag Game.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '221237', '953275', 'This was a huge hit, and as it was so quick to make too that made it a hit all round. I made half the batch, exactly as written (ok, yellow pepper instead of red...), and I had a tin of mixed beans instead of just chickpeas. My daughter nearly finished off the entire batch. I imagine cutting the oil back would be equally good, but as is was nice and rich and I liked that the vinegar didn''t overpower the dressing. Thanks Dreamer, I''m sure I''ll make this again again and again.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '8892', '14613', 'this was pretty good. i prefer sauteing the spinach in oil and not water. good with goat cheese instead of feta.
 ', '6', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '8892', '36777', 'Found this to be superb & authentic. Reminded me of the foods we ate while touring Italy and Greece. Thank you for sharing.
 ', '5', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '8892', '486725', 'I did alter this a bit, but we loved it that way. I looked at the other reviews and decided to add oil and lemon. I also barely wilted the spinach (and added much less, because of it), used more fresh dill and capers, and added potatoes, to make a meal out of it. The capers, dill, potatoes and feta went so well together in this. As another reviewer mentioned, it makes a delicious base to potentially add things to (like beans, potatoes, etc.).
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '8892', '470351', 'Very tasty spinach dish! I loved the combo of flavors and was surprised at someone''s comment that the dill made it awful. I used fresh dill and barely noticed it in this dish. I sauteed the onions, garlic and dill with a bit of olive oil...then also tossed in the tomatoes for a minute before removing all from heat. I loved the low fat method of cooking the spinach with water. I tried it and loved it. The pairing of capers and feta with this was also really great. I will definitely make this one again.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '8892', '593513', 'Oh My, this was really tasty. Was just looking for something to do with my leftover spinach and thought I would try this. Really glad I did. I sauteed the onions garlic and dill in some oil. Used Campanari (cherry) tomatoes because those are the only ones I find have any real flavor here in this City. After the onions and garlic were done sauteing I threw the tomatoes in for about 30 seconds. Sauteed the spinach in a little olive oil and not water. I really found this a delicious quick salad to put together. Didn''t come anywhere near 25 minutes to cook though. And so colorful when put together. Thanks so much for posting Mary. Loved it.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '8892', '276108', 'SUPER! My husband and I both loved this. I did make a couple of minor changes, I used a large can of spinach instead of fresh and used cherry tomatoes (they are the only ones with flavor now) which I stirred into the spinach mixture just before removing from the heat. The dill gave it a hit of tartness similar to the splash of vinegar we normally add to spinach. Thanks so much for a new favorite!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '8892', '184530', 'This was exceptionally tasty, and very easy to prepare. I used 600 grams of baby spinach leaves, dried dill, and everything else as listed. I cooked the onions for a few minutes, added the tomatoes and cooked them for a few minutes, then added the spinach to the same pan. I also used olive oil in place of the water. Will make again!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('8', '8892', '15892', 'I doubled the garlic and only had on hand about half the spinach. I, too, used olive oil, and would consider trying it with chicken broth instead of the water. I don''t like dill, but I stuck to it and used my dried. I also added a breath of red pepper flakes just before step five, added a splash of lemon at the end of step 7 and I DIDN''T discard the liquid. Very tasty. I had it with some leftover swordfish that I flaked and stirred throughout. This would also be nice over rice or pasta, or with some canned garbanzo or white beans thrown in. The feta was the perfect touch. Would also be nice with fresh shredded parmesan, pine nuts or some cumin. What a nice base! Thanks, Mary! I can''t wait to expand on this (or just keep it simple....)!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('9', '8892', '14613', 'this was pretty good. i prefer sauteing the spinach in oil and not water. good with goat cheese instead of feta.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '317056', '204024', 'This is a great combination. I cut this in half and used basil as my italian seasoning. Made for ZWT6 for the Voracious Vagabonds
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '317056', '61660', 'I thought the salsa was totally awesome!! Loved all the flavors and the feta added just the right kick to make it a little different from other salsas. Lovely!! The hummus was good, but I can''t say I could find any noticeable difference with the addition of the sour cream. Served with garlic pita chips!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '317056', '779699', 'Sooo easy and yummy! I doubled the recipe and I only got a little taste as I sent this with DH and his friends for their annual "guy''s weekend" at the lake! There was none left after the first night according to DH! I sent stacy''s pita chips and they loved it! Thanks for posting! Made for The Queens of Quisine ZWT6 Zingo!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '317056', '428885', 'This was a delightful duo from my teammate! I agree with other reviewers, the feta part of the salsa was a huge hit, nice and salty, mixing with the onion, garlic, and Italian seasoning you simply cannot go wrong. The hummus was great too, I didn''t realize you could make a creamer version by just adding sour cream!! This is totally delish and served with homemade pita chips! Made for ZWT6 2010
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '317056', '1637137', 'I tried the Salsa dip only and found it to be excellent! I was surprised at how the simple ingredients meshed well together. This would also be good on crostini if pita chips are not available
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '179813', '333017', 'My DD got into an Edamame kick a while ago, so I was buying them in packages at Costco. Well, she stopped eating them...for whatever reason and didn''t tell me, so I had a freezer full of beans. If the recipe turned out the way I was hoping it would, I would use it for our rehersal dinner for when my second DD gets married. We loved it! The salad had the crunch from the beans, sweetness from the tomatoes and salt from the cheese and olives!! I am not a big fan of oil floating around my foods (in fact, it turns me off totally!!) so I did make some changes. I had made a garlic infused oil (for another recipe) and had some of the oil and cooked garlic left over. I used some of the sun-dried tomato oil and the garlic infused oil and the left over garlic chips. I probably did not use even 1 T. It passed the "bride has to try everything and see everything" test and loved it!!! I dehydrate roma tomatoes when they come on sale... so next time, I will use half of my tomatoes and half of the oil infused tomatoes to use them up. If anybody else buys edamame at Costco, 3 cotainers equals just shy 2 cups. I have company coming in the next 2 weeks, so I think this recipe will get a good workout from me! Thanks Chef!!
See More  ', '3', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '179813', '269829', 'I tried this recipe for a potluck and we loved it! (I tripled the recipe.) It is a very aromatic dish that scents the whole house. Mmm! The only changes made were: I snipped the sun-dried tomatoes into small bits and by the time I had added about 2/3 cup of them to the edamame it looked like more would overwhelm the salad, so I didn''t triple the amount of sun-dried tomatoes, but sliced and added about a pound of fresh ripe cherry tomatoes, instead. I couldn''t find feta cheese, so substituted goat cheese (I read that it''s a healthier cheese, anyway, with less fat and less salt). For the dressing (step 2), I decided I would like my garlic pureed, so I mixed the dressing in the blender. I feel like I have too many vinegars already on hand, so used red wine vinegar instead of buying white. I couldn''t find white balsamic vinegar, so substituted what I found, which was golden balsamic vinegar. I also had forgotten to buy fresh oregano, so substituted 1/3 as much dried oregano, and I used extra-virgin olive oil. I mixed the edamame, tomatoes, onions and olives, then added the dressing. I found I needed only half of the dressing, so have kept the rest of the dressing aside, in a container in the fridge. Next time I will reduce those ingredients by half. This helps make the recipe lower in fat, too. The cheese was added just before serving. On re-visiting the left-overs the day after, I have found that even if certain ingredients are left out, it still is terrific! My husband picks out the onion and I pick out the olives, but it''s delicious even without those. Some of the salad was left without cheese because there were vegans at the potluck -- and it tastes delicious without the cheese, as well.
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '179813', '2001650987', 'I used all the ingredients listed plus added an English cucumber quartered, some mini red, orange and yellow peppers chopped. I didn''t have the white vinegars on hand so I replaced it with Wegman''s balsamic vinaigrette dressing, It was delicious!! I will be making this again for sure! I did omit the garlic and the fresh oregano, because there was garlic in the dressing and I was out of fresh oregano. I think fresh basil would be delightful in it too, or maybe even a little mint! I have a wonderful cayenne pepper olive oil I will use next time, and probably stick with a balsamic vinegar as well.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '179813', '414452', 'This is just EXCELLENT! The flavors are fantastic. I used kalamata olives, (I would recommend you NOT use the canned black olives). I omitted the feta as I am not a fan. Double the batch as you will want more.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '179813', '266635', 'Delish!! This salad was fantastic and the presentation is so colorful. Great on flavor and a great dish to wow your guests. This salad could not go wrong as it has everything I love in it. I will definitely make this dish again and again!!!! Thanks for the post.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '179813', '269829', 'I tried this recipe for a potluck and we loved it! (I tripled the recipe.) It is a very aromatic dish that scents the whole house. Mmm! The only changes made were: I snipped the sun-dried tomatoes into small bits and by the time I had added about 2/3 cup of them to the edamame it looked like more would overwhelm the salad, so I didn''t triple the amount of sun-dried tomatoes, but sliced and added about a pound of fresh ripe cherry tomatoes, instead. I couldn''t find feta cheese, so substituted goat cheese (I read that it''s a healthier cheese, anyway, with less fat and less salt). For the dressing (step 2), I decided I would like my garlic pureed, so I mixed the dressing in the blender. I feel like I have too many vinegars already on hand, so used red wine vinegar instead of buying white. I couldn''t find white balsamic vinegar, so substituted what I found, which was golden balsamic vinegar. I also had forgotten to buy fresh oregano, so substituted 1/3 as much dried oregano, and I used extra-virgin olive oil. I mixed the edamame, tomatoes, onions and olives, then added the dressing. I found I needed only half of the dressing, so have kept the rest of the dressing aside, in a container in the fridge. Next time I will reduce those ingredients by half. This helps make the recipe lower in fat, too. The cheese was added just before serving. On re-visiting the left-overs the day after, I have found that even if certain ingredients are left out, it still is terrific! My husband picks out the onion and I pick out the olives, but it''s delicious even without those. Some of the salad was left without cheese because there were vegans at the potluck -- and it tastes delicious without the cheese, as well.
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('7', '179813', '11176', 'Very tasty! I omitted the sun-dried tomatoes for our tastebuds, subbed white onions for red, regular balsamic for white and kalamata for black olives, but it turned out very nice and something I''ll definitely make again. Thank you, Chef #338124!
See More  ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '7968', '4399', 'I found this recipe to be very good, but only gave it four stars as it called for (in my opinion) way too much celery and onions. I cut the onions back to 1/2 cup and the celery to 1 cup. I also added 1/3 cup grated carrots. My husband loved it!
 ', '10', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '7968', '2041603', 'I''ve had this with the lemon juice and without as well as with chicken and with beef broth. Each time tasted great. It does take a little bit of time to cut up the onion, potato and carrot but it''s worth it. Great soup.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '7968', '1223517', 'Love this soup. First time i made this with homemade veg and chicken stock and 2nd time just homemade veg stock with a chicken stock cube. The first method seemed better
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '7968', '55589', 'This bean soup has become a staple in my house. And it''s proof that a bean soup does NOT need pork or bacon in it to be delicious. The only thing I do differently is add an extra potato for more thickness. Great recipe!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '7968', '965764', 'Super tasty! And pretty easy to make too. I only had one can of cannelini beans on hand, so I improvised a bit. Reduced the amount of stock used in each of the steps (but used close to 3 cups total). Forgot the lemon juice and it still was delicious! Increased the rosemary since it''s my favorite herb. Thanks so much for sharing...I know this will be in the regular rotation as we come into fall/winter.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '243354', '593513', 'Oh my Lord !!! This was such a yummy salad and a such a fantastic dressing to go with it. Did everything as written but I did cut way back on the oil though and added extra capers....I love them. We found it had a lovely blend of the lemon and vinegar. It was actually a very quick salad to put together. I served it as a side to some manicotti''s . I can see just eating a whole plate of just the salad and forget anything else. Will be making this salad often...Thanks so much for sharing Vicki.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '243354', '239758', 'The salad mixture was very nice, but I prefer a dressing with more tang and less oil. Loved the capers though. I would add 1/4 teaspoon salt and use castor sugar in place of honey (or leave sweetener out completely). The honey taste was quite strong, but perhaps it was just my variety of honey. Thanks for posting.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '243354', '56003', 'This was just straight out delicious! Everything I like, and still pretty good for me! Thnx for sharing it, Vicki. Made for a fellow Vagabond during ZWT 6.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '243354', '246482', 'This is a keeper, Just love the dressing Made for ZWT4 for the Chic Chefs. Ps I finally gotto use the bottle of capers I bought months ago.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '243354', '251917', 'ZWT4: OUTSTANDING!! The lemon caper vinaigrette definitely pulls this dish together - WOW!!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '84978', '593513', 'This was such a flavorful salad. I made it according to the recipe except I cut the recipe in half and didn''t use green peppers only because my friend doesn''t like the green ones. Made this early in the morning to bring for lunch then added the avocado at lunchtime. The flavor of the balsamic dressing was really good with this salad. I had put the Za''aar seasoning,salt and pepper in with the oil and balsamic to mix all together then blended it in with the salad. So yummy and will be making this again. Made with Shish Taouk Recipe #66035 Thanks so much for sharing your recipe Sackville..We loved it and I will be making this again.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '84978', '545825', 'I''ve had this in my cookbook for ages, but never made it because I didn''t have Zatar seasoning. I finally found some though and made this salad. We really enjoyed it. Colorful, healthy, flavorful and easy!! As with every recipe I make that has a "add ______ just before serving," I forgot to add the avocado! I did prepare this a couple hours ahead of time adding everything but the avocado. It smelled wonderful!! I also ended up roughly dicing the peppers after sauteing them. I just wanted everything to be about the same size. Thanks for posting this, I''ll be making this one frequently.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '84978', '168282', 'This is really, really good stuff. I mean really good! I didn''t have the spice, so I used 1 tsp marjoram and thyme, 1 tbsp sesame. I also replaced the avocado with an english cucumber. Absolutely wonderful. Served with spinach pie.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '84978', '117438', 'Oh Friedel, we really enjoyed this as a main dish salad. I cooked up all the capsicum and let it sit with the other ingredients until we were ready. The contrast of textures, colours, made it truly wonderful. Thanks again for sending the za''atar, I''ll have to work on the substitute now because this is a definite make again. I too forgot the parsley, but it was still so flavoursome without. Next time I will add more artichokes as I accidentally bought too small a jar!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '84978', '37636', 'This is an outstanding salad that is rich and full of exciting flavors that make a superb accompaniment to a Middle Eastern or mediterranean type meal. I served this with Chicken ala Turk, recipe 74351, and used this as a side salad. I think the ingredients could easily be adjusted to taste among the artichokes, peppers, chickpeas, and avocado. Roasted chicken would also be an interesting addition to this, I think, to make this a main dish salad. You might just need to add a little bit more dressing. I realized after the dinner was over that I had forgotten to add the parsley to this, and that would have added yet another dimension of flavor to an already fantastic salad, although it tasted great as it was. I am definitely going to be making this again! Thanks, SG!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '84978', '168282', 'This is really, really good stuff. I mean really good! I didn''t have the spice, so I used 1 tsp marjoram and thyme, 1 tbsp sesame. I also replaced the avocado with an english cucumber. Absolutely wonderful. Served with spinach pie.
 ', '0', 'tweak');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '290384', '133174', 'This was reduced to 2 servings and cooked in a 6-inch skillet. Made a lovely brunch for DH and me. By flipping this onto a plate and sliding it back into the pan, it was cooked entirely on top of the stove.
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '290384', '2000407935', 'This frittata has a great combination of flavors. Use the basic instructions to devise your own combinations. Saute the veggies, whisk up the eggs and spices, fry to set, broil to finish. I use a frittata to use up bits of leftover veggies and meats. Let your imagination take over! Mexican with Pico de Gallo and cumin, Italian with tomatoes and basil, American with hot dogs and cheddar.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '290384', '498271', 'What a delightful meal! I used a little less oil, otherwise made as directed. Absolutely loved all that fresh basil with all those veggies and the feta. Easy to make and full of flavor - thanks for sharing a keeper!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '290384', '546010', 'This is amazing. The flavor is perfect. I didn''t tweak it, whatsoever. That has got to be a first! This will be in our rotation of meatless EGGSiting dinner dishes. The timing was spot on as well. Just perfect.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '290384', '222478', 'Tasty! Beautiful combination of flavours and it was much enjoyed as a light dinner. I thought the quantity of olive oil may have been a little too much at first but using a good quality one it really added to the dish and kept it all nice and moist.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '304676', '2002305701', 'Could you use salmon instead of mahi mahi?
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '304676', '452355', 'This was a great dinner. It was a little labor intensive, but well worth the end result and all the wonderful flavors. I used fresh herbs from my garden and kalamata olives. We did not modify this recipe a bit, nor would we recommend any changes. Thanks for a lovely meal and one that we will be making again.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '304676', '942099', 'my boyfriend really loved this. he''s not too big of an olive person but this really worked well for him.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '304676', '940393', 'Quite tasty and good for a change of pace. In a pinch dry substitutions will work but of course compromise the fresh taste.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '304676', '866232', 'Very tasty, fresh, and high end-tasting. My wife said it may have been the best meal I ever made--and I have made many good ones. Thanks for sharing this impressive recipe. P.S. - Prep time for me was much longer than 20 minutes maybe because of all the gathering, washing and chopping--maybe 50-60 minutes total.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '214004', '2002417202', 'How long can this dip be made ahead of time??
 ', '0', 'question');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '214004', '900992', 'This is delicious! We had to make some changes because we ran out of some things. We used 1/4 c. half-and-half instead of 1/2 c. milk because we discovered that our milk was bad when we got ready to measure it. Also, we only had about 2/3 c. feta cheese left, so we put all of that in. I''m actually glad that''s all we used because I think I would have found the feta flavor overpowering had we used the specified amount. Lastly, rather than roasting the red pepper and using it for garnish, I roasted it and just threw it into the food processor with the rest of the ingredients. Next time, I might cut back on the hot sauce. I like the heat it imparts, but the flavor is too prominent. I also think that I will throw the kalamata olives in with the rest of it next time, rather than using them for garnish.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '214004', '220348', 'This is a creamy and smooth dip that everyone should try! It is also very refreshing, and made me think of summer, so I''ll try again, then. The hot sauce made the dip a bit tangy as opposed to hot, but I kind of liked it that way. Veey good with pita bread.
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '214004', '880889', 'This recipe is a keeper! I had grown tired of hummus over the summer and was looking for something a little different. This was it! It is not really hot/spicy with the hot sauce, but well seasoned and the flavors really blend well together. A snap to make. Served with pita chips and cucumbers. I used low fat feta and it did not seem to affect the outcome. You''ll get raves with this one!
See More  ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '214004', '239758', 'Wonderful dip that has a nice little kick to it. I used a little less milk because I added the moist roasted red pepper to the main dip mix. Served at work for Friday night drinks with cucumber slices, celery sticks and bread.
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('6', '214004', '945248', 'Wow... This was good! We used Syrian bread wedges to scoop it up!
 ', '0', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('1', '70005', '11176', 'Without knowing how many tomatoes to use, I settled on 7 medium-sized beauties. The end result was a tad over-seasoned; I think about 10-11 tomatoes of this size would have been perfect for me. I baked them for 6 hours and they were still a little wet to the touch, so I put them in the dehydrator overnight on a low setting and they came out nice. I had them in a pasta and prosciutto with arugula pesto last night and we both had seconds. Oh, the aroma... ~*inhales deeply*~ YUM! :) Thanks for the lovely recipe!
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('2', '70005', '56181', 'These were very easy to make and very tasty! It doesn''t say how many tomatoes to use, but I used about 5. I also didn''t have the fresh spices on hand so I used about 1 tsp of garlic salt, 1 tsp basil, and 1 tsp of oregano, put them together in a ziploc baggie and ran my rolling pin over it a few times to make the spices extra fine. Anyway, this was a great way to use up some extra tomatoes and I will definitely make again!
See More  ', '2', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('3', '70005', '2001112113', 'I didn''t know you could make "sun-dried" tomatoes at home. They were so easy to make. Perfect in pastas!
 ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('4', '70005', '1666717', 'This was a vary easy recipe. I used three different types of cherry tomatoes (yellow pear, sun sugar, and red cherry) and a food dehydrator instead of the oven they took about 12 hours to dry. They turned out awesome and we ended up doing about 2 gallons of tomatoes.
See More  ', '1', 'review');
INSERT INTO posts (post_id, food_id, user_id, content, likes, type) VALUES ('5', '70005', '231057', 'Another great review for a great recipe! I put all the "cleaned" tomato pieces in a big bowl and drizzled with the olive oil and seasonings, then laid them out on the foil lined cookie sheet (quicker for me). Loved the aroma in the house while these were baking and they are so good. Put the pieces in small baggies for the freezer for future use also. (This is an experiment on my part - I have never frozen sun dried tomatoes.) Thanks for the wonderful recipe!
See More  ', '1', 'review');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '178249', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '178249', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('7', '178249', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('8', '178249', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('9', '178249', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '293197', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '293197', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '293197', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '293197', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '293197', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '487593', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '487593', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '487593', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '487593', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '487593', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '47961', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '47961', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '47961', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '47961', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '47961', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '229948', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '229948', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '229948', '3.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '229948', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '229948', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '158351', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '158351', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '158351', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '158351', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '158351', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '537248', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '537248', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '537248', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '138183', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '138183', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '138183', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '138183', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '138183', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '428004', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '428004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '428004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '428004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '428004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '12684', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '12684', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '12684', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '12684', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '12684', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '536387', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '536387', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '131988', '3.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '131988', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '131988', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '131988', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '131988', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '299973', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '299973', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '299973', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '299973', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '299973', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '304166', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '304166', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '304166', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '304166', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '304166', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '39195', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '39195', '1.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '39195', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '39195', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '39195', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '382432', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '382432', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '382432', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '382432', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '382432', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '111865', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '111865', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '111865', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '111865', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '111865', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '220089', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '220089', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '220089', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '220089', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '220089', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '316925', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '316925', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '316925', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '316925', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '316925', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '280466', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '280466', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '280466', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '280466', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '280466', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '81419', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '81419', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '81419', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '81419', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('7', '81419', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '514034', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '379639', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '379639', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '379639', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '379639', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('7', '379639', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '364493', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '364493', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '364493', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '364493', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '364493', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '156662', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '156662', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '156662', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '156662', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '156662', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '183768', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '183768', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '183768', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '183768', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '183768', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '455488', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '455488', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '455488', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '455488', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '455488', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '82509', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '82509', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '82509', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '182935', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '182935', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '182935', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '182935', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '182935', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '244722', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '244722', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '244722', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '244722', '3.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '244722', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '220025', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '220025', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '220025', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '220025', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '220025', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '131972', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '131972', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '131972', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '131972', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '131972', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '323422', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '323422', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '323422', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '323422', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '323422', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '221237', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '221237', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '221237', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '221237', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '221237', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '8892', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '8892', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '8892', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '8892', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '8892', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '317056', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '317056', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '317056', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '317056', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '317056', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '179813', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '179813', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '179813', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '179813', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '179813', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '7968', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '7968', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '7968', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '7968', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '7968', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '243354', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '243354', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '243354', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '243354', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '243354', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '84978', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '84978', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '84978', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '84978', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '84978', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '290384', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '290384', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '290384', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '290384', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '290384', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '304676', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '304676', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '304676', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '304676', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '304676', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '214004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '214004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '214004', '0.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '214004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('6', '214004', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('1', '70005', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('2', '70005', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('3', '70005', '5.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('4', '70005', '4.0');
INSERT INTO reviews (post_id, food_id, rating) VALUES ('5', '70005', '5.0');