import 'package:flutter/material.dart';
import 'package:one_day/model/user_model.dart';

class UserProvider with ChangeNotifier{
  UserModel user;

  set userInfo(UserModel params){
    user = params;
  }

  UserModel get userInfo => user;


  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refresh() async {
    notifyListeners();
  }

}