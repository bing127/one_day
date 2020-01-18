package model

import (
	"time"
)

type User struct {
	ID	string	`gorm:"primary_key" json:"id"` //编号
	LoginName	string	`json:"login_name"` //登录名
	Password	string	`json:"password"` //密码
	Name	string	`json:"name"` //姓名
	Photo	string	`json:"photo"` //用户头像
	LoginIp	string	`json:"login_ip"` //最后登陆IP
	LoginDate	time.Time	`json:"login_date"` //最后登陆时间
	LoginFlag	string	`json:"login_flag"` //是否可登录
	CreateBy	string	`json:"create_by"` //创建者
	CreateDate	time.Time	`json:"create_date"` //创建时间
	UpdateBy	string	`json:"update_by"` //更新者
	UpdateDate	time.Time	`json:"update_date"` //更新时间
	Remarks	string	`json:"remarks"` //备注信息
	Sign	string	`json:"sign"` //个性签名
}
