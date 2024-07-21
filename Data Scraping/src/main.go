package main

import (
	"encoding/json"
	"log"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"

	"stackoverflow.com/models"

	"github.com/gocolly/colly"
)

func main() {
	startTime := time.Now()
	var questions []models.Question
	var users []models.User
	var tags []models.Tag
	var mu sync.Mutex
	var wg sync.WaitGroup
	var questionCount, answerCount, tagCount, userCount int

	c := colly.NewCollector(
		colly.AllowedDomains("stackoverflow.com"),
	)
	c.Limit(&colly.LimitRule{
		DomainGlob:  "*stackoverflow.*",
		Delay:      5 * time.Second,
		Parallelism: 15,
		RandomDelay: 5 * time.Second,
	})

	// Extract question data
	c.OnHTML(".js-post-summary", func(e *colly.HTMLElement) {
		question := models.Question{
			QuestionID: e.Attr("data-post-id"),
			Title:      e.ChildText(".s-post-summary--content-title a"),
			Link:       "https://stackoverflow.com" + e.ChildAttr(".s-post-summary--content-title a", "href"),
			Score: func() int {
				score, _ := strconv.Atoi(e.ChildText(".s-post-summary--stats-item-number"))
				return score
			}(),
			User: models.User{
				UserID:   e.ChildAttr(".s-user-card--avatar", "data-user-id"),
				Username: e.ChildText(".s-user-card--link a"),
				Profile:  e.ChildAttr(".s-user-card--link a", "href"),
				Reputation: func() int {
					repStr := e.ChildText(".s-user-card--rep span")
					repStr = strings.ReplaceAll(repStr, ",", "")
					rep, _ := strconv.Atoi(repStr)
					return rep
				}(),
			},
		}

		e.ForEach(".js-post-tag-list-item a", func(_ int, el *colly.HTMLElement) {
			tag := models.QuestionTag{
				TagID: el.Attr("href"),
				Name:  el.Text,
			}
			question.Tags = append(question.Tags, tag)
		})

		// Visit question page to collect body and answers
		wg.Add(1)
		go func(link string, questionID string) {
			defer wg.Done()
			questionCollector := c.Clone()
			questionCollector.OnHTML(".question", func(e *colly.HTMLElement) {
				bodyHTML := e.ChildText(".postcell .s-prose")
				mu.Lock()
				for i, q := range questions {
					if q.QuestionID == questionID {
						questions[i].Body = bodyHTML
					}
				}
				mu.Unlock()
			})
			questionCollector.OnHTML(".answer", func(e *colly.HTMLElement) {
				answer := models.Answer{
					AnswerID: e.Attr("data-answerid"),
					Body:     e.ChildText(".s-prose"),
					Score: func() int {
						score, _ := strconv.Atoi(e.Attr("data-score"))
						return score
					}(),
				}

				// Extract user info from the answer
				e.ForEach(".post-signature", func(_ int, el *colly.HTMLElement) {
					if strings.Contains(el.ChildText(".user-action-time"), "answered") {
						answer.User = models.User{
							UserID:   el.ChildAttr(".user-gravatar32 a", "href"),
							Username: el.ChildText(".user-details a"),
							Profile:  el.ChildAttr(".user-details a", "href"),
							Reputation: func() int {
								repStr := el.ChildText(".user-details .reputation-score")
								repStr = strings.ReplaceAll(repStr, ",", "")
								rep, _ := strconv.Atoi(repStr)
								return rep
							}(),
						}
					}
				})

				e.ForEach(".js-comments-container .comment", func(_ int, el *colly.HTMLElement) {
					comment := models.Comment{
						CommentID: el.Attr("data-comment-id"),
						PostID:    el.Attr("data-post-id"),
						Body:      el.ChildText(".comment-copy"),
						User: models.User{
							UserID:   el.ChildAttr(".comment-user", "href"),
							Username: el.ChildText(".comment-user"),
							Profile:  el.ChildAttr(".comment-user", "href"),
						},
					}
					answer.Comments = append(answer.Comments, comment)
				})

				mu.Lock()
				for i, q := range questions {
					if q.QuestionID == questionID {
						questions[i].Answers = append(questions[i].Answers, answer)
						answerCount++
					}
				}
				mu.Unlock()
			})

			questionCollector.Visit(link)
		}(question.Link, question.QuestionID)

		mu.Lock()
		questions = append(questions, question)
		questionCount++
		mu.Unlock()
	})

	// Extract user data
	c.OnHTML(".user-info.user-hover", func(e *colly.HTMLElement) {
		user := models.User{
			UserID:   e.ChildAttr(".user-gravatar48 a", "href"),
			Username: e.ChildText(".user-details a"),
			Profile:  e.ChildAttr(".user-details a", "href"),
			Reputation: func() int {
				reputationStr := e.ChildText(".user-details .reputation-score")
				reputationStr = strings.ReplaceAll(reputationStr, ",", "")
				reputation, _ := strconv.Atoi(reputationStr)
				return reputation
			}(),
		}

		e.ForEach(".user-tags a", func(_ int, el *colly.HTMLElement) {
			user.Tags = append(user.Tags, el.Text)
		})

		mu.Lock()
		users = append(users, user)
		userCount++
		mu.Unlock()
	})

	// Extract tag data
	c.OnHTML(".s-card.js-tag-cell", func(e *colly.HTMLElement) {
		tag := models.Tag{
			TagID: e.ChildAttr("a.post-tag", "href"),
			Name:  e.ChildText("a.post-tag"),
			TotalQuestions: func() int {
				questionsText := e.ChildText(".d-flex.jc-space-between.fs-caption.fc-black-400 .flex--item")
				if strings.Contains(questionsText, "questions") {
					totalStr := strings.TrimSpace(strings.Split(questionsText, " ")[0])
					total, _ := strconv.Atoi(totalStr)
					return total
				}
				return 0
			}(),
		}
		mu.Lock()
		tags = append(tags, tag)
		tagCount++
		mu.Unlock()
	})
	

	// Handle request and error
	c.OnRequest(func(r *colly.Request) {
		log.Println("Visiting", r.URL.String())
	})

	c.OnError(func(r *colly.Response, err error) {
		log.Printf("Request URL: %v failed with error: %v", r.Request.URL, err)
		// Implement a retry mechanism with a delay
		time.Sleep(2 * time.Second)
		r.Request.Retry()
	})

	// Start scraping with initial pages
	initialPages := []string{
		"https://stackoverflow.com/questions?sort=MostVotes&edited=true&page=",
		"https://stackoverflow.com/users?page=",
		"https://stackoverflow.com/tags?page=",
	}

	for i := 0; i < 20; i++ {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			for _, page := range initialPages {
				wg.Add(1)
				go func(p string) {
					defer wg.Done()
					c.Visit(p + strconv.Itoa(i+1))
				}(page)
				time.Sleep(3 * time.Second)
			}
		}(i)
	}
	wg.Wait()

	// Save data to JSON file
	data := map[string]interface{}{
		"questions": questions,
		"users":     users,
		"tags":      tags,
	}

	jsonData, err := json.MarshalIndent(data, "", "  ")
	if err != nil {
		log.Fatal(err)
	}

	err = os.WriteFile("../data/stack_overflow_data.json", jsonData, 0644)
	if err != nil {
		log.Fatal(err)
	}

	log.Println("Data berhasil disimpan ke file stack_overflow_data.json")
	log.Printf("Total Questions: %d\n", questionCount)
	log.Printf("Total Answers: %d\n", answerCount)
	log.Printf("Total Tags: %d\n", tagCount)
	log.Printf("Total Users: %d\n", userCount)
	log.Println("Duration: ", time.Since(startTime))
}
