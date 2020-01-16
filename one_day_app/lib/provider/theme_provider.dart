import 'package:flustars/flustars.dart' show SpUtil;
import 'package:flutter/material.dart';
import 'package:one_day/res/theme_config.dart';

class ThemeProvider extends ChangeNotifier {

  void setTheme(String theme) {
    SpUtil.putString("AppTheme", theme);
    notifyListeners();
  }

  getTheme() {
    String theme = SpUtil.getString("AppTheme");
    return ChangeTheme.change(theme);
  }

  getStringTheme(){
    return SpUtil.getString("AppTheme");
  }
}