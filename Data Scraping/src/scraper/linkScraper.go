package scraper

import (
	"fmt"
	"log"
	"time"

	"github.com/gocolly/colly/v2"
)

func GetNovelLinks(novels *[]Series, URL string, novelsMap map[string]bool) (error) {
	c := colly.NewCollector(
		colly.Async(true),
        colly.AllowURLRevisit(),
		// colly.CacheDir("./colly_cache"),
		colly.AllowedDomains("novelbin.me"),
	)
	c.Limit(&colly.LimitRule{
		Delay: 1 * time.Second,
		RandomDelay: 1 * time.Second,
	})

	// get novel title and the URL to that novel
	c.OnHTML("h3.novel-title", func(e *colly.HTMLElement) {
		var novel Series
		novel.Link = e.ChildAttr("h3.novel-title > a", "href")
		novel.SeriesName = e.ChildText("h3.novel-title > a")
		if novel.Link != "" && !novelsMap[novel.SeriesName]{
			*novels = append(*novels, novel)
			novelsMap[novel.SeriesName] = true
		}
	})

	c.OnHTML("div.search_title", func(e *colly.HTMLElement) {
		var novel Series
		novel.Link = e.ChildAttr("h3.novel-title > a", "href")
		novel.SeriesName = e.ChildText("h3.novel-title > a")
		fmt.Println(novel)
		if novel.Link != "" && !novelsMap[novel.SeriesName]{
			*novels = append(*novels, novel)
			novelsMap[novel.SeriesName] = true
		}
	})

	c.OnError(func(r *colly.Response, err error) {
		fmt.Printf("Request URL: %s\n", r.Request.URL)
		fmt.Printf("Response Status Code: %d\n", r.StatusCode)
		fmt.Printf("Error: %v\n", err)
	})

	// header request
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0")
		r.Headers.Set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
		r.Headers.Set("Accept-Language", "en-US,en;q=0.9")
		r.Headers.Set("Scraper-Identity", "ITB undergraduate student")
	})

	// visit URL of every novel in the list
	err := c.Visit(URL)
	if err != nil {
		log.Fatal(err)
		return err
	}
	c.Wait()
	fmt.Println("Scraping complete")
	return err
}
