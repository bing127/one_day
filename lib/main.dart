import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:one_day/page/app.dart';
import 'package:one_day/page/lock_page.dart';
import 'package:one_day/provider/theme_provider.dart';
import 'package:one_day/routers/application.dart';
import 'package:one_day/routers/routers.dart';
import 'package:flustars/flustars.dart' show SpUtil;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  // 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        Provider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'OneDay - 勿忘日:计算日子的勿忘清单',
          theme: ThemeData(
            fontFamily: 'WorkSans',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xff2E3132),
            canvasColor: Color(0xff2E3132),
            primaryColor: Color(0xff4FA760),
            accentColor: Color(0xff4FA760),
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Color(0xff2E3132),
              brightness: Brightness.dark,
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.white
                  )
              ),
              actionsIconTheme: IconThemeData(
                  color: Colors.white
              ),
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
            ),
          ),
          onGenerateRoute: Application.router.generator,
          home: AppLock(
            builder: (args) =>App(),
            lockScreen: LockPage(),
            enabled: SpUtil.getBool("appIsFirstStatus"),
          )
      ),
    );
  }
}
