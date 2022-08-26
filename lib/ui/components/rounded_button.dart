
import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
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
        color: AppColor.whiteColor,
      ),
    ),
      Center(
        child:Text(
          '$text',
          style: TS.buttonTextStyle.copyWith(fontSize: this.fontSize ?? Dim.s13,fontWeight: FontWeight.bold),
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
        color: (null != backgroundColor)? backgroundColor: AppColor.buttonBackgroundColor,
        textColor: AppColor.whiteColor,
        disabledColor: AppColor.lightButtonBackgroundColor,
        disabledTextColor: AppColor.whiteColor,
        padding: EdgeInsets.all(8.0),
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
