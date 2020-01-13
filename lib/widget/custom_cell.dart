import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCell extends StatelessWidget {

  const CustomCell({
    Key key,
    this.title,
    this.showBorder:false,
    this.bindTap,
    }):super(key:key);

    final String title;
    final bool showBorder;
    final GestureTapCallback bindTap;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: bindTap,
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(showBorder ? 0xffE8EAF2 : 0xffffffff),
                          width: ScreenUtil().setWidth(1)
                      )
                  )
              ),
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(30)
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right,color:const Color(0xffBBC0C7),size: ScreenUtil().setSp(50),)
                ],
              )
          ),
        ),
      ),
      width: double.infinity,
    );
  }
}
