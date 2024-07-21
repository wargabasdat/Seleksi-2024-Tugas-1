package models

type User struct {
    UserID     string   `json:"user_id"`
    Username   string   `json:"username"`
    Profile    string   `json:"profile"`
    Reputation int      `json:"reputation"`
    Tags       []string `json:"tags"`
}

type Comment struct {
    CommentID string `json:"comment_id"`
    PostID    string `json:"post_id"`
    Body      string `json:"body"`
    User      User   `json:"user"`
}

type Answer struct {
    AnswerID string    `json:"answer_id"`
    Body     string    `json:"body"`
    User     User      `json:"user"`
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
    QuestionID string   `json:"question_id"`
    Title      string   `json:"title"`
    Body       string   `json:"body"`
    Link       string   `json:"link"`
    User       User     `json:"user"`
    Score      int      `json:"score"`
    Tags       []QuestionTag    `json:"tags"`
    Answers    []Answer `json:"answers"`
}
