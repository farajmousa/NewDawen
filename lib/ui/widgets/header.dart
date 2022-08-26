import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:flutter/material.dart';

import 'separator.dart';


Column header(BuildContext context,String title, {String subTitle = "", bool topPadding = true}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if(topPadding)SizedBox(
        height: Dim.h2,
      ),
      Text(
        "${Trans.of(context).t('$title')} $subTitle",
        style: TS.boldPrimary8,
      ),

    ],
  );
}

Column headerLined(BuildContext context,String title, {double? vPadding, TextStyle? style,Color? separatorColor}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(
        height: (null != vPadding) ? Dim.h4 : Dim.h2,
      ),
      Text(
        "${Trans.of(context).t('$title')}",
        style: style ?? TS.boldBlack11,
      ),
      Separator(color: separatorColor,),
      SizedBox(
        height: vPadding?? Dim.h4,
      ),
    ],
  );
}
