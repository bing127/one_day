import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/page/app_router.dart';
import 'package:one_day/routers/fluro_navigator.dart';

class CustomCard extends StatefulWidget {
  final String date;
  final String title;
  final String tag;
  final String thumbnail;
  final double height;
  final bool isBig;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  const CustomCard({
    Key key,
    this.date,
    this.title,
    this.tag,
    this.height,
    this.thumbnail,
    this.isBig:false,
    this.animationController,
    this.animation,
  }) : super(key : key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return  AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(30)
              ),
              child: PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: widget.height!= null ? widget.height : ( widget.isBig ? ScreenUtil().setHeight(430) : ScreenUtil().setHeight(230) ),
                      padding: EdgeInsets.all(
                          ScreenUtil().setWidth(30)
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.thumbnail
                              )
                          )
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            NavigatorUtils.push(context, '${AppRouter.detailPage}?title=${ Uri.encodeComponent(widget.title)}&thumbnail=${ Uri.encodeComponent(widget.thumbnail)}&date=${Uri.encodeComponent(widget.date)}&tag=${Uri.encodeComponent(widget.tag)}',transition: TransitionType.fadeIn);
                          },
                          child: new Hero(
                              tag: widget.title,
                              child: Container(
                                color: Colors.black.withOpacity(.3),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(
                                    ScreenUtil().setWidth(30)
                                ),
                                child: widget.isBig ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "${_timeDiff(widget.date)}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(100),
                                              decoration: TextDecoration.none
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(15)
                                          ),
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: ScreenUtil().setWidth(190),
                                          child: ClipRRect(
                                            child: Container(
                                              child: Text(
                                                "天后",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(22),
                                                    decoration: TextDecoration.none
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              color: Color(0xff4FA760),
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil().setWidth(10),
                                                  right: ScreenUtil().setWidth(10),
                                                  top: ScreenUtil().setWidth(5),
                                                  bottom: ScreenUtil().setWidth(5)
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(15)
                                      ),
                                      child: Text(
                                        "${widget.title}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(40),
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(10)
                                      ),
                                      child: Text(
                                        "${widget.date}",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(.8),
                                            fontSize: ScreenUtil().setSp(30),
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    )
                                  ],
                                ) : Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "${widget.title}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(35),
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(15),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Container(
                                                child: Text(
                                                  "${widget.tag}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil().setSp(22),
                                                      decoration: TextDecoration.none
                                                  ),
                                                ),
                                                color: Colors.white.withOpacity(.3),
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil().setWidth(10),
                                                    right: ScreenUtil().setWidth(10),
                                                    top: ScreenUtil().setWidth(5),
                                                    bottom: ScreenUtil().setWidth(5)
                                                ),
                                              ),
                                              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                                            ),
                                            Container(
                                              child: Text(
                                                "${widget.date}",
                                                style: TextStyle(
                                                    color: Colors.white.withOpacity(.8),
                                                    fontSize: ScreenUtil().setSp(28),
                                                    decoration: TextDecoration.none
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil().setWidth(15)
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "${_timeDiff(widget.date)}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(50),
                                                decoration: TextDecoration.none
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(15)
                                          ),
                                        ),
                                        ClipRRect(
                                          child: Container(
                                            child: Text(
                                              "天后",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(22),
                                                  decoration: TextDecoration.none
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color(0xff4FA760),
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(10),
                                                right: ScreenUtil().setWidth(10),
                                                top: ScreenUtil().setWidth(5),
                                                bottom: ScreenUtil().setWidth(5)
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  String _timeDiff(String begin){
    DateTime beginTime = DateTime.parse(begin);
    var _surplus = beginTime.difference(DateTime.now());
    return ((_surplus.inSeconds ~/ 3600) ~/ 24).toString();
  }
}
