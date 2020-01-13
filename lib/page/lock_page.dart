import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:one_day/utils/toast.dart';


class LockPage extends StatefulWidget {
  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff2E3132),
      body: Center(
        child: GestureView(
          key: this.gestureStateKey,
          size: MediaQuery.of(context).size.width*0.8,
          circleRadius: ScreenUtil().setWidth(8),
          ringRadius: ScreenUtil().setWidth(65),
          lineWidth: ScreenUtil().setWidth(2),
          ringWidth: ScreenUtil().setWidth(2),
          selectColor: Color(0xff4FA760),
          immediatelyClear: true,
          onPanUp: (List<int> items) {
            _analysisGesture(items);
          },
          onPanDown: () {
            gestureStateKey.currentState.selectColor = Color(0xff4FA760);
          },
        ),
      ),
    );
  }

  _analysisGesture(List<int> items){
    if(items.length <3){
      Toast.show("至少连接三项");
      return;
    }

    String regCode = items.join("");
    print(regCode);
  }

}
