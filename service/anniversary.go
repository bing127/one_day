package service

import (
	"errors"
	"github.com/jinzhu/gorm"
	"oneDay_service/model"
)

func CreateAnniversary(an *model.Anniversary) bool {
	err := model.Db.Create(an).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

// 验证该文章是否存在
func VerifyAnniversaryIsExist(id string) bool {
	anniversary := model.Anniversary{}
	err := model.Db.Where("id = ?", id).Find(&anniversary).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

func UpdateAnniversary(id string,params map[string]interface{}) bool {
	anniversary := model.Anniversary{}
	err := model.Db.Model(&anniversary).Where("id = ?",id).Updates(params).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

func DeleteAn(id string) bool {
	anniversary := model.Anniversary{}
	err := model.Db.Where("id = ?",id).Delete(&anniversary).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return false
		}
		return false
	}
	return true
}

func PageList(id string,no,size int) (*[]model.Anniversary,error) {
	anniversary := make([]model.Anniversary,0)
	if no<0 {
		no = 1
	}
	err := model.Db.Where("user_id = ?",id).Limit(size).Offset((no - 1) * size).Order("date desc").Find(&anniversary).Error
	if err != nil {
		if gorm.IsRecordNotFoundError(err) {
			return nil,errors.New("暂无符合结果")
		}
		return nil,errors.New("查询失败")
	}
	return &anniversary,nil
}