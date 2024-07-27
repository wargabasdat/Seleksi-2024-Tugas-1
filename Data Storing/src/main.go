package main

import (
	"CF-Scraper/models"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

func main() {
	// Load the .env file
	err := godotenv.Load()
    if err != nil {
        log.Fatal("Error loading .env file")
    }

    // Define the data source name (DSN)
	username:= os.Getenv("DB_NAME")
	password:= os.Getenv("DB_PASSWORD")
	dbname := "CF_Scrape"
    dsn := fmt.Sprintf("%s:%s@tcp(127.0.0.1:3306)/%s", username, password, dbname)


    // Open a connection to the database
    db, err := sql.Open("mysql", dsn)
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    // Verify the connection is valid
    err = db.Ping()
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println("Successfully connected to the database!")

	// Create the table
	err = createTable(db)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Table created successfully!")

	// Seed the database
	err = seedDB(db)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Database seeded successfully!")
}

func createTable(db *sql.DB) error {
	// Create the designed table

	/**
	* Contest table
	* Problem table
	* Contributor table
	* Tag table
	* ContributorContest table
	* ProblemTag table
	*/

	_, err := db.Exec(`DROP TABLE IF EXISTS ProblemTag`)
	if err != nil {
		return err
	}

	_, err = db.Exec(`DROP TABLE IF EXISTS ContributorContest`)
	if err != nil {
		return err
	}

	_, err = db.Exec(`DROP TABLE IF EXISTS Tag`)
	if err != nil {
		return err
	}

	_, err = db.Exec(`DROP TABLE IF EXISTS Contributor`)
	if err != nil {
		return err
	}

	_, err = db.Exec(`DROP TABLE IF EXISTS Problem`)
	if err != nil {
		return err
	}

	_, err = db.Exec(`DROP TABLE IF EXISTS Contest`)
	if err != nil {
		return err
	}

	// Contest table


	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS Contest (
		contest_id varchar(10) PRIMARY KEY,
		name varchar(255) NOT NULL,
		start_time datetime NOT NULL,
		duration FLOAT NOT NULL,
		total_participants int NOT NULL)`)
	if err != nil {
		return err
	}


	// Problem table
	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS Problem (
		problem_id varchar(10) PRIMARY KEY,
		contest_id varchar(10) REFERENCES Contest(contest_id),
		title varchar(255) NOT NULL,
		url varchar(255) NOT NULL,
		rating int)`)
	if err != nil {
		return err
	}

	// Contributor table


	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS Contributor (
		name varchar(255) PRIMARY KEY)`)
	if err != nil {
		return err
	}

	// Tag table


	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS Tag (
		tag_name varchar(255) PRIMARY KEY)`)
	if err != nil {
		return err
	}


	// ContributorContest


	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS ContributorContest (
		contest_id varchar(10) NOT NULL REFERENCES Contest(contest_id),
		contributor_name varchar(255) NOT NULL REFERENCES Contributor(name),
		PRIMARY KEY (contest_id, contributor_name))`)
	if err != nil {
		return err
	}



	// ProblemTag table
	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS ProblemTag (
		problem_id varchar(10) NOT NULL REFERENCES Problem(problem_id),
		tag_name varchar(255) NOT NULL REFERENCES Tag(tag_name),
		PRIMARY KEY (problem_id, tag_name))`)
	if err != nil {
		return err
	}


	return nil
}


