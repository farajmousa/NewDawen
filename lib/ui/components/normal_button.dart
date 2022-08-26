import 'dart:io';
import 'package:flutter/material.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/font_style.dart';
import '../../helper/dim.dart';
import 'loading.dart';


class NormalButton extends StatelessWidget {
  NormalButton(
      {required this.text,required  this.onPressed,required  this.disabled, this.loading = false});
  final String text;
  final Function()? onPressed;
  bool disabled;
  bool loading;
  List<Widget> bodyData(){
    return [
      Center(
        child:Text(
          '$text',
          style: TS.cardText.copyWith(color: AppColor.whiteColor,fontSize:Dim.fontSize14),
        ),

      ),
      Loading(loading: loading),];
  }
  @override
  Widget build(BuildContext context) {

    return Container(
       child: MaterialButton(
        color: AppColor.buttonBackgroundColor,
        textColor: AppColor.whiteColor,
        disabledColor: AppColor.lightButtonBackgroundColor,
        disabledTextColor: AppColor.whiteColor,
        padding: EdgeInsets.all(8.0),
        minWidth: double.infinity,
        height: 55.0,
        child: Stack(
          children:bodyData()
        ),
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
