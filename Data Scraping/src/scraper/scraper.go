package scraper

import (
	"CF-Scraper/models"
	"fmt"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/gocolly/colly/v2"
)

// Fine tuned for Codeforces
const MAX_THREADS = 5

type Scraper struct {
	c  *colly.Collector
	scrapedProblemPage map[int]bool
	scrapedContestPage map[int]bool
	problems []models.ProblemInformation
	contests []models.Contest
}

func NewScraper() *Scraper {
	return &Scraper{
		c: colly.NewCollector(
			colly.AllowedDomains("codeforces.com"),
		),
		scrapedProblemPage: make(map[int]bool),
		scrapedContestPage: make(map[int]bool),
		problems: []models.ProblemInformation{},
		contests: []models.Contest{},
	}
}

func (s *Scraper) Scrape() (error) {
    fmt.Println("Scraping...")
	fmt.Println("Problems scraped (before):", len(s.problems))
	fmt.Println("Contests scraped (before):", len(s.contests))

    err := s.ScrapeProblems()
    if err != nil {
        return err
	}

	err = s.ScrapeContests()
	if err != nil {
		return err
	}

	fmt.Println("Problems scraped (after):", len(s.problems))
	fmt.Println("Contests scraped (after):", len(s.contests))
	return nil
}

func (s *Scraper) ScrapeProblems() error {
	URL := "https://codeforces.com/problemset/page/%d"

	mu := sync.Mutex{}
	s.c.OnHTML("table.problems tr:not(:first-child)", func(e *colly.HTMLElement) {
		problem := models.ProblemInformation{}
		problem.ID = e.ChildText("td.id")
		problem.Title = e.ChildText("td:nth-of-type(2) div:nth-of-type(1) a")
		problem.URL = e.ChildAttr("td:nth-of-type(2) div:nth-of-type(1) a", "href")
		problem.Rating = e.ChildText("td span.ProblemRating")
		problem.Tag = e.ChildTexts("td:nth-of-type(2) div:nth-of-type(2) a")
		
		mu.Lock()
		s.problems = append(s.problems, problem)
		mu.Unlock()
    })

	if (len(s.scrapedProblemPage) != 0) {
		return s.ScrapeRestProblems(URL)
	}


	/**
	* Preparation
	*/
	maxPageCh := make(chan int)

	/**
	 * Set event
	*/
	set := false
	s.c.OnHTML("div.pagination ul li:nth-last-child(2)", func(e *colly.HTMLElement) {
		// get the last page number and convert it to int
		if !set {
			go func() {
				maxPage, _ := strconv.Atoi(e.ChildText("a"))
				set = true
				maxPageCh <- maxPage
			}()
		}
	})



	err := s.c.Visit(fmt.Sprintf(URL, 1))
	if err != nil {
		return err
	}

	// Wait until the last page number is set
	maxPage := <- maxPageCh

	for i := 1; i <= maxPage; i++ {
		s.scrapedProblemPage[i] = false
	}
	s.scrapedProblemPage[1] = true

	return s.ScrapeRestProblems(URL)
}

func (s *Scraper) ScrapeRestProblems(URL string) error {

	fmt.Println("Begin visiting pages")

	sem := NewSemaphore(MAX_THREADS)
	wg := sync.WaitGroup{}

	var unvisited []int
	for key, value := range s.scrapedProblemPage {
		if !value {
			unvisited = append(unvisited, key)
		}
	}

	
	// visit the unvisited pages
	wg.Add(len(unvisited))
	for i := 0; i < len(unvisited); i++ {
		go func(pageNumber int) {
			sem.Acquire()
			fmt.Println("Visiting page", pageNumber)
			
			err := s.c.Visit(fmt.Sprintf(URL, pageNumber))
			if err == nil {
				s.scrapedProblemPage[pageNumber] = true
			} else {
				fmt.Println("Error visiting page", pageNumber, ":", err)
			}


			defer func() {
				time.Sleep(1500 * time.Millisecond)
				sem.Release()
				wg.Done()
			}()
		}(unvisited[i])
	}

	fmt.Println("Waiting for all pages to be visited...")
	wg.Wait()

    return nil
}

func (s *Scraper) ScrapeContests() error {
	URL := "https://codeforces.com/contests/page/%d"

	mu := sync.Mutex{}
	s.c.OnHTML("div.contests-table table tr:not(:first-child)", func(e *colly.HTMLElement) {
		contest := models.Contest{}
		contest.ContestID = e.Attr("data-contestid")
		contest.Name = strings.Split(e.ChildText("td:nth-of-type(1)"), "\n")[0]
		contest.Writers = e.ChildTexts("td:nth-of-type(2) a")
		contest.StartTime = strings.Split(e.ChildText("td:nth-of-type(3)"), "\n")[0]
		contest.Duration = e.ChildText("td:nth-of-type(4)")
		contest.TotalParticipants, _ = strconv.Atoi(strings.Split(e.ChildText("td:nth-of-type(6) a"), "x")[1])

		
		mu.Lock()
		s.contests = append(s.contests, contest)
		mu.Unlock()
    })

	if (len(s.scrapedContestPage) != 0) {
		return s.ScrapeRestProblems(URL)
	}


	/**
	* Preparation
	*/
	maxPageCh := make(chan int)

	/**
	 * Set event
	*/
	set := false
	s.c.OnHTML("div.contests-table div.pagination li:nth-last-child(2)", func(e *colly.HTMLElement) {
		// get the last page number and convert it to int
		if !set {
			go func() {
				maxPage, _ := strconv.Atoi(e.ChildText("a"))
				set = true
				maxPageCh <- maxPage
			}()
		}
	})



	err := s.c.Visit(fmt.Sprintf(URL, 1))
	if err != nil {
		return err
	}

	// Wait until the last page number is set
	maxPage := <- maxPageCh

	for i := 1; i <= maxPage; i++ {
		s.scrapedContestPage[i] = false
	}
	s.scrapedContestPage[1] = true

	return s.ScrapeRestContests(URL)
}

func (s *Scraper) ScrapeRestContests(URL string) error {
	fmt.Println("Begin visiting pages")

	sem := NewSemaphore(MAX_THREADS)
	wg := sync.WaitGroup{}
	mu := sync.Mutex{}

	var unvisited []int
	for key, value := range s.scrapedContestPage {
		if !value {
			unvisited = append(unvisited, key)
		}
	}

	
	// visit the unvisited pages
	wg.Add(len(unvisited))
	for i := 0; i < len(unvisited); i++ {
		go func(pageNumber int) {
			sem.Acquire()
			fmt.Println("Visiting page", pageNumber)
			
			err := s.c.Visit(fmt.Sprintf(URL, pageNumber))
			if err == nil {
				mu.Lock()
				s.scrapedContestPage[pageNumber] = true
				mu.Unlock()
			} else {
				fmt.Println("Error visiting page", pageNumber, ":", err)
			}


			defer func() {
				time.Sleep(1500 * time.Millisecond)
				sem.Release()
				wg.Done()
			}()
		}(unvisited[i])
	}

	fmt.Println("Waiting for all pages to be visited...")
	wg.Wait()

    return nil
}