func seedDB(db *sql.DB) error {
	// Seed the database with the scraped data from "../../Data Scraping/data/data.json"

	// Open the data file
	file, err := os.Open("../../Data Scraping/data/data.json")
	if err != nil {
		return err
	}

	// parse the data into the models.Data struct
	var data models.Data
	err = json.NewDecoder(file).Decode(&data)
	if err != nil {
		return err
	}

	// Insert the data into the database

	for _, contest := range data.Contests {
		
		// Inserting into contest table


		// Parse the time

		// StartTime from JSON is in the format "Jun/21/2018 17:35"
		// Convert it to "2018-06-21 17:35:00"
		startTime, err := time.Parse("Jan/02/2006 15:04", contest.StartTime)
		if err != nil {
			return err
		}

		// Parse the duration
		// Duration from JSON is in the format "02:00" or "02:15"

		// Split the duration into hours and minutes
		hours, err:= strconv.Atoi(strings.Split(contest.Duration, ":")[0])
		if err != nil {
			return err
		}

		minutes, err:= strconv.Atoi(strings.Split(contest.Duration, ":")[1])
		if err != nil {
			return err
		}

		duration := float64(60*hours + minutes) / 60.0
		// Now we get the duration in hours

		_, err = db.Exec(`INSERT INTO Contest (contest_id, name, start_time, duration, total_participants) VALUES (?, ?, ?, ?, ?)`, contest.ContestID, contest.Name, startTime, (duration), contest.TotalParticipants)
		if err != nil {
			return err
		}

		// Inserting the Contributor table
		for _, writer := range contest.Writers {
			// If already exists, don't insert
			var count int
			err = db.QueryRow(`SELECT COUNT(*) FROM Contributor WHERE name = ?`, writer).Scan(&count)
			if err != nil {
				return err
			}

			if count == 0 {
				_, err = db.Exec(`INSERT INTO Contributor (name) VALUES (?)`, writer)
				if err != nil {
					return err
				}
			}

			// Inserting into ContributorContest table
			// Same here
			err = db.QueryRow(`SELECT COUNT(*) FROM ContributorContest WHERE contest_id = ? AND contributor_name = ?`, contest.ContestID, writer).Scan(&count)
			if err != nil {
				return err
			}

			if count == 0 {
				_, err = db.Exec(`INSERT INTO ContributorContest (contest_id, contributor_name) VALUES (?, ?)`, contest.ContestID, writer)
				if err != nil {
					return err
				}
			}
		}
	}

	for _, problem := range data.Problems {
		// Inserting into Problem table

		contestId := "";
		for _, character := range problem.ID {
			if (character - 'a' <= 25 && character - 'a' >= 0) || (character - 'A' <= 25 && character - 'A' >= 0) {
				break
			}
			contestId += string(character)
		}

		var count int
		err = db.QueryRow(`SELECT COUNT(*) FROM Contest WHERE contest_id = ?`, contestId).Scan(&count)
		if err != nil {
			return err
		}

		if count == 0 {
			contestId = ""
		}

		rating, err := strconv.Atoi(problem.Rating)
		if err != nil {
			rating = 0
		}



		// If rating is not set yet, set it to null
		// If contestId is not in the contest list, set it to null
		_, err = db.Exec(`INSERT INTO Problem (problem_id, contest_id, title, url, rating) VALUES (?, IF(? = '', NULL, ?), ?, ?, IF(? = 0, NULL, ?))`, problem.ID, contestId, contestId, problem.Title, problem.URL, rating, rating)
		if err != nil {
			return err
		}

		for _, tag := range problem.Tag {
			// Inserting into Tag table
			// If already exists, don't insert
			var count int
			err = db.QueryRow(`SELECT COUNT(*) FROM Tag WHERE tag_name = ?`, tag).Scan(&count)
			if err != nil {
				return err
			}

			if count == 0 {
				_, err = db.Exec(`INSERT INTO Tag (tag_name) VALUES (?)`, tag)
				if err != nil {
					return err
				}
			}

			// Inserting into ProblemTag table
			// Same here
			err = db.QueryRow(`SELECT COUNT(*) FROM ProblemTag WHERE problem_id = ? AND tag_name = ?`, problem.ID, tag).Scan(&count)
			if err != nil {
				return err
			}

			if count == 0 {
				_, err = db.Exec(`INSERT INTO ProblemTag (problem_id, tag_name) VALUES (?, ?)`, problem.ID, tag)
				if err != nil {
					return err
				}
			}
		}

	}



	return nil
}
