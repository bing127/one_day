import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/page/app_router.dart';
import 'package:one_day/routers/fluro_navigator.dart';
import 'package:one_day/widget/custom_card.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin  {
  final _listKey = GlobalKey<AnimatedListState>();
  Map<String, dynamic> _map = {
    "data": [
      {
        "title": "除夕",
        "thumbnail": "http://pic1.win4000.com/wallpaper/2018-01-20/5a62db6226145.jpg",
        "tag": "生活",
        "date": "2020-01-24",
        "isBig": true
      },
      {
        "title": "春节",
        "thumbnail":"http://pic1.win4000.com/wallpaper/2017-12-26/5a41b83400716.jpg",
        "tag": "生活",
        "date": "2020-01-25"
      },
      {
        "title": "元宵节",
        "thumbnail": "http://pic1.win4000.com/wallpaper/2017-11-13/5a096bdc97771.jpg",
        "tag": "生活",
        "date": "2020-02-08"
      },
      {
        "title": "妇女节",
        "thumbnail":
        "http://pic1.win4000.com/wallpaper/2018-01-20/5a62db6226145.jpg",
        "tag": "生活",
        "date": "2020-03-08"
      },
      {
        "title": "地瓜生日",
        "thumbnail":
        "http://pic1.win4000.com/wallpaper/2018-01-20/5a62db6226145.jpg",
        "tag": "生活",
        "date": "2020-07-12"
      }
    ]
  };
  AnimationController animationController;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return WillPopScope(
      onWillPop: () async {
//        await BackToDesktop.backToDesktop();
        //important
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff2E3132),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff2E3132),
          title: Text(
            "OneDay",
            style: TextStyle(fontSize: ScreenUtil().setSp(35)),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.tune,
                size: ScreenUtil().setSp(40),
              ),
              onPressed: (){
                NavigatorUtils.push(context, AppRouter.settingPage);
              }
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: ScreenUtil().setSp(40),
                ),
                onPressed: (){
                  NavigatorUtils.push(context, AppRouter.addPage);
                }
            )
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
            key: _listKey,
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(30),
            ),
            physics: ClampingScrollPhysics(),
            itemCount: _map['data'].length,
            itemBuilder: (BuildContext context, int index) {
              final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController,curve: Interval((1 / _map['data'].length) * index, 1.0, curve: Curves.fastOutSlowIn)));
              animationController.forward();
              return CustomCard(
                title: _map['data'][index]['title'],
                thumbnail: _map['data'][index]['thumbnail'],
                tag: _map['data'][index]['tag'],
                date: _map['data'][index]['date'],
                isBig: _map['data'][index]['isBig']!= null ? _map['data'][index]['isBig'] : false,
                animation: animation,
                animationController: animationController,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
