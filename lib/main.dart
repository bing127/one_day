import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:one_day/page/app.dart';
import 'package:one_day/page/lock_page.dart';
import 'package:one_day/routers/application.dart';
import 'package:one_day/routers/routers.dart';

void main() async {
  runApp(AppLock(
    builder: (args) => MyApp(),
    lockScreen: LockPage(),
    enabled: true,
  ));

  // 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'OneDay - 勿忘日:计算日子的勿忘清单',
        theme: ThemeData(
          primaryColor: Color(0xff4FA760),
          accentColor: Color(0xff4FA760),
        ),
        home: App()
    );
  }
}
