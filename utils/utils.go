package utils

import (
	"crypto/md5"
	"encoding/hex"
	"github.com/satori/go.uuid"
	"strings"
)

//生成md5
func CreateMd5(s string) string {
	m := md5.New()
	m.Write([]byte (s))
	return hex.EncodeToString(m.Sum(nil))
}

//生成UUID
func CreateUUID() string {
	u1 := uuid.NewV1()
	return strings.Replace(u1.String(),"-","",-1)
}

