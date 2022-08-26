import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:flutter/material.dart';


Widget backBar(Function() onBackTap,{Color? color}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
        child: Container(
          width: Dim.w15,
          height: Dim.h9,
          alignment: Alignment.bottomCenter,
          child: Icon(Icons.arrow_back_ios, color: color ?? AppColor.text, size: Dim.w5,),
        ),
        onTap: onBackTap,
      ),
    ],
  );
}

Widget backWhiteBarTitle(String title,Function() onBackTap){
  return Stack(
    children: [
      Positioned(bottom: 0,
        left: 0, right: 0,
        child: Text(
        "$title",
        style: TS.boldWhite13,textAlign: TextAlign.center,
      ),),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: Dim.w15,
              height: Dim.h9,
              alignment: Alignment.bottomCenter,
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: Dim.w5,),
            ),
            onTap: onBackTap,
          ),
        ],
      ),
    ],
  );
}


Widget backBlackBarTitle(String title,Function() onBackTap){
  return Stack(
    children: [
      Positioned(bottom: 0,
        left: 0, right: 0,
        child: Text(
          "$title",
          style: TS.boldBlack13,textAlign: TextAlign.center,
        ),),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: Dim.w15,
              height: Dim.h9,
              alignment: Alignment.bottomCenter,
              child: Icon(Icons.arrow_back_ios, color: Colors.black, size: Dim.w5,),
            ),
            onTap: onBackTap,
          ),
        ],
      ),
    ],
  );
}
Widget blackBarTitle(String title){
  return Container(
    height: Dim.h6,
    alignment: Alignment.center,
    child: Text(
      "$title",
      style: TS.boldBlack13,textAlign: TextAlign.center,
    ),
  );
}


