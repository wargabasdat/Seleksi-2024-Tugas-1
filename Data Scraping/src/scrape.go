package main

/* ------Import Statements untuk Library yang digunakan------ */
import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"unicode"

	"github.com/PuerkitoBio/goquery"
)

/* ------Struktur Data------ */
// DoctorInfo merupakan struktur data yang digunakan untuk menyimpan informasi dokter
type DoctorInfo struct {
	Name             string
	DoctorURL        string
	Experience       int
	Rating           float64
	Price            int
	Education        []Education
	PracticeLocation []PracticeLocation
	StrNumber        string
}

// Education merupakan struktur data yang digunakan untuk menyimpan informasi pendidikan yang ditempuh oleh setiap dokter
type Education struct {
	University string
	Year       int
}

// PracticeLocation merupakan struktur data yang digunakan untuk menyimpan informasi tempat praktik
type PracticeLocation struct {
	City     string
	Province string
}

/* ------Fungsi-Fungsi------ */
/*
createURL merupakan fungsi untuk menghasilkan URL baru dari nama dokter 
yang akan digunakan untuk melakukan crawling
*/
func createURL(name string) string {
	name = strings.ToLower(name)
	var newStringBuilder strings.Builder
	nonLetter := false

	for _, ch := range name {
		if unicode.IsLetter(ch) || unicode.IsDigit(ch) {
			newStringBuilder.WriteRune(ch)
			nonLetter = false
		} else {
			if !nonLetter {
				newStringBuilder.WriteRune('-')
				nonLetter = true
			}
		}
	}

	newString := newStringBuilder.String()
	return strings.TrimSuffix(newString, "-")
}

/*
makeJSON merupakan fungsi yang digunakan 
untuk menyimpan data hasil scraping ke dalam format JSON 
*/
func makeJSON(data []DoctorInfo, pathname string) error {
	parentDir := filepath.Join("..", pathname)

	if err := os.MkdirAll(parentDir, os.ModePerm); err != nil {
		return fmt.Errorf("failed to create directory: %w", err)
	}

	file, err := os.Create(filepath.Join(parentDir, "doctors_info.json"))
	if err != nil {
		return fmt.Errorf("failed to create file: %w", err)
	}
	defer file.Close()

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ")
	if err := encoder.Encode(data); err != nil {
		return fmt.Errorf("failed to write JSON to file: %w", err)
	}

	return nil
}

/*
Preprocessing dengan Transformation.
convExp merupakan fungsi untuk melakukan preprocessing terhadap data Experience
dengan mengubahnya dari tipe data string menjadi tipe data integer.
*/
func convExp(experience string) int {
	re := regexp.MustCompile(`\d+`)
	match := re.FindString(experience)
	if match != "" {
		result, _ := strconv.Atoi(match)
		return result
	}
	return 0
}

/*
Preprocessing dengan Transformation.
convRate merupakan fungsi untuk melakukan preprocessing terhadap data Rating 
dengan mengubahnya dari tipe data string menjadi tipe data float.
*/
func convRate(rating string) float64 {
	result, _ := strconv.ParseFloat(strings.TrimSpace(rating), 64)
	return result
}

/*
Preprocessing dengan Transformation.
convPrice merupakan fungsi untuk melakukan preprocessing terhadap data Price 
dengan mengubahnya dari tipe data string menjadi tipe data integer.
*/
func convPrice(price string) int {
	price = strings.ReplaceAll(price, "Rp ", "")
	price = strings.ReplaceAll(price, ".", "")
	result, _ := strconv.Atoi(price)
	return result
}

/*
Preprocessing dengan Transformation dan Parsing.
convEdu merupakan fungsi untuk melakukan preprocessing terhadap data education
dengan melakukan parsing antara nama universitas dan tahun kelulusan (Year)
dan mengubah hasil parsing tersebut ke dalam bentuk tuple.
*/
func convEdu(education []string) []Education {
	var ed []Education
	for _, e := range education {
		parts := strings.Split(e, ", ")
		if len(parts) == 2 {
			year, _ := strconv.Atoi(parts[1])
			ed = append(ed, Education{
				University: parts[0],
				Year:       year,
			})
		}
	}
	return ed
}

/*
Preprocessing dengan Transformation, Cleaning, dan Parsing.
convLoc merupakan fungsi untuk melakukan preprocessing terhadap data practice location
dengan melakukan parsing antara nama kota dan nama provinsi,
lalu mengubah hasil parsing tersebut ke dalam bentuk tuple, 
dan melakukan cleaning terhadap tuple yang memiliki konten yang sama 
(tidak akan terdapat dua tuple yang sama dalam satu list).
*/
func convLoc(locations []string) []PracticeLocation {
	locMap := make(map[string]PracticeLocation)
	for _, loc := range locations {
		parts := strings.Split(loc, ", ")
		if len(parts) == 2 {
			locKey := fmt.Sprintf("%s,%s", parts[0], parts[1])
			if _, exists := locMap[locKey]; !exists {
				locMap[locKey] = PracticeLocation{
					City:     parts[0],
					Province: parts[1],
				}
			}
		}
	}

	var locs []PracticeLocation
	for _, loc := range locMap {
		locs = append(locs, loc)
	}

	return locs
}

