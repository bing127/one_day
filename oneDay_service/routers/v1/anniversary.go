package v1

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"oneDay_service/model"
	"oneDay_service/service"
	"oneDay_service/utils"
	"oneDay_service/utils/e"
	"oneDay_service/utils/file"
	"oneDay_service/utils/setting"
	"strconv"
	"time"
)

func AnniversaryList(c *gin.Context)  {
	userId := c.PostForm("user_id")
	pageNo := c.PostForm("pageNo")
	pageSize := c.PostForm("pageSize")
	if len(userId) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("用户id不能为空",nil,false))
		return
	}
	_,userErr := verifyUserIsExist(userId,"")
	if userErr!=nil{
		c.JSON(http.StatusOK,e.ResponseJson("用户不存在",nil,false))
		return
	}
	if len(pageNo) <=0 || len(pageSize) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("页码不能为空",nil,false))
		return
	}
	pageNoInt,_ := strconv.Atoi(pageNo)
	pageSizeInt,_ := strconv.Atoi(pageSize)
	result,err := service.PageList(userId,pageNoInt,pageSizeInt)
	if err!=nil {
		c.JSON(http.StatusOK,e.ResponseJson(err.Error(),nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("查询成功",result,true))
	return
}

func CreateAnniversary(c *gin.Context)  {
	userId := c.PostForm("user_id")
	date := c.PostForm("date")
	name := c.PostForm("name")
	_, thumbnail, err := c.Request.FormFile("thumbnail")
	category := c.PostForm("category")

	if len(userId) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("用户id不能为空",nil,false))
		return
	}
	_,userErr := verifyUserIsExist(userId,"")
	if userErr!=nil{
		c.JSON(http.StatusOK,e.ResponseJson("用户不存在",nil,false))
		return
	}
	if len(date) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("时间不能为空",nil,false))
		return
	}
	local, _ := time.LoadLocation("Asia/Shanghai")
	dateFormat,_ := time.ParseInLocation("2006-01-02 15:04:05",date,local)
	if len(name) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("标题不能为空",nil,false))
		return
	}
	if len(category) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("类别不能为空",nil,false))
		return
	}
	if err != nil {
		c.JSON(http.StatusOK,e.ResponseJson("缩略图不能为空",nil,false))
		return
	}
	path := setting.Config.File.Path + utils.CreateUUID() + file.GetExt(thumbnail.Filename)
	errStr := c.SaveUploadedFile(thumbnail, path)
	if errStr != nil {
		c.JSON(http.StatusOK,e.ResponseJson("缩略图上传失败",nil,false))
		return
	}

	anniversary := &model.Anniversary{
		ID:        utils.CreateUUID(),
		Date:      dateFormat,
		Name:      name,
		Thumbnail: path,
		UserId:    userId,
		Category:  category,
	}
	status := service.CreateAnniversary(anniversary)
	if !status {
		c.JSON(http.StatusOK,e.ResponseJson("新建失败",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("新建成功",nil,true))
	return
}


func UpdateAnniversary(c *gin.Context)  {
	params := make(map[string]interface{})
	id := c.PostForm("id")
	date := c.PostForm("date")
	name := c.PostForm("name")
	_, thumbnail, err := c.Request.FormFile("thumbnail")
	category := c.PostForm("category")
	if len(id) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("文章id不能为空",nil,false))
		return
	}
	ok := service.VerifyAnniversaryIsExist(id)
	if !ok{
		c.JSON(http.StatusOK,e.ResponseJson("文章不存在",nil,false))
		return
	}
	if len(date) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("时间不能为空",nil,false))
		return
	}
	local, _ := time.LoadLocation("Asia/Shanghai")
	dateFormat,_ := time.ParseInLocation("2006-01-02 15:04:05",date,local)
	if len(name) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("标题不能为空",nil,false))
		return
	}
	if len(category) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("类别不能为空",nil,false))
		return
	}
	if err != nil {
		c.JSON(http.StatusOK,e.ResponseJson("缩略图不能为空",nil,false))
		return
	}
	path := setting.Config.File.Path + utils.CreateUUID() + file.GetExt(thumbnail.Filename)
	errStr := c.SaveUploadedFile(thumbnail, path)
	if errStr != nil {
		c.JSON(http.StatusOK,e.ResponseJson("缩略图上传失败",nil,false))
		return
	}

	params["date"] = dateFormat
	params["name"] = name
	params["thumbnail"] = path
	params["category"] = category
	status := service.UpdateAnniversary(id,params)
	if !status {
		c.JSON(http.StatusOK,e.ResponseJson("更新失败",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("更新成功",nil,true))
	return
}

func DeleteAnniversary(c *gin.Context)  {
	id := c.PostForm("id")
	if len(id) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("文章id不能为空",nil,false))
		return
	}
	ok := service.VerifyAnniversaryIsExist(id)
	if !ok{
		c.JSON(http.StatusOK,e.ResponseJson("文章不存在",nil,false))
		return
	}

	status := service.DeleteAn(id)

	if !status{
		c.JSON(http.StatusOK,e.ResponseJson("删除失败",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("删除成功",nil,true))
	return
}