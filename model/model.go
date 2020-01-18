package model

import (
	"fmt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"oneDay_service/utils/setting"
	"os"
)

var (
	dbname   = setting.Config.DB.Table
	user     = setting.Config.DB.User
	password = setting.Config.DB.Password
	host     = setting.Config.DB.Host
	port     = setting.Config.DB.Port
)

var Db *gorm.DB

// Open 打开数据库
func init() {
	var (
		err error
	)

	dbLink := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=true&loc=Local", user, password, host, port, dbname)
	Db, err = gorm.Open(setting.Config.DB.Type,dbLink)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(-1)
	}
	//gorm.DefaultTableNameHandler = func (db *gorm.DB, defaultTableName string) string  {
	//	return tablePrefix + defaultTableName;
	//}
	Db.SingularTable(true)
	Db.DB().SetMaxIdleConns(10)
	Db.DB().SetMaxOpenConns(100)
	Db.LogMode(setting.Config.DB.Log)

	autoMigrate(&User{}, &Category{}, &Anniversary{})

}

// Close 关闭数据库
func main(){
	defer Db.Close()//退出前执行关闭
}

func autoMigrate(values ...interface{}) {
	Db.AutoMigrate(values...)
}
