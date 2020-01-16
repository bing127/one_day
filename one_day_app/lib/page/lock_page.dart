import 'dart:math' as math;

import 'package:flustars/flustars.dart' show SpUtil;
import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:one_day/utils/toast.dart';


class LockPage extends StatefulWidget {
  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> with SingleTickerProviderStateMixin{
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  Animation<double> _animation;
  int _milliseconds = 500;
  String _tips;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: _milliseconds), vsync: this);
    _curvedAnimation = new CurvedAnimation( parent: _animationController, curve: CustomCurve());
    _animation = new Tween(begin: -1.0, end: 1.0).animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


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
              child: _tips!= null ? AnimatedBuilder(
                animation: _animation,//添加动画
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(_animation.value,0),// 1,0 水平移动 -- 0,1垂直移动
                    child: Text(
                      "$_tips",
                      style: TextStyle(
                          color: Color(0xfff5222d),
                          fontSize: ScreenUtil().setSp(28)
                      ),
                    ),
                  );
                },
              ) : const SizedBox(),
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
    if(count >=3){
      return;
    }
    if(items.length <3){
      setState(() {
        _tips = "至少连接三项";
      });
      _animate();
      return;
    }
    String code = SpUtil.getString("appIsFirst");
    String regCode = items.join("");
    if(regCode == code){
      AppLock.of(context).didUnlock();
    } else {
      setState(() {
        count ++;
      });
      setState(() {
        _tips = "密码错误，还可尝试$count次";
      });
      _animate();
      if(count >=3){
        setState(() {
          _tips = null;
        });
        FlutterToast.show("跳转登录");
        print("close");
      }
    }
  }

  void _animate(){
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reset();
    }
    _animationController.forward();
  }

}

class CustomCurve extends Curve{
  const CustomCurve([this.period = 0.5]);//抖动频率
  final double period;

  @override
  double transformInternal(double t) {
    final double s = period / 2.0;
    t = (2.0 * t - 1.0) * -1;
    double d = -1 * math.pow(2.0, 3.0 * t) * math.sin((t - s) * (math.pi * 2.0) / period);
    return d;
  }
}
