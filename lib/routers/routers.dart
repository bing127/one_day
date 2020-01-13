import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:one_day/routers/404.dart';
import 'package:one_day/routers/router_init.dart';

import 'package:one_day/page/app_router.dart';
import 'package:one_day/page/app.dart';

class Routes {

  static String home = "/app";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint("未找到目标页");
        return WidgetNotFound();
      });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => App()));
    

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(AppRouter());
  
    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}
