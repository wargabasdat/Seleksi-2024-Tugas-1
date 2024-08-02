DROP TABLE IF EXISTS users_phones;
DROP TABLE IF EXISTS dimensions;
DROP TABLE IF EXISTS resolutions;
DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id_user INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    total_screentime INT,
    avg_screentime_perday INT,
    CHECK (total_screentime >= 0),
    CHECK (avg_screentime_perday >= 0)
);

CREATE TABLE phones (
    name VARCHAR(255) PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    battery_mah INT,
    ram_gb DECIMAL(7, 3),
    storage_gb DECIMAL(7, 3),
    weight_gr INT,
    release_date DATE,
    os VARCHAR(20),
    nfc ENUM('Yes', 'No'),
    display_size_inch DECIMAL(7, 3),
    price DECIMAL(7, 3),
    CHECK (battery_mah > 0),
    CHECK (ram_gb > 0),
    CHECK (storage_gb > 0),
    CHECK (weight_gr > 0),
    CHECK (display_size_inch > 0),
    CHECK (price >= 0)
);

CREATE TABLE dimensions (
    name VARCHAR(255) PRIMARY KEY,
    height_mm DECIMAL(7, 3),
    width_mm DECIMAL(7, 3),
    thickness_mm DECIMAL(7, 3),
    FOREIGN KEY (name) REFERENCES phones(name),
    CHECK (height_mm > 0),
    CHECK (width_mm > 0),
    CHECK (thickness_mm > 0)
);

CREATE TABLE resolutions (
    name VARCHAR(255) PRIMARY KEY,
    height_px INT,
    width_px INT,
    FOREIGN KEY (name) REFERENCES phones(name),
    CHECK (height_px > 0),
    CHECK (width_px > 0)
);

-- Create the users_phones table
CREATE TABLE users_phones (
    id_user INT NOT NULL,
    phone_name VARCHAR(255) NOT NULL,
    purchase_date DATE NOT NULL,
    PRIMARY KEY (id_user, phone_name),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (phone_name) REFERENCES phones(name)
);

DELIMITER $$
CREATE TRIGGER before_phone_delete_dimensions
before DELETE ON phones
FOR EACH ROW
BEGIN
    DELETE FROM dimensions WHERE name = OLD.name;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_phone_delete_resolutions
before DELETE ON phones
FOR EACH ROW
BEGIN
    DELETE FROM resolutions WHERE name = OLD.name;
END $$
DELIMITER ;


DELETE FROM phones WHERE name IS NULL OR brand IS NULL OR battery_mah IS NULL OR ram_gb IS NULL OR storage_gb IS NULL OR weight_gr IS NULL OR release_date IS NULL OR os IS NULL OR nfc IS NULL OR display_size_inch IS NULL OR price IS NULL;