package v1

import (
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	"gopkg.in/gomail.v2"
	"math/rand"
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

func UserLogin(c *gin.Context)  {
	params := make(map[string]interface{})
	loginName := c.PostForm("login_name")
	pwd := c.PostForm("password")
	if len(loginName) <= 0 {
		c.JSON(http.StatusOK,e.ResponseJson("账号不能为空",nil,false))
		return
	}
	if len(pwd) <= 0 {
		c.JSON(http.StatusOK,e.ResponseJson("密码不能为空",nil,false))
		return
	}
	params["login_name"] = loginName
	params["password"] = utils.CreateMd5(pwd)
	result,err := service.GetUserByParams(params)
	if err != nil {
		c.JSON(http.StatusOK,e.ResponseJson("账号或者密码错误",nil,false))
		return
	}
	if result.LoginFlag == "-1" {
		c.JSON(http.StatusOK,e.ResponseJson("该账号禁止登陆",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("请求成功",result,true))
	return
}

func UserRegister(c *gin.Context) {
	email := c.PostForm("email")
	pwd := c.PostForm("password")
	if len(email) <= 0 {
		c.JSON(http.StatusOK,e.ResponseJson("邮箱不能为空",nil,false))
		return
	}
	if len(pwd) <= 0 || len(pwd) < 8{
		c.JSON(http.StatusOK,e.ResponseJson("密码不能为空或者不能少于8位",nil,false))
		return
	}
	result,_ := verifyUserIsExist("",email)
	if result!=nil {
		c.JSON(http.StatusOK,e.ResponseJson("该账号已存在",nil,false))
		return
	}
	status := service.CreateUserByParams(email,utils.CreateMd5(pwd))
	if status == false {
		c.JSON(http.StatusOK,e.ResponseJson("系统错误",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("创建成功",nil,true))
	return
}

func ResetPwd(c *gin.Context)  {
	email := c.PostForm("email")
	pwd := c.PostForm("password")
	if len(email) <= 0 {
		c.JSON(http.StatusOK,e.ResponseJson("邮箱不能为空",nil,false))
		return
	}
	if len(pwd) <= 0 || len(pwd) < 8{
		c.JSON(http.StatusOK,e.ResponseJson("密码不能为空或者不能少于8位",nil,false))
		return
	}
	_,err := verifyUserIsExist("",email)
	if err!=nil{
		c.JSON(http.StatusOK,e.ResponseJson(err.Error(),nil,false))
		return
	}
	status := service.UpdateUserByParams(email,utils.CreateMd5(pwd))
	if status == false {
		c.JSON(http.StatusOK,e.ResponseJson("用户更新失败",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("用户更新成功",nil,true))
	return
}

func UpdateUser(c *gin.Context)  {
	params := make(map[string]interface{})
	id := c.PostForm("id")
	nickname := c.PostForm("name")
	_, image, err := c.Request.FormFile("image")
	if len(id) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("用户id不能为空",nil,false))
		return
	}
	if len(nickname) <=0 {
		c.JSON(http.StatusOK,e.ResponseJson("用户昵称不能为空",nil,false))
		return
	}
	if err != nil {
		c.JSON(http.StatusOK,e.ResponseJson("用户头像不能为空",nil,false))
		return
	}

	_,userErr := verifyUserIsExist(id,"")
	if userErr!=nil{
		c.JSON(http.StatusOK,e.ResponseJson(userErr.Error(),nil,false))
		return
	}
	path := setting.Config.File.Path + utils.CreateUUID() + file.GetExt(image.Filename)
	errStr := c.SaveUploadedFile(image, path)
	if errStr != nil {
		c.JSON(http.StatusOK,e.ResponseJson("头像上传失败",nil,true))
		return
	}
	params["name"] = nickname
	params["Photo"] = path
	updateStatus := service.UpdateUser(id,params)
	if !updateStatus {
		c.JSON(http.StatusOK,e.ResponseJson("更新失败",nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("更新成功",nil,true))
	return


}

func SendMail(c *gin.Context)  {
	email := c.PostForm("email")
	if len(email) <= 0 {
		c.JSON(http.StatusOK,e.ResponseJson("邮箱不能为空",nil,false))
		return
	}
	result,err := verifyUserIsExist("",email)
	if err!=nil{
		c.JSON(http.StatusOK,e.ResponseJson(err.Error(),nil,false))
		return
	}

	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	code := fmt.Sprintf("%06v", rnd.Int31n(1000000))
	now := time.Now()
	t := fmt.Sprintf("%02d-%02d-%02d %02d:%02d:%02d", now.Year(), now.Month(), now.Day(), now.Hour(), now.Minute(), now.Second())
	mailConn := map[string]string{
		"user": setting.Config.Mail.User,
		"pass": setting.Config.Mail.Password,
		"host": setting.Config.Mail.Host,
		"port": setting.Config.Mail.Port,
	}
	html := fmt.Sprintf(`
		<div>
		<div>
			尊敬的%s，您好！
		</div>
		<div style="margin-top:30px">
			<p>您于 %s 提交的邮箱验证，本次验证码为:</p>
		</div>
		<div style="font-size: 30px;width: 100vw;text-align: center;margin-top: 50px;background: #f0f1f5;font-weight: bolder;height: 100px;line-height: 100px">
			<p><span style="font-size: 30px;text-align: center;font-weight: bolder;">%s</span></p>
		</div>
		<div>
			<p>为了保证账号安全，验证码有效期为5分钟。请确认为本人操作，切勿向他人泄露，感谢您的理解与使用。</p>
		</div>
		<div style="margin-top:30px">
			<p>此邮箱为系统邮箱，请勿回复。</p>
			<p style="text-align: right;">%s</p>
		</div>	
	</div>`,result.Name,t,code,setting.Config.App.Description)

	m := gomail.NewMessage()
	port, _ := strconv.Atoi(mailConn["port"])
	m.SetAddressHeader("From", mailConn["user"], setting.Config.App.Name)
	m.SetHeader("To", email)
	m.SetHeader("Subject", "[我的验证码]邮箱验证")
	m.SetBody("text/html", html)

	d := gomail.NewDialer(mailConn["host"], port, mailConn["user"], mailConn["pass"])
	if err := d.DialAndSend(m); err !=nil {
		c.JSON(http.StatusOK,e.ResponseJson(err.Error(),nil,false))
		return
	}
	c.JSON(http.StatusOK,e.ResponseJson("发送成功",code,false))
	return
}



// 验证用户信息
func verifyUserIsExist(id,mail string) (*model.User,error) {
	params := make(map[string]interface{})
	if len(mail) > 0{
		params["login_name"] = mail
	}
	if len(id) > 0{
		params["id"] = id
	}
	result,err := service.GetUserByParams(params)
	if err != nil {
		return nil,errors.New("查询失败")
	}
	return result,nil
}

