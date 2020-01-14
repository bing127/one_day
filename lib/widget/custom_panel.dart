import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPanel extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomPanel({ Key key,this.title,this.child });


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(30)
            ),
            child: Text(
              title,
              style: TextStyle(
                color: const Color(0xff494949),
                fontSize: ScreenUtil().setSp(28)
              ),
            ),
          ),
          Container(
            child: child!= null ? child : const SizedBox(),
          )
        ],
      ),
    );
  }
}
