import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:one_day/routers/fluro_navigator.dart';
import 'package:one_day/utils/toast.dart';
import 'package:flustars/flustars.dart' show SpUtil;

class SettingLockPage extends StatefulWidget {
  final String type;

  const SettingLockPage({
    Key key,
    this.type,
  }) : super(key : key);

  @override
  _SettingLockPageState createState() => _SettingLockPageState();
}

class _SettingLockPageState extends State<SettingLockPage> with SingleTickerProviderStateMixin {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  Animation<double> _animation;
  int _milliseconds = 500;
  String _firstPwd;
  String _secondPwd;
  String _tips;


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
      appBar: AppBar(
        backgroundColor: Color(0xff2E3132),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "手势密码",
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
      ),
      backgroundColor: Color(0xff2E3132),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(100),
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
                setState(() {
                  _tips = null;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  _analysisGesture(List<int> items){
    if(items.length <3){
      setState(() {
        _tips = "至少连接三项";
      });
      _animate();
      return;
    }
    String regCode = items.join("");
    if(_firstPwd == null){
     setState(() {
       _firstPwd = regCode;
       _tips = "再次确认";
     });
      _animate();
      return;
    }
    if(_secondPwd == null){
      setState(() {
        _secondPwd = regCode;
      });
      if(_secondPwd != _firstPwd){
        setState(() {
          _tips = "两次手势不一致";
        });
        _animate();
        return;
      }
    }

    FlutterToast.show(widget.type == '1' ? "设置成功" : "重置成功");

    SpUtil.putString("appIsFirst", regCode);
    SpUtil.putBool("appIsFirstStatus", true);
    Future.delayed(Duration(milliseconds: 500),(){
      NavigatorUtils.goBackWithParams(context,"success");
    });

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
