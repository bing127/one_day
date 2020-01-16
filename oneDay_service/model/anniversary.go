package model

import "time"

type Anniversary struct {
	ID	string	`gorm:"primary_key" json:"id"` //
	Date	time.Time	`json:"date"` //
	Name	string	`json:"name"` //
	Thumbnail	string	`json:"thumbnail"` //
	UserId	string	`json:"user_id"` //
	Category	string	`json:"category"` //
}