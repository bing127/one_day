package service

import (
	"errors"
	"github.com/jinzhu/gorm"
	"oneDay_service/model"
	"oneDay_service/utils"
	"time"
)

func GetUserByParams(params interface{}) (*model.User,error) {
	user := model.User{}
	err := model.Db.Where(params).Find(&user).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return nil,errors.New("未找到符合条件信息")
		}
		return nil,errors.New("查询失败")
	}
	return &user,nil
}

func UpdateUserByParams(mail,pwd string) bool {
	user := model.User{}
	err := model.Db.Model(&user).Where("login_name = ?", mail).Update("password", pwd).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

func UpdateUser(id string,params map[string]interface{}) bool {
	user := model.User{}
	err := model.Db.Model(&user).Where("id = ?", id).Updates(params).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

func CreateUserByParams(mail,pwd string) bool {
	userId := utils.CreateUUID()

	user := model.User{
		ID: userId,
		LoginName:mail,
		Password:pwd,
		CreateBy: "1",
		CreateDate: time.Now(),
		UpdateBy: "1",
		UpdateDate: time.Now(),
		LoginDate: time.Now(),
	}
	err := model.Db.Save(&user).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}