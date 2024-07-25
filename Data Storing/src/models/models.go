package models

type User struct {
    UserID     string   `json:"user_id"`
    Username   string   `json:"username"`
    Reputation int      `json:"reputation"`
    Tags       []string `json:"tags"`
}
type ShortUser struct {
    UserID     string   `json:"user_id"`
    Username   string   `json:"username"`
}

type Comment struct {
    CommentID string `json:"comment_id"`
    Body      string `json:"body"`
    User      ShortUser   `json:"user"`
}

type Answer struct {
    AnswerID string    `json:"answer_id"`
    Body     string    `json:"body"`
    User     ShortUser      `json:"user"`
    Score    int       `json:"score"`
    Comments []Comment `json:"comments"`
}

type Tag struct {
    TagID string `json:"tag_id"`
    Name  string `json:"name"`
    TotalQuestions    int `json:"total_questions"`
}

type QuestionTag struct {
    TagID string `json:"tag_id"`
    Name  string `json:"name"`
}

type Question struct {
    QuestionID string           `json:"question_id"`
    Title      string           `json:"title"`
    Body       string           `json:"body"`
    Link       string           `json:"link"`
    User       ShortUser        `json:"user"`
    Score      int              `json:"score"`
    Comments   []Comment        `json:"comments"` 
    Tags       []QuestionTag    `json:"tags"`
    Answers    []Answer         `json:"answers"`
}
