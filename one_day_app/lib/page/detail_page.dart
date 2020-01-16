import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatefulWidget {
  final String date;
  final String title;
  final String tag;
  final String thumbnail;

  const DetailPage({
    Key key,
    this.title,
    this.date,
    this.tag,
    this.thumbnail,
  }) : super(key : key);


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Material(
      color: Colors.transparent,
      child: Hero(
        tag: widget.title,
        child: Scaffold(
          backgroundColor: Color(0xff2E3132),
          appBar: AppBar(
            backgroundColor: Color(0xff2E3132),
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(35)
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(100)
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(500),
                    height: ScreenUtil().setHeight(680),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: ScreenUtil().setHeight(600),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
                          color: Colors.white
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          bottom: ScreenUtil().setWidth(30),
                          left: ScreenUtil().setWidth(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(15)
                            ),
                            child: Text(
                              "${widget.title}",
                              style: TextStyle(
                                  color: Color(0xff0C0C0C),
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
                                  color: Color(0xff757575),
                                  fontSize: ScreenUtil().setSp(30),
                                  decoration: TextDecoration.none
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                    child: Container(
                      width: ScreenUtil().setWidth(460),
                      height: ScreenUtil().setHeight(550),
                      padding: EdgeInsets.only(
                          bottom: ScreenUtil().setWidth(20),
                          left: ScreenUtil().setWidth(20)
                      ),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.thumbnail
                              )
                          )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "${_timeDiff(widget.date)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(80),
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
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: _bottomAction(),
        ),
      ),
    );
  }


  Widget _bottomAction(){
    return Container(
      height: ScreenUtil().setHeight(200),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _bottomActionItem(
            Icons.mode_edit
          ),
          _bottomActionItem(
              Icons.done
          ),
          _bottomActionItem(
              Icons.delete_outline
          )
        ],
      ),
    );
  }

  Widget _bottomActionItem(IconData icon){
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
        size: ScreenUtil().setSp(60),
      ),
      onPressed: (){},
    );
  }

  String _timeDiff(String begin){
    DateTime beginTime = DateTime.parse(begin);
    var _surplus = beginTime.difference(DateTime.now());
    return ((_surplus.inSeconds ~/ 3600) ~/ 24).toString();
  }
}
