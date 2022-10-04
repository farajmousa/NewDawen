import 'package:flutter/material.dart';

import '../../helper/app_color.dart';
import '../../helper/dim.dart';
import '../../helper/font_style.dart';

Widget rowItem(String title, String value, {Color? titleCol, Color? valueCol}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: Dim.h_5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title :",
          style: TS.textStyle(color: titleCol ?? AppColor.text, size: Dim.s10, weight: FontWeight.w600),
        ),
        SizedBox(width: Dim.w2,),
        Expanded(child: Text(value,
          style: TS.textStyle(color: valueCol ?? AppColor.grayDark, size: Dim.s10, weight: FontWeight.w600),
        ))
      ],
    ),
  );
}