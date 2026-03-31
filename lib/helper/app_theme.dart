import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      // accentColor: AppColor.accent,
      primaryColorDark: AppColor.secondary,
      hintColor: AppColor.grayMed,
      splashColor: Colors.white,
      cardColor: AppColor.bkgGray, //Colors.white,
      dialogBackgroundColor: AppColor.white, // AppColor.gray2c,
      // appBarTheme: AppBarTheme( backgroundColor: AppColor.primary),
      // bottomAppBarColor: AppColor.primary,
      bottomAppBarTheme: BottomAppBarThemeData(color: AppColor.primary),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColor.primary),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor:  AppColor.white, ),
      fontFamily: Const.fontName,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primary,
      // Set the system overlay style for all AppBars.
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:AppColor.primary, // Must match main() for consistency.
        statusBarIconBrightness: Brightness.dark,
      ),
      foregroundColor: AppColor.primary, // Example: Set the icon/text color.
    ),
      textTheme: TextTheme(
        displayLarge: TS.textStyle(size: Dim.s12, color: AppColor.text),
        displayMedium: TS.textStyle(size: Dim.s12, color: AppColor.text),
        displaySmall: TS.textStyle(size: Dim.s12, color: AppColor.text),
        headlineMedium: TS.textStyle(size: Dim.s12, color: AppColor.text),
        headlineSmall: TS.textStyle(size: Dim.s12, color: AppColor.text),
        titleLarge: TS.textStyle(size: Dim.s12, color: AppColor.text),
        titleMedium: TS.textStyle(size: Dim.s12, color: AppColor.text),
        titleSmall: TS.textStyle(size: Dim.s12, color: AppColor.text),
        bodyLarge: TS.textStyle(size: Dim.s12, color: AppColor.text),
        bodyMedium: TS.textStyle(size: Dim.s11, color: AppColor.text),
        bodySmall: TS.textStyle(size: Dim.s12, color: AppColor.text),
        labelLarge: TS.textStyle(size: Dim.s12, color: AppColor.text),
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