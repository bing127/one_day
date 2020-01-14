import 'package:flutter/material.dart';

enum Themes {
  DARK, LIGHT, Blue, Pink
}

class ChangeTheme{
  static ThemeData darkTheme = ThemeData(
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
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    // 页面背景色
    scaffoldBackgroundColor: Color(0xffF0F0F0),
    // 主要用于Material背景色
    canvasColor: Color(0xffF0F0F0),
    primaryColor: Color(0xff4FA760),
    accentColor: Color(0xff4FA760),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black
        )
      ),
      brightness: Brightness.light,
      actionsIconTheme: IconThemeData(
        color: Colors.black
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
  );


  static ThemeData pinkTheme = ThemeData(
    brightness: Brightness.light,
    // 页面背景色
    scaffoldBackgroundColor: Color(0xffFD7897),
    // 主要用于Material背景色
    canvasColor: Color(0xffFD7897),
    primaryColor: Color(0xff4FA760),
    accentColor: Color(0xff4FA760),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Color(0xffFD7897),
      brightness: Brightness.light,
    ),
  );
  static ThemeData blueTheme = ThemeData(
    brightness: Brightness.dark,
    // 页面背景色
    scaffoldBackgroundColor: Color(0xff617FDF),
    // 主要用于Material背景色
    canvasColor: Color(0xff617FDF),
    primaryColor: Color(0xff4FA760),
    accentColor: Color(0xff4FA760),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Color(0xff617FDF),
      brightness: Brightness.dark,
    ),
  );

  static change(String theme){
    switch (theme) {
      case "Dark":
        return darkTheme;
        break;
      case "Light":
        return lightTheme;
        break;
      case "Blue":
        return blueTheme;
        break;
      case "Pink":
        return pinkTheme;
        break;
    }
  }

}