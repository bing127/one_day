import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/page/app_router.dart';
import 'package:one_day/routers/fluro_navigator.dart';
import 'package:one_day/routers/routers.dart';
import 'package:one_day/widget/custom_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textAccountEditingController;
  TextEditingController _textPwdEditingController;
  @override
  void initState() {
    _textAccountEditingController = new TextEditingController();
    _textPwdEditingController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textAccountEditingController.dispose();
    _textPwdEditingController.dispose();
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
          "邮箱登录",
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(100),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _fieldContainer(
                  title: "邮箱",
                  child: CustomField(
                    key: const Key('accountNumber'),
                    controller: _textAccountEditingController,
                    maxLength: 30,
                    keyboardType:TextInputType.emailAddress,
                    hintText: "请输入邮箱",
                    maxLines: 1,
                    leadingPadding: 0,
                    border: "true",
                    bgColor: Colors.transparent,
                    textInputAction: TextInputAction.next,
                  )
              ),
              _fieldContainer(
                  title: "密码",
                  child: CustomField(
                    key: const Key('accountNumber'),
                    controller: _textPwdEditingController,
                    maxLength: 20,
                    isPwd: true,
                    keyboardType:TextInputType.visiblePassword,
                    hintText: "请输入密码",
                    maxLines: 1,
                    leadingPadding: 0,
                    border: "true",
                    bgColor: Colors.transparent,
                    textInputAction: TextInputAction.done,
                  )
              ),
              Container(
                child:Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _btns(
                      "忘记密码",
                      tap: (){
                        NavigatorUtils.push(context, AppRouter.forgetPage);
                      }
                    ),
                    _btns(
                       "注册",
                        tap: (){
                          NavigatorUtils.push(context, AppRouter.registerPage);
                        }
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: _bottomBtn(),
    );
  }


  Widget _btns(String title,{ GestureTapCallback tap }){
    return Container(
      child: FlatButton(
        child: Text(
            "$title",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
        onPressed: tap,
      ),
    );
  }

  Widget _fieldContainer({String title,Widget child}){
    return Container(
      padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(30)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30),
                fontWeight: FontWeight.w500
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(100),
            child: child,
          )
        ],
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
          "登录",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
        color: Color(0xff4FA760),
        textColor: Colors.white,
        onPressed: (){
          NavigatorUtils.push(context, Routes.home,clearStack: true);
        },
      ),
    );
  }
}
