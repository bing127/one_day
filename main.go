package main

import (
	"context"
	"log"
	"net/http"
	_ "oneDay_service/model"
	"oneDay_service/routers"
	"oneDay_service/utils/setting"
	"os"
	"os/signal"
	"time"
)

func main() {
	router := routers.InitRouter()
	srv := &http.Server{
		Addr:           ":" + setting.Config.Server.Port,
		Handler:        router,
		ReadTimeout:    setting.Config.Server.ReadTimeout * 1000,
		WriteTimeout:   setting.Config.Server.WriteTimeout * 1000,
		MaxHeaderBytes: 1 << 20,
	}

	go func() {
		// 服务连接
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("listen: %s\n", err)
		}
	}()

	// 等待中断信号以优雅地关闭服务器（设置 5 秒的超时时间）
	quit := make(chan os.Signal)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Println("Shutdown Server ...")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal("Server Shutdown:", err)
	}
	log.Println("Server exiting")
}
