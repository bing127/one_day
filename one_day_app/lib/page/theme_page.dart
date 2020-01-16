import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/provider/theme_provider.dart';
import 'package:one_day/utils/toast.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  List<Map<String,dynamic>> _listTheme = new List();
  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData(){
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    List<Map<String,dynamic>> data = [
      {
        "name":'Dark',
        "color":Color(0xff191919),
        "select":true,
      },{
        "name":'Light',
        "color":Color(0xffF0F0F0),
        "select":false
      },{
        "name":'Blue',
        "color":Color(0xff617FDF),
        "select":false
      },{
        "name":'Pink',
        "color":Color(0xffFD7897),
        "select":false
      }
    ];
    data.forEach((item){
      if(item['name'] == _theme.getStringTheme()){
        item['select'] = true;
      } else {
        item['select'] = false;
      }
    });
    _listTheme = data;
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "主题风格",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
      ),
      body: SafeArea(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: _listTheme.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(
                ScreenUtil().setWidth(30)
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: ScreenUtil().setWidth(1.5),
                crossAxisSpacing: ScreenUtil().setWidth(30),
                mainAxisSpacing: ScreenUtil().setWidth(30)
            ),
            itemBuilder: (BuildContext context,int index){
              return  _block(
                  title: _listTheme[index]["name"].toString(),
                  color: _listTheme[index]["color"],
                  select: _listTheme[index]["select"],
                  index:index
              );
            },
          )
      ),
    );
  }


  Widget _block({ String title,Color color,bool select:false,int index }){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white
          ),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
      ),
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
        child: Material(
          color: color,
          child: InkWell(
            onTap: (){
              _listTheme.forEach((item)=>item['select'] = false);
              _listTheme[index]['select'] = true;
              FlutterToast.show("已切换为`$title`");
              Provider.of<ThemeProvider>(context,listen: false).setTheme(title);
              setState(() {

              });
            },
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(30),
                            top: ScreenUtil().setWidth(30)
                        ),
                        height: ScreenUtil().setHeight(150),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3),
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(30),
                            top: ScreenUtil().setWidth(30)
                        ),
                        height: ScreenUtil().setHeight(80),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3),
                            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15))
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: ScreenUtil().setHeight(70),
                    color: select ? const Color(0xff4FA760) : const Color(0xff9E9F9D).withOpacity(.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        select ? Icon(
                          Icons.check,
                          size: ScreenUtil().setSp(35),
                          color: Colors.white,
                        ) : const SizedBox(),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          "$title",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(28)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
