package main

import (
	"CF-Scraper/scraper"
	"fmt"
)

func main() {
	var err error

	scraper := scraper.NewScraper()

	err = scraper.LoadConfig("config.json")
	if err != nil {
		fmt.Println("Error loading config -", err, "!")
		return
	}


	err = scraper.Scrape()
	if err != nil {
		fmt.Println("Error scraping -", err, "!")
		// return
	}


	err = scraper.Save()
	if err != nil {
		fmt.Println("Error while saving -", err, "!")
		return
	}
}
