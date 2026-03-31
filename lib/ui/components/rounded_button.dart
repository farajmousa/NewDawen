
import 'package:flutter/material.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'loading.dart';


class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.text, this.icon = null,required  this.onPressed,required  this.disabled,
        this.fontSize, this.loading = false, this.textDirection = TextDirection.ltr,  this.backgroundColor,
      this.verticalMargin});
  final String text;
  final Function()? onPressed;
  bool disabled;
  bool loading;
  IconData? icon;
  double? fontSize;
  TextDirection textDirection;
  Color? backgroundColor;
  double? verticalMargin;

  List<Widget> bodyData(){
    return [ icon == null ? Container(): Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Icon(
        icon,
        color: AppColor.white,
      ),
    ),
      Center(
        child:Text(
          text,
          style: TS.textStyle(size: this.fontSize ?? Dim.s12,
              weight: FontWeight.bold, color: AppColor.white),
        ),

      ),
      Loading(loading: loading),];
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: verticalMargin ?? Dim.h4),

      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: (null != backgroundColor)? backgroundColor: AppColor.accentDark,
        textColor: AppColor.white,
        disabledColor: AppColor.gray,
        disabledTextColor: AppColor.white,
        padding: EdgeInsets.all(Dim.w2),
        minWidth: double.infinity,
        height: Dim.h6,
        child: Stack(
          children: textDirection == TextDirection.rtl ? bodyData().reversed.toList() : bodyData()
        ),
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
