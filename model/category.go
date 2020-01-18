package model

type Category struct {
	ID	string	`gorm:"primary_key" json:"id"` //
	Name	string	`json:"name"` //
}
