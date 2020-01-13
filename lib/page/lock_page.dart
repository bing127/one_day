import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "http://img3.duitang.com/uploads/item/201511/18/20151118235332_ZasGS.thumb.700_0.jpeg",
                    ),
                    radius: ScreenUtil().setWidth(90),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Text(
                    "张三",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(35),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(50)
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(50),
              child: Text(
                "密码错误,还可以输入两次",
                style: TextStyle(
                  color: Color(0xfff5222d),
                  fontSize: ScreenUtil().setSp(28)
                ),
              ),
            ),
            GestureView(
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
            )
          ],
        ),
      ),
    );
  }

  _analysisGesture(List<int> items){
    if(items.length <3){
      FlutterToast.show("至少连接三项");
    }
    String code = '01246';

    String regCode = items.join("");
    print(regCode);
    if(regCode == code){
      AppLock.of(context).didUnlock();
    }
  }

}
