package main

import (
	"CF-Scraper/scraper"
	"fmt"
)

func main() {
	var err error

	// Init scraper
	scraper := scraper.NewScraper()

	// Load it with the current state
	err = scraper.LoadConfig("config.json")
	if err != nil {
		fmt.Println("Error loading config -", err, "!")
		return
	}


	// Do Scrape
	err = scraper.Scrape()
	if err != nil {
		fmt.Println("Error scraping -", err, "!")
		// return
	}


	// Save state
	err = scraper.Save()
	if err != nil {
		fmt.Println("Error while saving -", err, "!")
		return
	}
}
