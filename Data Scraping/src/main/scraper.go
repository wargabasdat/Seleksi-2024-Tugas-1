package main

import (
	"fmt"
	"scraping/scraper"
	"strconv"
	"sync"
)


func main() {
	// Variable
	var wg sync.WaitGroup
	dir, err2 := scraper.GetLastDirectoryByName("../../data")

	
	altNameList, err := scraper.GetDataJSONSlice[scraper.AlterName]("AlternativeNames.json", dir, err2)
	if err != nil{
		altNameList = []scraper.AlterName{}
		fmt.Println(err)
	}
	genreMap, err := scraper.GetDataJSONMap("GenreMap.json", dir, err2)
	if err != nil{
		genreMap = make(map[string]bool)
		fmt.Println(err)
	}
	
	genreNovel, err := scraper.GetDataJSONSlice[scraper.GenreNovel]("GenreNovel.json", dir, err2)
	if err != nil{
		genreNovel = []scraper.GenreNovel{}   // relasi genre novel
		fmt.Println(err)
	}

	tagsMap, err := scraper.GetDataJSONMap("TagsMap.json", dir, err2)
	if err != nil{
		tagsMap = make(map[string]bool)  // tabel tags
		fmt.Println(err)
	}

	tagsNovel, err := scraper.GetDataJSONSlice[scraper.TagNovel]("TagNovel.json", dir, err2)
	if err != nil{
		tagsNovel = []scraper.TagNovel{}      // relasi tags novel
		fmt.Println(err)
	}

	novels, err := scraper.GetDataJSONSlice[scraper.Series]("Series.json", dir, err2)
	if err != nil {
		novels = []scraper.Series{}       // tabel novel
		fmt.Println(err)
	}
	
	novelsMap, err := scraper.GetDataJSONMap("NovelsMap.json", dir, err2)
	if err != nil{
		novelsMap = make(map[string]bool) // checking exist or not for novel
		fmt.Println(err)
	}


	baseURL := "https://novelbin.me/sort/novelbin-popular" // base URL
	for i := range 60 { // ubah untuk mengatur jumlah pages yang akan discraped
		if i == 0 {
			scraper.GetNovelLinks(&novels, baseURL, novelsMap)
			
		} else {
			nextURL := baseURL + "?page=" + strconv.Itoa((i + 1))
			fmt.Println("Start scraping " + nextURL)
			scraper.GetNovelLinks(&novels, nextURL, novelsMap)
			
		}
	}
	panjangNovel := len(novels)
	fmt.Println(panjangNovel)

	altNametmpMap, err := scraper.GetDataJSONMap("AlternativeNamesMap.json", dir, err2)
	if err != nil{
		altNametmpMap = make(map[string]bool)
	}
	tagsMapTMP, err := scraper.GetDataJSONMap("TagNovelMap.json", dir, err2)
	if err != nil {
		tagsMapTMP = make(map[string]bool)
	}
	genresMapTEMP, err := scraper.GetDataJSONMap("GenreNovelMap.json", dir, err2)
	if err != nil {
		genresMapTEMP = make(map[string]bool)
	}

	scraper.GetNovelDetails(&novels, &altNameList ,genreMap, &genreNovel, tagsMap, &tagsNovel, altNametmpMap, tagsMapTMP, genresMapTEMP) // get the details
	
	genres := []scraper.Genre{}
	tags := []scraper.Tag{}
	scraper.MapToList(genreMap, &genres, scraper.CreateGenres)
	scraper.MapToList(tagsMap, &tags, scraper.CreateTags)
	
	// create JSON files
	wg.Add(11)
	fmt.Println("Start writing to JSON files")
	go scraper.CreateJSON(altNameList, "AlternativeNames.json", &wg)
	go scraper.CreateJSON(genres, "Genres.json", &wg)
	go scraper.CreateJSON(tags, "Tags.json", &wg)
	go scraper.CreateJSON(genreNovel, "GenreNovel.json", &wg)
	go scraper.CreateJSON(tagsNovel, "TagNovel.json", &wg)
	go scraper.CreateJSON(genreMap, "GenreMap.json", &wg)
	go scraper.CreateJSON(tagsMap, "TagsMap.json", &wg)
	go scraper.CreateJSON(novelsMap, "NovelsMap.json", &wg)
	go scraper.CreateJSON(altNametmpMap, "AlternativeNamesMap.json", &wg)
	go scraper.CreateJSON(tagsMapTMP, "TagNovelMap.json", &wg)
	go scraper.CreateJSON(genresMapTEMP, "GenreNovelMap.json", &wg)
	wg.Wait()
	altNameList = nil
	genres = nil
	tags = nil
	genreNovel = nil
	tagsNovel = nil
	genreMap = nil
	tagsMap = nil
	
	// get chapter release
	size := 50
	first := 0
	end := size
	filenum := 0
	chapterReleaseMap, err := scraper.GetDataJSONMap("Chapter_ReleaseMap.json", dir, err2)
	if err != nil{
		chapterReleaseMap = make(map[string]bool)
	}
	for range (panjangNovel / size){
		filenum++
		ListChapter,err := scraper.GetDataJSONSlice[scraper.Chapter_Release]("Chapter/Chapter_Release " + strconv.Itoa(filenum) +".json", dir, err2) 
		if err != nil{
			ListChapter = []scraper.Chapter_Release{}
			fmt.Println(err)
		}
		scraper.GetNovelChapter(&novels, first, end, &ListChapter, chapterReleaseMap)
		first += size
		end += size
		wg.Add(1)
		scraper.CreateJSON(ListChapter, "Chapter/Chapter_Release " + strconv.Itoa(filenum) +".json", &wg)
	}
	wg.Wait()
	sisaPanjang := panjangNovel % size
	if sisaPanjang != 0 {
		wg.Add(1)
		ListChapter,err := scraper.GetDataJSONSlice[scraper.Chapter_Release]("Chapter/Chapter_Release " + strconv.Itoa(filenum + 1) +".json", dir, err2) 
			if err != nil{
				ListChapter = []scraper.Chapter_Release{}
				fmt.Println(err)
			}
		scraper.GetNovelChapter(&novels, panjangNovel - sisaPanjang, panjangNovel, &ListChapter, chapterReleaseMap)
		scraper.CreateJSON(ListChapter, "Chapter/Chapter_Release " + strconv.Itoa(filenum + 1) +".json", &wg)
	}
	wg.Add(2)
	scraper.CreateJSON(novels, "Series.json", &wg)
	scraper.CreateJSON(chapterReleaseMap, "Chapter_ReleaseMap.json", &wg)
	fmt.Println("Finish writing to JSON files")

	
}
