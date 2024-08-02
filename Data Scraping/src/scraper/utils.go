package scraper

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"

	"CF-Scraper/models"
)

func (s *Scraper) LoadConfig(configFile string) error {

	var config models.Config
	relpath := fmt.Sprintf("config/%s", configFile)

	file, err := os.Open(relpath)
	if err != nil {
		return fmt.Errorf("error opening config file: %v", err)
	}
	defer file.Close()

	byteValue, err := io.ReadAll(file)
	if err != nil {
		return fmt.Errorf("error reading config file: %v", err)
	}

	err = json.Unmarshal(byteValue, &config)
	if err != nil {
		return fmt.Errorf("error unmarshalling config file: %v", err)
	}

	s.scrapedProblemPage = make(map[int]bool)
	for _, number := range config.UnvisitedProblemPages {
		s.scrapedProblemPage[number] = false
	}

	for _, number := range config.UnvisitedContestPages {
		s.scrapedContestPage[number] = false
	}

	for _, problem := range config.Data.Problems {
		s.problems = append(s.problems, problem)
	}

	for _, contest := range config.Data.Contests {
		s.contests = append(s.contests, contest)
	}

	return nil
}

func (s *Scraper) Save() error {
	config := models.Config{
		Data: models.Data{},
		UnvisitedProblemPages: []int{},
		UnvisitedContestPages: []int{},
	}
	config.Data.Problems = make(map[string]models.ProblemInformation)
	config.Data.Contests = make(map[string]models.Contest)


	for number, visited := range s.scrapedProblemPage {
		if !visited {
			config.UnvisitedProblemPages = append(config.UnvisitedProblemPages, number)
		}
	}

	for number, visited := range s.scrapedContestPage {
		if !visited {
			config.UnvisitedContestPages = append(config.UnvisitedContestPages, number)
		}
	}

	for _, problem := range s.problems {
		config.Data.Problems[problem.ID] = problem
	}

	for _, contest := range s.contests {
		config.Data.Contests[contest.ContestID] = contest
	}

	file, err := os.Create("config/config.json")
	if (len(config.UnvisitedProblemPages) == 0 && len(config.UnvisitedContestPages) == 0 && len(config.Data.Problems) != 0 && len(config.Data.Contests) != 0) {

		// Define an empty map to represent the empty JSON object
		emptyJSON := map[string]interface{}{}

		// Marshal the empty map to a JSON byte slice
		jsonBytes, err := json.Marshal(emptyJSON)
		if err != nil {
			log.Fatalf("Error marshalling to JSON: %v", err)
		}

		// Write the JSON byte slice to the file
		_, err = file.Write(jsonBytes)
		if err != nil {
			log.Fatalf("Error writing to file: %v", err)
		}
		
		// Then save the current retrieved data
		return s.SaveAsData()

	}

	// If the retrieved data is not yet complete, save the config file

	if err != nil {
		return fmt.Errorf("error creating config file: %v", err)
	}
	defer file.Close()

		
	// Marshal the config struct to a JSON byte slice
	byteValue, err := json.MarshalIndent(config, "", "    ")
	if err != nil {
		return fmt.Errorf("error marshalling config file: %v", err)
	}

	// Write the JSON byte slice to the file
	_, err = file.Write(byteValue)
	if err != nil {
		return fmt.Errorf("error writing to config file: %v", err)
	}

	return nil
}

func (s *Scraper) SaveAsData() error {
	/**
	* This function saves the scraped data to a JSON file.
	*/


	var data models.Data
	data.Problems = make(map[string]models.ProblemInformation)
	data.Contests = make(map[string]models.Contest)
	for _, problem := range s.problems {
		data.Problems[problem.ID] = problem
	}

	for _, contest := range s.contests {
		data.Contests[contest.ContestID] = contest
	}

	file, err := os.Create("../data/data.json")
	if err != nil {
		return fmt.Errorf("error creating data file: %v", err)
	}
	defer file.Close()

	byteValue, err := json.MarshalIndent(data, "", "    ")
	if err != nil {
		return fmt.Errorf("error marshalling data file: %v", err)
	}

	_, err = file.Write(byteValue)
	if err != nil {
		return fmt.Errorf("error writing to data file: %v", err)
	}

	return nil
}