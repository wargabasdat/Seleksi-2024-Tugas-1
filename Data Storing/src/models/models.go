package models

type ProblemInformation struct {
	ID     string   `json:"id"`
	Title  string   `json:"title"`
	URL    string   `json:"url"`
	Tag    []string `json:"tag"`
	Rating string   `json:"rating"`
	// Details ProblemDetails `json:"details"`
}

type IO struct {
	Input  string `json:"input"`
	Output string `json:"output"`
}

type Contest struct {
	ContestID string `json:"contestID"`
	Name 	string `json:"name"`
	Writers []string `json:"writers"`
	StartTime string `json:"startTime"`
	Duration string `json:"duration"`
	TotalParticipants int `json:"TotalParticipants"`
}

type ProblemDetails struct {
	IO []IO `json:"io"`
	Contest Contest `json:"contest"`
}

type Config struct {
	UnvisitedProblemPages []int `json:"unvisitedProblemPages"`
	UnvisitedContestPages []int `json:"unvisitedContestPages"`
	Data Data `json:"data"`
}

type Data struct {
	Problems map[string]ProblemInformation `json:"problems"`
	Contests map[string]Contest `json:"contests"`
}
	