/* ------Program Utama------ */
func main() {
	mainURL := "https://www.halodoc.com/tanya-dokter/kategori/spesialis-gizi-klinik?gad_source=1&gclid=CjwKCAjw74e1BhBnEiwAbqOAjCVhlqe6Y0PPh7NUl67XXbvY_ZsiLdU0ScZM6Leg5GD01m9DbiBtvBoC5BUQAvD_BwE"
	var doctorsInfo []DoctorInfo

	// Melakukan request ke halaman daftar Dokter Spesialis Gizi Klinik
	res, err := http.Get(mainURL)
	if err != nil {
		log.Fatalf("Failed to fetch doctors list: %v", err)
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		log.Fatalf("Status code error: %d %s", res.StatusCode, res.Status)
	}

	// Parsing HTML untuk mendapatkan informasi nama dokter spesialis gizi klinik yang terdaftar
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		log.Fatalf("Failed to parse doctors list page: %v", err)
	}

	doc.Find(".hd-base-horizontal-card__content").Each(func(i int, s *goquery.Selection) {
		name := strings.TrimSpace(s.Find(".hd-base-horizontal-card__title").Text())
		// Men-generate URL dari nama dokter spesialis gizi klinik untuk crawling
		newString := createURL(name)
		doctorURL := "https://www.halodoc.com/tanya-dokter/" + newString

		// Melakukan request ke URL baru yang berisi detail informasi dokter spesialis gizi klinik
		detailRes, err := http.Get(doctorURL)
		if err != nil {
			log.Printf("Failed to fetch doctor details for %s: %v", name, err)
			return
		}
		defer detailRes.Body.Close()

		if detailRes.StatusCode != 200 {
			log.Printf("Status code error: %d %s for %s", detailRes.StatusCode, detailRes.Status, doctorURL)
			return
		}

		// Parsing HTML dari URL baru yang berisi detail informasi dokter spesialis gizi klinik tersebut
		detailDoc, err := goquery.NewDocumentFromReader(detailRes.Body)
		if err != nil {
			log.Printf("Failed to parse doctor details page for %s: %v", name, err)
			return
		}

		// Mencari informasi dari dokter spesialis gizi klinik tersebut
		experience := strings.TrimSpace(detailDoc.Find(".stats__value").First().Text())
		rating := strings.TrimSpace(detailDoc.Find(".stats__value--rating").Text())
		price := strings.TrimSpace(detailDoc.Find(".personal-info__price--new-price").Text())

		var education []string
		var practiceLocations []string
		detailDoc.Find(".other-info__details").Each(func(i int, section *goquery.Selection) {
			header := section.Find(".other-info__details--header").Text()

			if strings.Contains(header, "Alumnus") {
				// education
				section.Find(".other-info__details--text").Each(func(i int, edu *goquery.Selection) {
					education = append(education, strings.TrimSpace(edu.Text()))
				})
			} else if strings.Contains(header, "Praktik di") {
				// practice location
				section.Find(".other-info__details--text").Each(func(i int, loc *goquery.Selection) {
					location := strings.TrimSpace(loc.Text())
					if location != "" {
						practiceLocations = append(practiceLocations, location)
					}
				})
			}
		})

		strNumber := strings.TrimSpace(detailDoc.Find(".other-info__details--text").Last().Text())

		// Membentuk struktur data doctorsInfo dari informasi yang didapatkan
		doctorsInfo = append(doctorsInfo, DoctorInfo{
			Name:             name,
			DoctorURL:        doctorURL,
			Experience:       convExp(experience), 
			Rating:           convRate(rating),    
			Price:            convPrice(price),    
			Education:        convEdu(education),  
			PracticeLocation: convLoc(practiceLocations), 
			StrNumber:        strNumber,
		})
	})

	// Output hasil scraping
	for _, doctor := range doctorsInfo {
		fmt.Printf("Name: %s\n", doctor.Name)
		fmt.Printf("URL: %s\n", doctor.DoctorURL)
		fmt.Printf("Experience: %d years\n", doctor.Experience)
		fmt.Printf("Rating: %.1f\n", doctor.Rating)
		fmt.Printf("Price: Rp %d\n", doctor.Price)
		fmt.Printf("Education:\n")
		for _, edu := range doctor.Education {
			fmt.Printf("  University: %s, Year: %d\n", edu.University, edu.Year)
		}
		fmt.Printf("Practice Locations:\n")
		for _, loc := range doctor.PracticeLocation {
			fmt.Printf("  City: %s, Province: %s\n", loc.City, loc.Province)
		}
		fmt.Printf("STR Number: %s\n", doctor.StrNumber)
		fmt.Println()
	}

	// Menyimpan data dalam format JSON
	if err := makeJSON(doctorsInfo, "data"); err != nil {
		log.Fatalf("Failed to save data to JSON file: %v", err)
	}
}
