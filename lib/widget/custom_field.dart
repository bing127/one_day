import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
class CustomField extends StatefulWidget {
  CustomField({
    Key key,
    @required this.controller,
    this.maxLength: 50,
    this.autoFocus: false,
    this.border,
    this.maxLines : 1,
    this.focusNode,
    this.keyboardType: TextInputType.text,
    this.textInputAction:TextInputAction.done,
    this.textAlign: TextAlign.start,
    this.hintText: "",
    this.isPwd:false,
    this.lineBorder:true,
    this.enabled:true,
    this.leadingPadding:15,
    this.fontSize,
    this.change,
    this.submit,
    this.readOnly:false,
    this.bgColor:Colors.white,
    this.inputPadding: const EdgeInsets.only(
        top: 10,
        bottom: 10
    )
  }) : super(key: key);

  final TextEditingController controller;
  final String border;
  final String hintText;
  final TextInputType keyboardType;
  final bool autoFocus;
  final bool lineBorder;
  final double fontSize;
  final int maxLength;
  final int maxLines;
  final double leadingPadding;
  final FocusNode focusNode;
  final bool isPwd;
  final bool enabled;
  final bool readOnly;
  final TextInputAction textInputAction;
  final ValueChanged<String> change;
  final Color bgColor;
  final EdgeInsets inputPadding;
  final TextAlign textAlign;
  final ValueChanged<String> submit;

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      color: widget.bgColor,
      padding: EdgeInsets.only(
        left: widget.leadingPadding,
        top: ScreenUtil().setHeight(6),
        bottom: ScreenUtil().setHeight(6)
      ),
      child:Localizations(
      locale: const Locale("en", ""),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          autofocus: widget.autoFocus,
          obscureText:widget.isPwd,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          textAlign: widget.textAlign,
          cursorColor: Color(0xff4FA760),
          onChanged: widget.change,
          onSubmitted: widget.submit,
          readOnly: widget.readOnly,
          style: TextStyle(
            color: Color(0xff4FA760),
          ),
          inputFormatters: widget.isPwd ? [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))] : (
              (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))] : []
          ),
          decoration: InputDecoration(
              contentPadding: widget.inputPadding,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Color(0xffAAAAAA),
                fontSize: widget.fontSize!= null ? widget.fontSize : ScreenUtil().setSp(30)
              ),
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.border != null ? Color(0xff4FA760) : Colors.transparent,
                      width: ScreenUtil().setWidth(1)
                  )
              ),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.border != null ? Color(0xff4FA760) : Colors.transparent,
                      width: ScreenUtil().setWidth(1)
                  )
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.border != null ? Color(0xffE8EAF2) : Colors.transparent,
                      width: ScreenUtil().setWidth(1)
                  )
              )
          ),
        ),
      )
    );
  }
}