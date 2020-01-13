import 'package:fluttertoast/fluttertoast.dart';

/// Toast工具类
class FlutterToast {
  static show(String msg, {duration = 2000}) {
    if (msg == null){
      return;
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        fontSize: 16.0
    );;
  }

  static cancelToast() {
    Fluttertoast.cancel();
  }
}
