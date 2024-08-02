package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"scraping/scraper"
	"sort"
	"sync"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

// ...
func main(){
	SeriesIntoDB()
    AlternativeIntoDB()
    GenresIntoDB()
    GenreNovelIntoDB()
    TagsIntoDB()
    TagNovelIntoDB()
    ChapterIntoDB()
    createTheRest()
    exportSQL()
}
func GetLastDirectoryByName(dir string) (string, error) {
	entries, err := os.ReadDir(dir)
	if err != nil {
		return "", err
	}

	var directories []string

	for _, entry := range entries {
		if entry.IsDir() { // append only directory
			directories = append(directories, entry.Name())
		}
	}

	if len(directories) == 0 {
		return "", fmt.Errorf("no directory")
	}

	// Sort directories
	sort.Strings(directories)

	// Return the last directory
	return directories[len(directories)-1], nil
}
func getDataJSON[T any](filename string) []T{
    // Open JSON file
    dir, err := GetLastDirectoryByName("../../Data Scraping/data")
    if err != nil {
        log.Fatal(err)
    }
    jsonFile, err := os.Open("../../Data Scraping/data/" + dir + "/" + filename)
    if err != nil {
        log.Fatal(err)
    }
    defer jsonFile.Close()

    // Read the JSON file
    byteValue, err := io.ReadAll(jsonFile)
    if err != nil {
        log.Fatal(err)
    }

    // Unmarshal the JSON data into the list
    var data []T
    err = json.Unmarshal(byteValue, &data)
    if err != nil {
        log.Fatal(err)
    }
	return data
}
func exportSQL(){
    cmd := exec.Command("mysqldump", "-u", "root", "-p1234", "basdat")

    // Create the output file
    outFile, err := os.Create("basdat.sql")
    if err != nil {
        fmt.Println("Error creating file:", err)
        return
    }
    defer outFile.Close()

    // Redirect the output to the file
    cmd.Stdout = outFile

    // Run the command
    err = cmd.Run()
    if err != nil {
        fmt.Println("Error executing command:", err)
        return
    }

    fmt.Println("Database successfully exported to basdat.sql")
}
func SeriesIntoDB(){
	seriesList := getDataJSON[scraper.Series]("Series.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Series (
        seriesName VARCHAR(255),
        rating DECIMAL(4,2) CHECK (rating >= 0),
		ratingCount INT CHECK (rating >= 0),
        author VARCHAR(255),
        year INT CHECK(year >= 0),
		status ENUM('Completed', 'Ongoing'),
		publisher VARCHAR(150),
        total_chapter INT CHECK (total_chapter >= 0),
        description TEXT,
        URL VARCHAR(255) NOT NULL, 
        last_update DATE NOT NULL,
        PRIMARY KEY (seriesName)
    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Series table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare(`
    INSERT INTO Series (seriesName, rating, ratingCount, author, year, status, publisher, total_chapter, description, URL, last_update) VALUES (?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY 
            UPDATE rating = VALUES(rating),
            ratingCount = VALUES(ratingCount),
            status = VALUES(status),
            total_chapter = VALUES(total_chapter),
            last_update = VALUES(last_update);`)
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, series := range seriesList{
        wg.Add(1)
		go func(series scraper.Series){
            if(series.Year == 0){
                var nullVal sql.NullInt64
                nullVal.Valid = false;
                _, err = stmt.Exec(series.SeriesName, series.Rating, series.RatingCount, series.Author, nullVal, series.Status, series.Publisher, series.TotalChapter, series.Description, series.Link, series.Last_Update)
            }else{
                _, err = stmt.Exec(series.SeriesName, series.Rating, series.RatingCount, series.Author, series.Year, series.Status, series.Publisher, series.TotalChapter, series.Description, series.Link, series.Last_Update)
            }
            if err != nil {
                fmt.Println(series)
                log.Fatal(err)
            }
            wg.Done()
        }(series)
	}
    wg.Wait()
    fmt.Println("Series data inserted successfully")
}
func AlternativeIntoDB(){
    altList := getDataJSON[scraper.AlterName]("AlternativeNames.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Alternative_Names (
        seriesName VARCHAR(255),
        altName VARCHAR(255),
        PRIMARY KEY (seriesName, altName),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Alternative_Names table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare("INSERT IGNORE INTO Alternative_Names (seriesName, altName) VALUES (?,?);")
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, alt := range altList{
        wg.Add(1)
		go func(alt scraper.AlterName){
            _, err = stmt.Exec(alt.SeriesName, alt.AltName, )
            if err != nil {
                fmt.Println(alt)
                log.Fatal(err)
            }
            wg.Done()
        }(alt)
	}
    wg.Wait()
    fmt.Println("Alternative Names data inserted successfully")
}

func GenresIntoDB(){
    List := getDataJSON[scraper.Genre]("Genres.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Genres (
        genre VARCHAR(255),
        definition VARCHAR(255),
        PRIMARY KEY (genre)
    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Genres table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare("INSERT INTO Genres (genre, definition) VALUES (?,?) ON DUPLICATE KEY UPDATE definition=VALUES(definition);")
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, el := range List{
        wg.Add(1)
		go func(el scraper.Genre){
            _, err = stmt.Exec(el.Genre, el.Definition,)
            if err != nil {
                fmt.Println(el)
                log.Fatal(err)
            }
            wg.Done()
        }(el)
	}
    wg.Wait()
    fmt.Println("Genres data inserted successfully")
}

func GenreNovelIntoDB(){
    List := getDataJSON[scraper.GenreNovel]("GenreNovel.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Series_Genre (
        seriesName VARCHAR(255),
        genre VARCHAR(255),
        PRIMARY KEY (seriesName, genre),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (genre) REFERENCES Genres(genre)
            ON DELETE CASCADE
            ON UPDATE CASCADE

    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Series_Genre table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare("INSERT IGNORE INTO Series_Genre (seriesName, genre) VALUES (?,?);")
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, el := range List{
        wg.Add(1)
		go func(el scraper.GenreNovel){
            _, err = stmt.Exec(el.SeriesName, el.Genre)
            if err != nil {
                fmt.Println(el.SeriesName + el.Genre)
                log.Fatal(err)
            }
            wg.Done()
        }(el)
	}
    wg.Wait()
    fmt.Println("Series_Genre data inserted successfully")
}

func TagsIntoDB(){
    List := getDataJSON[scraper.Tag]("Tags.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Tags (
        tag VARCHAR(255),
        definition VARCHAR(255),
        PRIMARY KEY (tag)
    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Tags table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare("INSERT INTO Tags (tag, definition) VALUES (?,?) ON DUPLICATE KEY UPDATE definition = VALUES(definition);")
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, el := range List{
        wg.Add(1)
		go func(el scraper.Tag){
            _, err = stmt.Exec(el.Tag, el.Definition, )
            if err != nil {
                fmt.Println(el)
                log.Fatal(err)
            }
            wg.Done()
        }(el)
	}
    wg.Wait()
    fmt.Println("Tags data inserted successfully")
}

func TagNovelIntoDB(){
    List := getDataJSON[scraper.TagNovel]("TagNovel.JSON")
	db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(50)
	db.SetMaxIdleConns(10)

	createTableQuery := `
    CREATE TABLE IF NOT EXISTS Series_Tag (
        seriesName VARCHAR(255),
        tag VARCHAR(255),
        PRIMARY KEY (seriesName, tag),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (tag) REFERENCES Tags(tag)
            ON DELETE CASCADE
            ON UPDATE CASCADE

    );`
	_, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Series_Tag table created successfully")

	// Insert data into the employees table
	stmt, err := db.Prepare("INSERT IGNORE INTO Series_Tag (seriesName, tag) VALUES (?,?);")
	if err != nil{
		log.Fatal(err)
	}
	defer stmt.Close()
    var wg sync.WaitGroup
	for _, el := range List{
        wg.Add(1)
		go func(el scraper.TagNovel){
            _, err = stmt.Exec(el.SeriesName, el.Tag, )
            if err != nil {
                fmt.Println(el)
                log.Fatal(err)
            }
            wg.Done()
        }(el)
	}
    wg.Wait()
    fmt.Println("Series_Tag data inserted successfully")
}

func ChapterIntoDB(){
    db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
        panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
    db.SetMaxOpenConns(50)
	db.SetMaxIdleConns(5)

    createTableQuery := `
    CREATE TABLE IF NOT EXISTS Chapter_Release (
        seriesName VARCHAR(255),
        chapter INT CHECK (chapter >= 0),
        title VARCHAR(255),
        url VARCHAR(255),
        date_updated DATE NOT NULL,
        PRIMARY KEY (seriesName, chapter),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Chapter_Release table created successfully")
    
    files, err := os.ReadDir("../../Data Scraping/data/" + time.Now().Format("2006-01-02") + "/" + "Chapter")
    if err != nil {
        log.Fatalf("Failed to read directory: %s", err)
    }
    for _,file := range files{
        List := getDataJSON[scraper.Chapter_Release]("Chapter/" + file.Name())
        // Insert data into the employees table
        stmt, err := db.Prepare("INSERT INTO Chapter_Release (seriesName, chapter, title, url, date_updated) VALUES (?,?,?,?,?) ON DUPLICATE KEY UPDATE title = VALUES(title), url = VALUES(url), date_updated = VALUES(date_updated);")
        if err != nil{
            log.Fatal(err)
        }
        defer stmt.Close()
        var wg sync.WaitGroup
        for _, el := range List{
            wg.Add(1)
            go func(el scraper.Chapter_Release){
                _, err = stmt.Exec(el.SeriesName, el.Chapter, el.Title, el.URL, el.Date_Added)
                if err != nil {
                    fmt.Println(el)
                    log.Fatal(err)
                }
                wg.Done()
            }(el)
        }
        wg.Wait()
    }
	// // further consideration
    // deleteTable := `DROP TABLE IF EXISTS Chapter_Release;`
	// _, err = db.Exec(deleteTable)
    // if err != nil {
    //     log.Fatal(err)
    // }
    fmt.Println("Chapter_Release data inserted successfully")
}

func createTheRest(){
    db, err := sql.Open("mysql", "root:1234@tcp(localhost:3306)/basdat")
	if err != nil {
        panic(err)
	}
	defer db.Close()
	db.SetConnMaxLifetime(time.Minute * 3)
    db.SetMaxOpenConns(50)
	db.SetMaxIdleConns(5)

    createTableQuery := `
    CREATE TABLE IF NOT EXISTS Related_Series (
        seriesName VARCHAR(255),
        relatedSeries VARCHAR(255),
        PRIMARY KEY (seriesName, relatedSeries),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (relatedSeries) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Related_Series table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS Recommendation (
        seriesName VARCHAR(255),
        recommendedSeries VARCHAR(255),
        jumlah INT,
        PRIMARY KEY (seriesName, recommendedSeries),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (recommendedSeries) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Recommendation table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS Recommendation_List (
        rec_ID INT AUTO_INCREMENT,
        user_ID VARCHAR(13) NOT NULL,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        PRIMARY KEY (rec_ID)
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Recommendation_List table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS SeriesInRecList (
        seriesName VARCHAR(255),
        rec_ID INT,
        PRIMARY KEY (seriesName, rec_ID),
        FOREIGN KEY (seriesName) REFERENCES Series(seriesName)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (rec_ID) REFERENCES Recommendation_List(rec_ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("SeriesInRecList table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS TagsInRecList (
        rec_ID INT,
        tag VARCHAR(255),
        PRIMARY KEY (rec_ID, tag),
        FOREIGN KEY (rec_ID) REFERENCES Recommendation_List(rec_ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (tag) REFERENCES Tags(tag)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("TagsInRecList table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS Translator_Group (
        group_ID INT AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        URL VARCHAR(255) NOT NULL,
        PRIMARY KEY (group_ID)
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Translator_Group table created successfully")

    createTableQuery = `
    CREATE TABLE IF NOT EXISTS Group_Release (
        seriesName VARCHAR(255),
        chapter INT,
        group_ID INT,
        PRIMARY KEY (seriesName, chapter),
        FOREIGN KEY (seriesName, chapter) REFERENCES Chapter_Release(seriesName, chapter)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (group_ID) REFERENCES Translator_Group(group_ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );`
    _, err = db.Exec(createTableQuery)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Group_Release table created successfully")
}