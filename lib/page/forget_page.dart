import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/widget/custom_field.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController _textAccountEditingController;
  TextEditingController _textPwdEditingController;
  TextEditingController _textAgainPwdEditingController;
  @override
  void initState() {
    _textAccountEditingController = new TextEditingController();
    _textPwdEditingController = new TextEditingController();
    _textAgainPwdEditingController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textAccountEditingController.dispose();
    _textPwdEditingController.dispose();
    _textAgainPwdEditingController.dispose();
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
          "忘记密码",
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
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffE8EAF2),
                                  width: ScreenUtil().setWidth(1)
                              )
                          )
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            child: CustomField(
                              key: const Key('accountNumber'),
                              controller: _textAccountEditingController,
                              maxLength: 30,
                              keyboardType:TextInputType.emailAddress,
                              hintText: "请输入邮箱",
                              maxLines: 1,
                              leadingPadding: 0,
                              bgColor: Colors.transparent,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Material(
                            child: InkWell(
                              onTap: (){},
                              child: Container(
                                width: ScreenUtil().setWidth(150),
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "获取验证码",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                _fieldContainer(
                    title: "验证码",
                    child: CustomField(
                      key: const Key('accountNumber'),
                      controller: _textAgainPwdEditingController,
                      maxLength: 6,
                      keyboardType:TextInputType.number,
                      hintText: "请输入邮箱验证码",
                      maxLines: 1,
                      leadingPadding: 0,
                      border: "true",
                      bgColor: Colors.transparent,
                      textInputAction: TextInputAction.done,
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
              ],
            )
        ),
      ),
      bottomNavigationBar: _bottomBtn(),
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
          "注册",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
        color: Color(0xff4FA760),
        textColor: Colors.white,
        onPressed: (){},
      ),
    );
  }
}
