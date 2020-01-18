package routers

import (
	"github.com/gin-gonic/gin"
	"oneDay_service/middleware/cors"
	v1 "oneDay_service/routers/v1"
	"oneDay_service/utils/e"
	"oneDay_service/utils/setting"
	"net/http"
	"time"
)


func InitRouter() *gin.Engine {
	router := gin.New()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())
	router.Use(cors.CorsHandler())
	router.MaxMultipartMemory = setting.Config.File.Max * 1024 *1024
	gin.SetMode(setting.Config.Model.Type)
	//获取当前文件的相对路径
	router.Static("static", "./static")

	router.GET("/test/:id", Test)

	router.NoRoute(func(c *gin.Context) {
		c.JSON(http.StatusNotFound, e.NotFound())
	})

	//v1 路由
	apiV1 := router.Group("/api/v1")
	{
		//用户
		apiV1.POST("/login",v1.UserLogin)
		apiV1.POST("/register",v1.UserRegister)
		apiV1.POST("/sendMail",v1.SendMail)
		apiV1.POST("/forgetPwd",v1.ResetPwd)
		apiV1.POST("/updateUser",v1.UpdateUser)
		//文章
		apiV1.POST("/anniversaryList",v1.AnniversaryList)
		apiV1.POST("/createAnniversary",v1.CreateAnniversary)
		apiV1.POST("/updateAnniversary",v1.UpdateAnniversary)
		apiV1.POST("/deleteAnniversary",v1.DeleteAnniversary)
	}
	return router
}

func Test(c *gin.Context) {
	json := make(map[string]interface{})
	json["time"] = time.Now().Format("2006-01-02 15:04:05")
	json["id"] = c.Param("id")
	json["name"] = c.Query("name")
	c.JSON(200, e.ResponseJson("操作成功",json,true))
}

