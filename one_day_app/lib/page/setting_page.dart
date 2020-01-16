import 'package:flustars/flustars.dart' show SpUtil;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/page/app_router.dart';
import 'package:one_day/routers/fluro_navigator.dart';
import 'package:one_day/widget/custom_dialog.dart';
import 'package:one_day/widget/custom_panel.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isOpenNotice = false;
  bool _isOpenPwd = false;
  bool _isReset = false;

  @override
  void initState() {
    setState(() {
      _isOpenPwd = SpUtil.getBool("appIsFirstStatus");
      _isReset = SpUtil.getBool("appIsFirstStatus");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff191919),
      appBar: AppBar(
        backgroundColor: Color(0xff2E3132),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "设置",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              CustomPanel(
                title:"常规设置",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cell(
                      icon: Icons.sort_by_alpha,
                      title: "默认排序方式",
                      sub: "按创建日升序",
                      tap: (){}
                    ),
                    _cell(
                        icon: Icons.notification_important,
                        title: "到期提醒",
                        showArrow: false,
                        child: Container(
                          width: ScreenUtil().setWidth(200),
                          child: CupertinoSwitch(
                            activeColor: _isOpenNotice ? Color(0xff4FA760) : Colors.grey.withOpacity(0.6),
                            onChanged: (bool value) {
                            },
                            value: _isOpenNotice,
                          ),
                        ),
                        tap: (){
                          setState(() {
                            _isOpenNotice = !_isOpenNotice;
                          });
                        }
                    ),
                    _cell(
                        icon: Icons.lock,
                        title: "手势密码",
                        showArrow: false,
                        child: Container(
                          width: ScreenUtil().setWidth(200),
                          child: CupertinoSwitch(
                            activeColor: _isOpenPwd ? Color(0xff4FA760) : Colors.grey.withOpacity(0.6),
                            onChanged: (bool value) {
                            },
                            value: _isOpenPwd,
                          ),
                        ),
                        tap: (){
                          setState(() {
                            _isOpenPwd = !_isOpenPwd;
                          });
                          if(!_isOpenPwd){
                            SpUtil.putBool("appIsFirstStatus", false);
                            _isReset = false;
                          }
                          if(_isOpenPwd && !SpUtil.getBool("appIsFirstStatus")){
                            NavigatorUtils.pushResult(context, "${AppRouter.settingLockPage}?type=1",(Object obj){
                                setState(() {
                                  _isReset = true;
                                });
                            });
                          }
                        }
                    ),
                    _isReset ? _cell(
                        icon: Icons.lock,
                        title: "重置密码",
                        sub: "",
                        tap: (){
                          NavigatorUtils.pushResult(context, "${AppRouter.settingLockPage}?type=2",(Object obj){

                          });
                        }
                    ) : const SizedBox(),
                  ],
                ),
              ),
              CustomPanel(
                title:"关于",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cell(
                      icon: Icons.public,
                      title: "官方网址",
                      sub: ""
                    )
                  ],
                ),
              )
            ],
          )
      ),
      bottomNavigationBar: _bottomBtn(),
    );
  }


  Widget _cell({IconData icon, String title,Widget child,bool showArrow:true,String sub,GestureTapCallback tap }){
    return Container(
      child: Material(
        color: const Color(0xff2E3132),
        child: InkWell(
          onTap: tap,
          child: Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth( child!= null ? 0 : 20),
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30)
            ),
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          right: ScreenUtil().setWidth(30)
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: ScreenUtil().setSp(40),
                      ),
                    ),
                    Text(
                      "$title",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28)
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    child!= null ? child : Text(
                      "$sub",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28)
                      ),
                    ),
                    showArrow ? Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: ScreenUtil().setSp(50)
                    ): const SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(1)
      ),
    );
  }

  Widget _bottomBtn(){
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setWidth(30)
      ),
      height: ScreenUtil().setHeight(120),
      child: FlatButton(
        child: Text(
          "退出登录",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
        color: Color(0xff4FA760),
        textColor: Colors.white,
        onPressed: _quitLogin,
      ),
    );
  }

  void _quitLogin(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return CustomDialogWidget(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(60),
                      bottom: ScreenUtil().setHeight(60)
                  ),
                  child: Text(
                    "您确定要退出登录吗？",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(32)
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color(0xffE8EAF2),
                              width: ScreenUtil().setWidth(1)
                          )
                      )
                  ),
                  child: Row(
                    children: <Widget>[
                      _btns(
                        title: "取消",
                        color: Color(0xFF999999)
                      ),
                      Container(
                        height:ScreenUtil().setHeight(60),
                        width: ScreenUtil().setWidth(1),
                        color: Color(0xffE8EAF2),
                      ),
                      _btns(
                          title: "确定",
                         color: Color(0xff0F82FF),
                        tap: (){
                            NavigatorUtils.push(context, AppRouter.loginPage,clearStack: true);
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _btns({ String title,Color color,GestureTapCallback tap }){
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: tap,
          child: Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(100),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: ScreenUtil().setSp(32)
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

}
