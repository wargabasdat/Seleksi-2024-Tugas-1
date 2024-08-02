package scraper

import (
	"fmt"
	"log"
	"strconv"
	"strings"
	"time"

	// "context"
	"github.com/gocolly/colly/v2"
	// "github.com/chromedp/chromedp"
)

func GetNovelDetails(novels *[]Series, altNameList *[]AlterName, genreMap map[string]bool, genreNovelList *[]GenreNovel, tagsMap map[string]bool, tagsNovelList *[]TagNovel, altNametmpMap map[string]bool, tagsMapTMP map[string]bool, genresMapTEMP map[string]bool) {

	for i := range *novels {
		fmt.Println("Getting series details number : " + strconv.Itoa(i))
		if (*novels)[i].Last_Update == "" {
			(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
		}
		c2 := colly.NewCollector(
			colly.Async(true),
			colly.AllowURLRevisit(),
			// colly.CacheDir("./colly_cache"),
			colly.AllowedDomains("novelbin.me"),
		)
		c2.Limit(&colly.LimitRule{
			Delay:       1 * time.Second,
			RandomDelay: 1 * time.Second,
		})

		// get rating and ratingCount
		c2.OnHTML("div.small", func(e *colly.HTMLElement) {
			rating, _ := strconv.ParseFloat(e.ChildText("span[itemprop=ratingValue]"), 64)
			ratingCount, _ := strconv.Atoi(e.ChildText("span[itemprop=reviewCount]"))
			if (*novels)[i].Rating != rating || (*novels)[i].RatingCount != ratingCount {
				(*novels)[i].Rating = rating
				(*novels)[i].RatingCount = ratingCount
				(*novels)[i].Last_Update = time.Now().Format("2006-01-02")

			}
		})

		// get description
		c2.OnHTML("div.desc-text", func(e *colly.HTMLElement) {
			if ((*novels)[i].Description != strings.Trim(e.Text, " \r\n")){
				(*novels)[i].Description = strings.Trim(e.Text, " \r\n")
				(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
			}
		})

		// get alternative names, author, genres, status, publisher, tag, year of publishing
		c2.OnHTML("ul.info.info-meta", func(e *colly.HTMLElement) {
			foundTag := false
			foundGenre := false
			e.ForEach("li", func(_ int, el *colly.HTMLElement) {
				htmltag := el.ChildText("h3")
				switch htmltag {
				case "Alternative names:":
					altnameB := strings.Trim(strings.Split(el.Text, ":")[1], " \r\n")
					altnameL := strings.Split(altnameB, ",")
					// altNametmpMap := make(map[string]bool)
					altNametmpMap[(*novels)[i].SeriesName+(*novels)[i].SeriesName] = true
					for _, altname := range altnameL {
						alt2 := strings.Trim(altname, " \r\n")
						if !altNametmpMap[(*novels)[i].SeriesName+alt2] {
							altNametmpMap[(*novels)[i].SeriesName+alt2] = true
							*altNameList = append(*altNameList, AlterName{
								SeriesName: (*novels)[i].SeriesName,
								AltName:    alt2,
							})
						}

					}

				case "Author:":
					if (*novels)[i].Author != el.ChildText("a"){
						(*novels)[i].Author = el.ChildText("a")
						(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
					}

				case "Genre:":

					// masukkan relasi antara genre dengan novel ke dalam list
					var genreNovel GenreNovel
					genresTMP := el.ChildTexts("a")
					// genresMapTEMP := make(map[string]bool)
					for _, genre := range genresTMP {
						genreNovel.SeriesName = (*novels)[i].SeriesName
						genreNovel.Genre = genre
						if !genresMapTEMP[(*novels)[i].SeriesName+genre] {
							*genreNovelList = append(*genreNovelList, genreNovel)
							genresMapTEMP[(*novels)[i].SeriesName+genre] = true
							genreMap[genre] = true
						}

					}
					foundGenre = true
				case "Status:":
					if (*novels)[i].Status != el.ChildText("a") {
						(*novels)[i].Status = el.ChildText("a")
						(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
					}
				case "Publishers:":
					if (*novels)[i].Publisher != strings.Trim(strings.Split(el.Text, ":")[1], " \r\n"){
						(*novels)[i].Publisher = strings.Trim(strings.Split(el.Text, ":")[1], " \r\n")
						(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
					}
				case "Tag:":

					// masukkan relasi antara tag dengan novel ke dalam list
					var tagsNovel TagNovel
					tagsTMP := el.ChildTexts("a")
					// tagsMapTMP := make(map[string]bool)
					for j := range len(tagsTMP) - 1 {
						tagsNovel.SeriesName = (*novels)[i].SeriesName
						tagsNovel.Tag = tagsTMP[j]
						if !tagsMapTMP[(*novels)[i].SeriesName+tagsNovel.Tag] {
							*tagsNovelList = append(*tagsNovelList, tagsNovel)
							tagsMapTMP[(*novels)[i].SeriesName+tagsNovel.Tag] = true
							tagsMap[tagsNovel.Tag] = true
						}
					}
					foundTag = true

				case "Year of publishing:":
					yearTmp, _ := strconv.Atoi(el.ChildText("a"))
					if (*novels)[i].Year != yearTmp{
						(*novels)[i].Year, _ = strconv.Atoi(el.ChildText("a"))
						(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
					}
				}

			})

			// kalo ga ada genrenya diisi dengan N/A sebagai placeholder
			if !foundGenre {
				var genreNovel GenreNovel
				genreNovel.SeriesName = (*novels)[i].SeriesName
				genreNovel.Genre = "N/A"
				if !genresMapTEMP[(*novels)[i].SeriesName+"N/A"] {
					*genreNovelList = append(*genreNovelList, genreNovel)
					genresMapTEMP[(*novels)[i].SeriesName+"N/A"] = true
					genreMap["N/A"] = true
				}
			}

			// kalo ga ada tagnya diisi dengan string kosong sebagai placeholder
			if !foundTag {
				var tagsNovel TagNovel
				tagsNovel.SeriesName = (*novels)[i].SeriesName
				tagsNovel.Tag = "N/A"
				if !tagsMapTMP[(*novels)[i].SeriesName+"N/A"] {
					*tagsNovelList = append(*tagsNovelList, tagsNovel)
					tagsMapTMP[(*novels)[i].SeriesName+"N/A"] = true
					tagsMap["N/A"] = true
				}
			}

		})


		c2.OnError(func(r *colly.Response, err error) {
			fmt.Printf("Request URL: %s\n", r.Request.URL)
			fmt.Printf("Response Status Code: %d\n", r.StatusCode)
			fmt.Printf("Error: %v\n", err)
		})

		// header request
		c2.OnRequest(func(r *colly.Request) {
			r.Headers.Set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0")
			r.Headers.Set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
			r.Headers.Set("Accept-Language", "en-US,en;q=0.9")
			r.Headers.Set("Scraper-Identity", "ITB undergraduate student")
		})

		// visit URL of every novel in the list
		err := c2.Visit((*novels)[i].Link)
		if err != nil {
			log.Fatal(err)
		}
		c2.Wait()
	}
}
func GetNovelChapter(novels *[]Series, first int, end int, ListChapter *[]Chapter_Release, ListChapterMap map[string]bool) {

	for i := first; i < end; i++ {
		fmt.Println("Getting series chapter number : " + strconv.Itoa(i))
		urltemp := strings.Split((*novels)[i].Link, "/")
		urlarchive := "https://novelbin.me/ajax/chapter-archive?novelId=" + urltemp[4]
		c2 := colly.NewCollector(
			colly.Async(true),
			colly.AllowURLRevisit(),
			// colly.CacheDir("./colly_cache"),
			colly.AllowedDomains("novelbin.me"),
		)
		c2.Limit(&colly.LimitRule{
			Delay:       1 * time.Second,
			RandomDelay: 1 * time.Second,
		})

		// get the first 50 chapter per novel
		count := 0
		c2.OnHTML("ul.list-chapter > li", func(e *colly.HTMLElement) {
			count++
			// limit 50 chapter per novel coz github cant track large file
			if count < 51 {
				var ch Chapter_Release
				url := e.ChildAttr("a", "href")
				chtitle := e.ChildText("a")
				ch.SeriesName = (*novels)[i].SeriesName
				ch.Chapter = count
				if len(chtitle) > 225 {
					ch.Title = "error too long"
				} else {
					ch.Title = chtitle
				}
				if len(url) > 225 {
					ch.URL = "error too long"
				} else {
					ch.URL = url
				}
				ch.Date_Added = time.Now().Format("2006-01-02")
				if !(ListChapterMap[ch.SeriesName+strconv.Itoa(ch.Chapter)]) {
					*ListChapter = append(*ListChapter, ch)
					ListChapterMap[ch.SeriesName+strconv.Itoa(ch.Chapter)] = true
				}
			}
			if count > (*novels)[i].TotalChapter {
				(*novels)[i].TotalChapter = count
				(*novels)[i].Last_Update = time.Now().Format("2006-01-02")
			}
		})

		c2.OnError(func(r *colly.Response, err error) {
			fmt.Printf("Request URL: %s\n", r.Request.URL)
			fmt.Printf("Response Status Code: %d\n", r.StatusCode)
			fmt.Printf("Error: %v\n", err)
		})

		// header request
		c2.OnRequest(func(r *colly.Request) {
			r.Headers.Set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0")
			r.Headers.Set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
			r.Headers.Set("Accept-Language", "en-US,en;q=0.9")
			r.Headers.Set("Scraper-Identity", "ITB undergraduate student")
		})

		// visit URL of every novel in the list
		err := c2.Visit(urlarchive)

		if err != nil {
			log.Fatal(err)
		}

		c2.Wait()
	}
}
