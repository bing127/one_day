package setting

import (
	"github.com/jinzhu/configor"
	"log"
	"time"
)

var Config = struct {
	DB struct {
		Type     string
		User     string
		Password string
		Table     string
		Host     string
		Port     string
		Log      bool
	}
	Server struct{
		Port    string
		ReadTimeout  time.Duration
		WriteTimeout  time.Duration
	}
	App struct{
		Name string
		Description string
	}

	Mail struct{
		User string
		Password string
		Host string
		Port string
	}

	Model struct{
		Type string
	}

	File struct{
		Path string
		Max int64
		Suffix []string
	}

}{}

func init() {
	var err error
	err = configor.Load(&Config, "conf/app.yml")
	if err != nil {
		log.Fatalf("Fail to parse 'conf/app.yml': %v", err)
	}
}
