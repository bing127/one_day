import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_day/widget/custom_cell.dart';
import 'package:one_day/widget/custom_field.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _textTitleEditingController = new TextEditingController();
  final TextEditingController _textCategoryEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _textTitleEditingController.dispose();
    _textCategoryEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff2E3132),
      appBar: AppBar(
        backgroundColor: Color(0xff2E3132),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "编辑",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(35)
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            top: ScreenUtil().setWidth(30)
          ),
          children: <Widget>[
            _fieldContainer(
                title: "清单名称",
                child: CustomField(
                  key: const Key('accountNumber'),
                  controller: _textTitleEditingController,
                  maxLength: 10,
                  keyboardType:TextInputType.text,
                  hintText: "请输入清单名称",
                  maxLines: 1,
                  leadingPadding: 0,
                  border: "true",
                  bgColor: Colors.transparent,
                  textInputAction: TextInputAction.next,
                )
            ),
            _fieldContainer(
                title: "类别",
                child: CustomField(
                  bgColor: Colors.transparent,
                  key: const Key('accountNumber'),
                  controller: _textCategoryEditingController,
                  maxLength: 6,
                  keyboardType:TextInputType.text,
                  hintText: "请输入类别",
                  maxLines: 1,
                  leadingPadding: 0,
                  border: "true",
                  textInputAction: TextInputAction.next,
                )
            ),
            _fieldContainer(
                title: "配图",
                child: CustomCell(
                  title: "请选择配图",
                )
            ),
            _fieldContainer(
                title: "时间",
                child: CustomCell(
                  title: "请选择时间",
                )
            ),
          ],
        )
      ),
      bottomNavigationBar: _bottomBtn(),
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
          "确定",
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
}
