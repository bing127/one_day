import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/routers/fluro_navigator.dart';

class CustomDialogWidget extends StatefulWidget {

  final String title;
  final Widget child;
  final bool isMarkClose;
  final Color bgColor;
  final double width;

  const CustomDialogWidget({
    Key key,
    this.title,
    this.isMarkClose:true,
    this.child,
    this.bgColor:Colors.white,
    this.width
  }) : super(key : key);


  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return GestureDetector(
      child: Scaffold( //创建透明层
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        // 键盘弹出收起动画过渡
        body: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeInCubic,
            child: ScaleTransition(
              scale:_animationController,
              child: Container(
                width:widget.width!= null ? widget.width : ScreenUtil().setWidth(600),
                  child: PhysicalModel(
                      color: widget.bgColor,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
                      child: widget.child
                  ),
              ),
            )
        ),
      ),
      onTap: (){
        if(widget.isMarkClose){
          _animationController.reverse();
          NavigatorUtils.goBack(context);
        }
      },
    );
  }
  @override
  void initState() {
    _animationController = AnimationController(duration:Duration(milliseconds:200),vsync:this);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
