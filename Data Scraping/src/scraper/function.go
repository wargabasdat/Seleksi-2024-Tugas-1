package scraper

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"sort"
	"sync"
	"time"
)

type Series struct {
	SeriesName   string  `json:"seriesName"`
	Rating       float64 `json:"rating"`
	RatingCount  int     `json:"ratingCount"`
	Author       string  `json:"author"`
	Year         int     `json:"year"`
	Status       string  `json:"status"`
	Publisher    string  `json:"publisher"`
	TotalChapter int     `json:"total_chapter"`
	Description  string  `json:"description"`
	Link         string  `json:"link"`
	Last_Update  string  `json:"last_update"`
}
type Chapter_Release struct {
	SeriesName string `json:"seriesName"`
	Chapter    int    `json:"chapter"`
	Title      string `json:"title"`
	URL        string `json:"URL"`
	Date_Added string `json:"date_added"`
}
type AlterName struct {
	SeriesName string `json:"seriesName"`
	AltName    string `json:"altName"`
}
type GenreNovel struct {
	SeriesName string `json:"seriesName"`
	Genre      string `json:"genre"`
}

type TagNovel struct {
	SeriesName string `json:"seriesName"`
	Tag        string `json:"tag"`
}

type Genre struct {
	Genre      string `json:"genre"`
	Definition string `json:"definition"`
}

type Tag struct {
	Tag        string `json:"tag"`
	Definition string `json:"definition"`
}

func PrintNovel(novel Series) {
	fmt.Println("Name: " + novel.SeriesName)
	fmt.Printf("Rating: %.2f\n", novel.Rating)
	fmt.Printf("RatingCount: %d\n", novel.RatingCount)
	fmt.Println("Author: " + novel.Author)
	fmt.Printf("Year: %d\n", novel.Year)
	fmt.Println("Status: " + novel.Status)
	fmt.Println("Publisher: " + novel.Publisher)
	// fmt.Println("Desc: " + novel.description)
	fmt.Println("link: " + novel.Link)
}
func PrintGenreNovel(genreNovel []GenreNovel) {
	for _, i := range genreNovel {
		fmt.Println("Series Name: " + i.SeriesName)
		fmt.Println("Genre: " + i.Genre)
	}
}
func PrintTagsNovel(tagsNovel []TagNovel) {
	for _, i := range tagsNovel {
		fmt.Println("Series Name: " + i.SeriesName)
		fmt.Println("Tag: " + i.Tag)
	}
}

func CreateJSON(v interface{}, filename string, wg *sync.WaitGroup) {
	defer wg.Done()
	jsonData, err := json.MarshalIndent(v, "", "    ")
	if err != nil {
		fmt.Println("Error marshalling JSON:", err)
		return
	}

	// create the file on folder data
	dirPath := "../../data/" + time.Now().Format("2006-01-02")
	filepath := dirPath + "/" + filename

	if err := os.MkdirAll(dirPath+"/Chapter", os.ModePerm); err != nil {
		fmt.Println("Error creating directory:", err)
		return
	}

	file, err := os.Create(filepath)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer file.Close()

	_, err = file.Write(jsonData)
	if err != nil {
		fmt.Println("Error writing to file:", err)
		return
	}

	fmt.Println("Data successfully written to " + filename)
}

func MapToList[T any](m map[string]bool, list *[]T, createFunc func(string, string) T) {
	for key := range m {
		*list = append(*list, createFunc(key, ""))
	}
}

func CreateGenres(genre, description string) Genre {
	return Genre{
		Genre:      genre,
		Definition: description,
	}
}

func CreateTags(tag, description string) Tag {
	return Tag{
		Tag:        tag,
		Definition: description,
	}
}
func GetDataJSONSlice[T any](filename string, dir string, err error) ([]T, error) {
	if err != nil {
		return nil, err
	}
	jsonFile, err := os.Open("../../data/" + dir + "/" + filename)
	if err != nil {
		return nil, err
	}
	defer jsonFile.Close()

	// Read the JSON file
	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	// Unmarshal the JSON data into the struct
	var data []T
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		return nil, err
	}
	return data, nil
}

func GetDataJSONMap(filename string, dir string, err error) (map[string]bool, error) {
	if err != nil {
		return nil, err
	}
	jsonFile, err := os.Open("../../data/" + dir + "/" + filename)
	if err != nil {
		return nil, err
	}
	defer jsonFile.Close()

	// Read the JSON file
	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	// Unmarshal the JSON data into the struct
	var data map[string]bool
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		return nil, err
	}
	return data, nil
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
