import 'package:flutter/material.dart';
import 'app_color.dart';
import 'dim.dart';

class AppDecor {
  static BoxDecoration tableDecoration = AppDecor.decoration(
      borderColor: AppColor.primary,
      isShadow: false,
      bkgColor: AppColor.primary.withOpacity(0.05));

  static RoundedRectangleBorder sheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(Dim.h4), topLeft: Radius.circular(Dim.h4)),
  );

  static BoxDecoration circleDecoration({
    Color? bkgColor,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
  }) =>
      BoxDecoration(
          color: bkgColor ?? Colors.transparent,
          shape: BoxShape.circle,
          border: (null != borderColor)
              ? Border.all(color: borderColor, width: borderWidth ?? 0)
              : null);

  static BoxDecoration roundedBottom({
    Color? bkgColor,
    double? borderRadius,
  }) =>
      BoxDecoration(
        color: bkgColor ?? AppColor.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius ?? Dim.radius2),
          bottomRight: Radius.circular(borderRadius ?? Dim.radius2),
        ),
      );

  static BoxDecoration roundedTop(
          {Color? bkgColor,
          double? borderRadius,
          Color? borderColor,
          double? borderWidth,
          bool isShadow = true,
          double? shadowOpacity = 0.2}) =>
      BoxDecoration(
        color: bkgColor ?? Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius ?? Dim.radius2),
          topLeft: Radius.circular(borderRadius ?? Dim.radius2),
        ),
        border: (null != borderColor)
            ? Border.all(color: borderColor, width: borderWidth ?? 0)
            : null,
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(shadowOpacity ?? 0.2),
                  spreadRadius: 1,
                  blurRadius: 3, //7
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]
            : null,
      );

  static BoxDecoration decoration(
          {Color? bkgColor,
          double? borderRadius,
          Color? borderColor,
          double? borderWidth,
          bool isShadow = false,
          double? shadowOpacity}) =>
      BoxDecoration(
        color: bkgColor ?? AppColor.white,
        borderRadius: BorderRadius.circular(borderRadius ?? Dim.h1),
        border: (null != borderColor)
            ? Border.all(color: borderColor, width: borderWidth ?? 1.4)
            : null,
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), //shadowOpacity ??
                  spreadRadius: shadowOpacity ?? 0.5,
                  blurRadius: 1, //1, //7
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ]
            : null,
      );

  final Shader linearGradient = LinearGradient(
    colors: <Color>[AppColor.primary, AppColor.secondary],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColor.primary.withOpacity(0.0),
        AppColor.primary.withOpacity(0.50),
        AppColor.primary.withOpacity(0.70),
        AppColor.primary.withOpacity(0.90),
        AppColor.primary
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.mirror,
    ),
  );

  static BoxDecoration gradientDecorationAccent = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColor.primary.withOpacity(0.0),
        AppColor.primary.withOpacity(0.10),
        AppColor.primary.withOpacity(0.40),
        AppColor.primary.withOpacity(0.60),
        AppColor.primary.withOpacity(0.90)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.mirror,
    ),
  );

  static BoxDecoration gradientTransparent = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColor.primary.withOpacity(0.20),
        AppColor.primary.withOpacity(0.30),
        AppColor.primary.withOpacity(0.60),
        AppColor.primary.withOpacity(0.70),
        AppColor.primary.withOpacity(1.0)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.mirror,
    ),
  );

  static BoxDecoration gradientBtn = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      // begin: Alignment.topCenter,
      // end: Alignment.bottomCenter,
      colors: <Color>[AppColor.accent, AppColor.primary],
    ),
  );
  static BoxDecoration dialogBkg = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.transparent,
        Colors.black.withOpacity(0.2),
        Colors.black.withOpacity(0.2),
        Colors.black.withOpacity(0.2),
        Colors.black.withOpacity(0.2),
        Colors.black.withOpacity(0.2),
        Colors.black.withOpacity(0.2),
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
//-----------------------------------------------------

}
