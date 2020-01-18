package file

import (
	"io/ioutil"
	"log"
	"mime/multipart"
	"os"
	"os/exec"
	"path"
	"strings"
)

//获取本地根目录
func RootPath() string {
	s, err := exec.LookPath(os.Args[0])
	if err != nil {
		log.Panicln("发生错误",err.Error())
	}
	i := strings.LastIndex(s, "\\")
	path := s[0 : i+1]
	return path
}

//获取文件大小
func GetSize(f multipart.File) (int, error) {
	content, err := ioutil.ReadAll(f)

	return len(content), err
}

//GetExt：获取文件后缀
func GetExt(fileName string) string {
	return path.Ext(fileName)
}

//CheckExist：检查文件是否存在
func CheckExist(src string) bool {
	_, err := os.Stat(src)

	return os.IsNotExist(err)
}

//CheckPermission：检查文件权限
func CheckPermission(src string) bool {
	_, err := os.Stat(src)

	return os.IsPermission(err)
}

//IsNotExistMkDir：如果不存在则新建文件夹
func IsNotExistMkDir(src string) error {
	if exist := CheckExist(src); exist == false {
		if err := MkDir(src); err != nil {
			return err
		}
	}

	return nil
}
//MkDir：新建文件夹
func MkDir(src string) error {
	err := os.MkdirAll(src, os.ModePerm)
	if err != nil {
		return err
	}

	return nil
}
//Open：打开文件
func Open(name string, flag int, perm os.FileMode) (*os.File, error) {
	f, err := os.OpenFile(name, flag, perm)
	if err != nil {
		return nil, err
	}

	return f, nil
}

