import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_constant.dart';
import 'dim.dart';
import 'font_style.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData appTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      primaryColor: AppColor.primary,
      accentColor: AppColor.accent,
      primaryColorDark: AppColor.secondary,
      hintColor: AppColor.grayMed,
      splashColor: Colors.white,
      backgroundColor: AppColor.bkgGray, //Colors.white,
      dialogBackgroundColor: AppColor.white, // AppColor.gray2c,
      appBarTheme: AppBarTheme( backgroundColor: AppColor.primary),
      bottomAppBarColor: AppColor.primary,
      bottomAppBarTheme: BottomAppBarTheme(color: AppColor.primary),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColor.primary),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor:  AppColor.white, ),
      fontFamily: Const.fontName,
      textTheme: TextTheme(
        headline1: TS.textStyle(size: Dim.s8, color: AppColor.text),
        headline2: TS.textStyle(size: Dim.s8, color: AppColor.text),
        headline3: TS.textStyle(size: Dim.s8, color: AppColor.text),
        headline4: TS.textStyle(size: Dim.s8, color: AppColor.text),
        headline5: TS.textStyle(size: Dim.s8, color: AppColor.text),
        headline6: TS.textStyle(size: Dim.s8, color: AppColor.text),
        subtitle1: TS.textStyle(size: Dim.s8, color: AppColor.text),
        subtitle2: TS.textStyle(size: Dim.s8, color: AppColor.text),
        bodyText1: TS.textStyle(size: Dim.s8, color: AppColor.text),
        bodyText2: TS.textStyle(size: Dim.s8, color: AppColor.text),
        caption: TS.textStyle(size: Dim.s8, color: AppColor.text),
        button: TS.textStyle(size: Dim.s8, color: AppColor.text),
      ).apply(
        bodyColor: AppColor.text,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: AppColor.primary,
          primaryContrastingColor: AppColor.primary,
          barBackgroundColor: AppColor.primary,
          scaffoldBackgroundColor: AppColor.primary,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
            TS.textStyle(size: Dim.s12),
            pickerTextStyle: TS.textStyle(color: AppColor.text, size: Dim.s18),
          )));
}