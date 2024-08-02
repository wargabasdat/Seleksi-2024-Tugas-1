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
