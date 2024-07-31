package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"json2sql/models"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
)

type Data struct {
	Tags      []models.Tag      `json:"tags"`
	Users     []models.User     `json:"users"`
	Questions []models.Question `json:"questions"`
}

func main() {
	// Read JSON file
	jsonFile, err := os.Open("../../Data Scraping/data/stack_overflow_data.json")
	if err != nil {
		log.Fatal(err)
	}
	defer jsonFile.Close()

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		log.Fatal(err)
	}

	var data Data
	if err := json.Unmarshal(byteValue, &data); err != nil {
		log.Fatal(err)
	}

	// Connect to the database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/stackoverflow?parseTime=True&loc=Local")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Set character set dan collation untuk koneksi
	_, err = db.Exec("SET character_set_server = 'utf8mb4'")
	if err != nil {
		log.Fatal(err)
	}
	_, err = db.Exec("SET collation_server = 'utf8mb4_unicode_ci'")
	if err != nil {
		log.Fatal(err)
	}

	// Prepare statements
	insertUserStmt, err := db.Prepare("INSERT INTO users (user_id, username, reputation) VALUES (?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertUserStmt.Close()

	insertUserAnonStmt, err := db.Prepare("INSERT INTO users (user_id, username, reputation) VALUES (-1, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertUserStmt.Close()

	insertTagStmt, err := db.Prepare("INSERT INTO tags (tag_id, tag_name, total_questions) VALUES (?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertTagStmt.Close()

	insertQuestionStmt, err := db.Prepare("INSERT INTO questions (question_id, title, body, link, score, questioner_id) VALUES (?, ?, ?, ?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertQuestionStmt.Close()

	insertAnswerStmt, err := db.Prepare("INSERT INTO answers (question_id, answer_id, body, score, answerer_id) VALUES (?, ?, ?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertAnswerStmt.Close()

	insertCommentStmt, err := db.Prepare("INSERT INTO comments (comment_id, body) VALUES (?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertCommentStmt.Close()

	insertQuestionTagStmt, err := db.Prepare("INSERT INTO question_tag (tag_id, question_id) VALUES (?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertQuestionTagStmt.Close()

	insertQuestionCommentStmt, err := db.Prepare("INSERT INTO question_comment (question_id, user_id, comment_id) VALUES (?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertQuestionCommentStmt.Close()

	insertAnswerCommentStmt, err := db.Prepare("INSERT INTO answer_comment (question_id, answer_id, user_id, comment_id) VALUES (?, ?, ?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertAnswerCommentStmt.Close()

	insertUserTagStmt, err := db.Prepare("INSERT INTO tag_users (user_id, tag_id) VALUES (?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer insertUserTagStmt.Close()

	// Insert tags
	for _, tag := range data.Tags {
		exists, err := recordExists(db, "tags", "tag_id", tag.TagID)
		if err != nil {
			log.Fatal(err)
		}
		if !exists {
			_, err := insertTagStmt.Exec(tag.TagID, tag.Name, tag.TotalQuestions)
			if err != nil {
				log.Fatal(err)
			}
		}
	}

	// Insert users
	for _, user := range data.Users {
		userID := extractDigits(user.UserID)
		if userID == "" {
			exists, err := recordExists(db, "users", "user_id", "-1")
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertUserAnonStmt.Exec("anon", 0)
				if err != nil {
					log.Fatal(err)
				}
			}
		} else {
			exists, err := recordExists(db, "users", "user_id", userID)
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertUserStmt.Exec(userID, user.Username, user.Reputation)
				if err != nil {
					log.Fatal(err)
				}
			}
		}

		for _, tagId := range user.Tags {
			exists, err := recordExists(db, "tags", "tag_id", tagId)
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertTagStmt.Exec(tagId, strings.Split(tagId, "/")[3], 0)
				if err != nil {
					log.Fatal(err)
				}
			}
			exists, err = recordExistsMultipleKeys(db, "tag_users", []string{"tag_id", "user_id"}, []interface{}{tagId, userID})
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertUserTagStmt.Exec(userID, tagId)
				if err != nil {
					log.Fatal(err)
				}
			}
		}
	}

	// Insert questions and related data
	for _, question := range data.Questions {
		questionerID := extractDigits(question.User.UserID)
		if questionerID == "" {
			exists, err := recordExists(db, "users", "user_id", "-1")
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertUserAnonStmt.Exec("anon", 0)
				if err != nil {
					log.Fatal(err)
				}
			}
		} else {
			exists, err := recordExists(db, "users", "user_id", questionerID)
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertUserStmt.Exec(questionerID, question.User.Username, 0)
				if err != nil {
					log.Fatal(err)
				}
			}
		}

		exists, err := recordExists(db, "questions", "question_id", question.QuestionID)
		if err != nil {
			log.Fatal(err)
		}
		if !exists {
			if questionerID == "" {
				_, err = insertQuestionStmt.Exec(question.QuestionID, question.Title, question.Body, question.Link, question.Score, -1)
				if err != nil {
					log.Fatal(err)
				}
			} else {
				_, err = insertQuestionStmt.Exec(question.QuestionID, question.Title, question.Body, question.Link, question.Score, questionerID)
				if err != nil {
					log.Fatal(err)
				}
			}
		}

		for _, tag := range question.Tags {
			tagID := tag.TagID
			exists, err := recordExists(db, "tags", "tag_id", tagID)
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertTagStmt.Exec(tagID, tag.Name, 1)
				if err != nil {
					log.Fatal(err)
				}
			}

			exists, err = recordExistsMultipleKeys(db, "question_tag", []string{"tag_id", "question_id"}, []interface{}{tagID, question.QuestionID})
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err := insertQuestionTagStmt.Exec(tagID, question.QuestionID)
				if err != nil {
					log.Fatal(err)
				}
			}
		}
		for _, comment := range question.Comments {
			commenterID := extractDigits(comment.User.UserID)
			if commenterID == "" {
				exists, err := recordExists(db, "users", "user_id", "-1")
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err := insertUserAnonStmt.Exec("anon", 0)
					if err != nil {
						log.Fatal(err)
					}
				}
			} else {
				exists, err := recordExists(db, "users", "user_id", commenterID)
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err := insertUserStmt.Exec(commenterID, comment.User.Username, 0)
					if err != nil {
						log.Fatal(err)
					}
				}
			}
			exists, err = recordExists(db, "comments", "comment_id", comment.CommentID)
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				_, err = insertCommentStmt.Exec(comment.CommentID, comment.Body)
				if err != nil {
					log.Fatal(err)
				}
			}
			if commenterID == "" {
				exists, err = recordExistsMultipleKeys(db, "question_comment", []string{"question_id", "user_id", "comment_id"}, []interface{}{question.QuestionID, -1, comment.CommentID})
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err = insertQuestionCommentStmt.Exec(question.QuestionID, -1, comment.CommentID)
					if err != nil {
						log.Fatal(err)
					}
				}
			} else {
				exists, err = recordExistsMultipleKeys(db, "question_comment", []string{"question_id", "user_id", "comment_id"}, []interface{}{question.QuestionID, commenterID, comment.CommentID})
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err = insertQuestionCommentStmt.Exec(question.QuestionID, commenterID, comment.CommentID)
					if err != nil {
						log.Fatal(err)
					}
				}
			}
		}
		for _, answer := range question.Answers {
			answererID := extractDigits(answer.User.UserID)
			if answererID == "" {
				exists, err := recordExists(db, "users", "user_id", "-1")
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err := insertUserAnonStmt.Exec("anon", 0)
					if err != nil {
						log.Fatal(err)
					}
				}
			} else {
				exists, err := recordExists(db, "users", "user_id", answererID)
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err := insertUserStmt.Exec(answererID, answer.User.Username, 0)
					if err != nil {
						log.Fatal(err)
					}
				}
			}
			exists, err = recordExistsMultipleKeys(db, "answers", []string{"question_id", "answer_id"}, []interface{}{question.QuestionID, answer.AnswerID})
			if err != nil {
				log.Fatal(err)
			}
			if !exists {
				if answererID == "" {
					_, err = insertAnswerStmt.Exec(question.QuestionID, answer.AnswerID, answer.Body, answer.Score, -1)
					if err != nil {
						log.Fatal(err)
					}
				} else {
					_, err = insertAnswerStmt.Exec(question.QuestionID, answer.AnswerID, answer.Body, answer.Score, answererID)
					if err != nil {
						log.Fatal(err)
					}
				}
			}

			for _, comment := range answer.Comments {
				commenterID := extractDigits(comment.User.UserID)
				if commenterID == "" {
					exists, err := recordExists(db, "users", "user_id", "-1")
					if err != nil {
						log.Fatal(err)
					}
					if !exists {
						_, err := insertUserAnonStmt.Exec("anon", 0)
						if err != nil {
							log.Fatal(err)
						}
					}
				} else {
					exists, err := recordExists(db, "users", "user_id", commenterID)
					if err != nil {
						log.Fatal(err)
					}
					if !exists {
						_, err := insertUserStmt.Exec(commenterID, comment.User.Username, 0)
						if err != nil {
							log.Fatal(err)
						}
					}

				}

				exists, err = recordExists(db, "comments", "comment_id", comment.CommentID)
				if err != nil {
					log.Fatal(err)
				}
				if !exists {
					_, err = insertCommentStmt.Exec(comment.CommentID, comment.Body)
					if err != nil {
						log.Fatal(err)
					}
				}

				if commenterID == "" {
					exists, err = recordExistsMultipleKeys(db, "answer_comment", []string{"question_id", "answer_id", "user_id", "comment_id"}, []interface{}{question.QuestionID, answer.AnswerID, -1, comment.CommentID})
					if err != nil {
						log.Fatal(err)
					}
					if !exists {
						_, err = insertAnswerCommentStmt.Exec(question.QuestionID, answer.AnswerID, -1, comment.CommentID)
						if err != nil {
							log.Fatal(err)
						}
					}
				} else {
					exists, err = recordExistsMultipleKeys(db, "answer_comment", []string{"question_id", "answer_id", "user_id", "comment_id"}, []interface{}{question.QuestionID, answer.AnswerID, commenterID, comment.CommentID})
					if err != nil {
						log.Fatal(err)
					}
					if !exists {
						_, err = insertAnswerCommentStmt.Exec(question.QuestionID, answer.AnswerID, commenterID, comment.CommentID)
						if err != nil {
							log.Fatal(err)
						}
					}
				}
			}
		}
	}

	fmt.Println("Data has been successfully inserted into the database.")
}

func extractDigits(input string) string {
	var digits []rune
	for _, r := range input {
		if r >= '0' && r <= '9' {
			digits = append(digits, r)
		}
	}
	return string(digits)
}

func recordExists(db *sql.DB, table, column, value string) (bool, error) {
	var exists bool
	query := fmt.Sprintf("SELECT EXISTS (SELECT 1 FROM %s WHERE %s = ?)", table, column)
	err := db.QueryRow(query, value).Scan(&exists)
	if err != nil && err != sql.ErrNoRows {
		return false, err
	}
	return exists, nil
}

func recordExistsMultipleKeys(db *sql.DB, table string, columns []string, values []interface{}) (bool, error) {
	var exists bool
	whereClause := ""
	for i, column := range columns {
		if i > 0 {
			whereClause += " AND "
		}
		whereClause += fmt.Sprintf("%s = ?", column)
	}
	query := fmt.Sprintf("SELECT EXISTS (SELECT 1 FROM %s WHERE %s)", table, whereClause)
	err := db.QueryRow(query, values...).Scan(&exists)
	if err != nil && err != sql.ErrNoRows {
		return false, err
	}
	return exists, nil
}
