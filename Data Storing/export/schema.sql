DROP TABLE IF EXISTS `weather`;

DROP TABLE IF EXISTS `location`;

DROP TABLE IF EXISTS `scrape_logs`;

CREATE TABLE `location` (
  `station_code` varchar(255) NOT NULL PRIMARY KEY,
  `city` varchar(255),
  `state` varchar(255),
  `country` varchar(255)
);

CREATE TABLE `weather` (
  `station_code` varchar(255) NOT NULL,
  `datetime` datetime NOT NULL,
  `temperature` float,
  `dew_point` float,
  `humidity` float,
  `wind` varchar(255),
  `wind_speed` float,
  `wind_gust` float,
  `pressure` float,
  `precipitation` float,
  `condition` varchar(255),

  PRIMARY KEY (`station_code`, `datetime`),
  FOREIGN KEY (`station_code`) REFERENCES `location`(`station_code`),

  CHECK (`temperature` >= -273),
  CHECK (`dew_point` >= -273),
  CHECK (`humidity` >= 0),
  CHECK (`wind_speed` >= 0),
  CHECK (`wind_gust` >= 0),
  CHECK (`pressure` >= 0),
  CHECK (`precipitation` >= 0)
);

CREATE TABLE `scrape_logs` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `datetime` datetime NOT NULL,
  `station_code` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) NOT NULL,
  `error` text
);