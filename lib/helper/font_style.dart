import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_constant.dart';
import 'dim.dart';


class TS {

  static TextStyle textStyle({double? size, Color? color,
      FontWeight? weight, Color? bkgColor, double? height, bool isUnderLine = false, bool foreground = false, bool isLineThrough = false}) =>

      TextStyle(
        color: foreground ? null : color ?? AppColor.primary,
        backgroundColor: bkgColor ?? Colors.transparent,
        fontWeight:  weight ?? FontWeight.normal,
        fontSize: size ?? Dim.s11 ,
        fontFamily: Const.fontName,
        height: height ?? 1.5,
        decoration: isUnderLine ? TextDecoration.underline : isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: color ?? AppColor.primary,
        foreground: foreground ? (Paint()..shader = LinearGradient(
            colors: <Color>[AppColor.primary,AppColor.secondary],
          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))) : null,
      );



  static TextStyle boldPrimary16 = textStyle(size: Dim.s16, weight: FontWeight.bold);
  static TextStyle boldPrimary15 = textStyle(color: AppColor.primary, size: Dim.s15, weight: FontWeight.bold);
  static TextStyle boldPrimary13 = textStyle(color: AppColor.primary, size: Dim.s13, weight: FontWeight.bold);
  static TextStyle boldOrange16 = textStyle(color: AppColor.secondary, size: Dim.s16, weight: FontWeight.bold);

  static TextStyle boldPrimary11 = textStyle(size: Dim.s11, weight: FontWeight.bold);
  static TextStyle boldPrimary10 = textStyle(size: Dim.s10, weight: FontWeight.bold);
  static TextStyle boldPrimary9 = textStyle(size: Dim.s9, weight: FontWeight.bold);
  static TextStyle boldPrimary8 = textStyle(size: Dim.s8, weight: FontWeight.bold);
  static TextStyle boldBlack7 = textStyle(color: AppColor.text, size: Dim.s7, weight: FontWeight.bold);
  static TextStyle boldWhite7 = textStyle(color: AppColor.white, size: Dim.s7, weight: FontWeight.bold);
  static TextStyle boldWhite10 = textStyle(color: AppColor.white, size: Dim.s10, weight: FontWeight.bold);
  static TextStyle boldWhite11 = textStyle(color: AppColor.white, size: Dim.s11, weight: FontWeight.bold);
  static TextStyle boldWhite13 = textStyle(color: AppColor.white, size: Dim.s13, weight: FontWeight.bold);
  static TextStyle boldWhite16 = textStyle(color: AppColor.white, size: Dim.s16, weight: FontWeight.bold);
  static TextStyle boldRed8 = textStyle(color: AppColor.red,size: Dim.s8, weight: FontWeight.bold);
  static TextStyle boldRed10 = textStyle(color: AppColor.red,size: Dim.s10, weight: FontWeight.bold);
  static TextStyle boldRed14 = textStyle(color: AppColor.red,size: Dim.s14, weight: FontWeight.bold);
  static TextStyle boldGreen8 = textStyle(color: AppColor.green, size: Dim.s8, weight: FontWeight.bold);
  static TextStyle boldOrange8 = textStyle(color: AppColor.accent, size: Dim.s8, weight: FontWeight.bold);

  static TextStyle boldBlack8 = textStyle(color: AppColor.text, size: Dim.s8, weight: FontWeight.bold);
  static TextStyle boldBlack9 = textStyle(color: AppColor.text, size: Dim.s9, weight: FontWeight.bold);
  static TextStyle boldBlack10 = textStyle(color: AppColor.text, size: Dim.s10, weight: FontWeight.bold);
  static TextStyle boldBlack11 = textStyle(color: AppColor.text, size: Dim.s11, weight: FontWeight.bold);
  static TextStyle boldBlack12 = textStyle(color: AppColor.text, size: Dim.s12, weight: FontWeight.bold);
  static TextStyle boldBlack13 = textStyle(color: AppColor.text, size: Dim.s13, weight: FontWeight.bold);
  static TextStyle boldBlack15 = textStyle(color: AppColor.text, size: Dim.s15, weight: FontWeight.bold);
  static TextStyle boldBlack16 = textStyle(color: AppColor.text, size: Dim.s16, weight: FontWeight.bold);
  static TextStyle boldOrange12 = textStyle(color: AppColor.secondary, size: Dim.s12, weight: FontWeight.bold);
  static TextStyle boldOrange9 = textStyle(color: AppColor.secondary, size: Dim.s9, weight: FontWeight.bold);
  static TextStyle boldOrange11 = textStyle(color: AppColor.secondary, size: Dim.s11, weight: FontWeight.bold);
  static TextStyle boldAccent9 = textStyle(color: AppColor.accent, size: Dim.s9, weight: FontWeight.bold);
  static TextStyle boldGray10 = textStyle(color: AppColor.grayDark, size: Dim.s10, weight: FontWeight.bold);


  static TextStyle medBlack6 = textStyle(color: AppColor.text, size: Dim.s6, weight: FontWeight.w600);
  static TextStyle medBlack10 = textStyle(color: AppColor.text, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medBGray10 = textStyle(color: AppColor.grayDark, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medBlack12 = textStyle(color: AppColor.text, size: Dim.s12, weight: FontWeight.w600);
  static TextStyle medBlack13 = textStyle(color: AppColor.text, size: Dim.s13, weight: FontWeight.w600);
  static TextStyle medBlack8 = textStyle(color: AppColor.text, size: Dim.s8, weight: FontWeight.w600);
  static TextStyle medPrimary10 = textStyle(color: AppColor.primary, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medPrimary12 = textStyle(color: AppColor.primary, size: Dim.s12, weight: FontWeight.w600);
  static TextStyle medWhite12 = textStyle(color: AppColor.white, size: Dim.s12, weight: FontWeight.w600);
  static TextStyle medWhite10 = textStyle(color: AppColor.white, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medOrange10 = textStyle(color: AppColor.secondary, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medRed10 = textStyle(color: AppColor.red, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medRed8 = textStyle(color: AppColor.red, size: Dim.s8, weight: FontWeight.w600);

  static TextStyle medWhite8 = textStyle(color: AppColor.white, size: Dim.s8, weight: FontWeight.w600);
  static TextStyle medWhite8UnderLine = textStyle(color: AppColor.white, size: Dim.s8, weight: FontWeight.w600, isUnderLine: true);
  static TextStyle medOrange8UnderLine = textStyle(color: AppColor.accent, size: Dim.s8, weight: FontWeight.w600, isUnderLine: true);
  static TextStyle medGrayDark8 = textStyle(color: AppColor.grayDark, size: Dim.s8, weight: FontWeight.w600);
  static TextStyle medGrayDark10 = textStyle(color: AppColor.grayDark, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medGrayDark11 = textStyle(color: AppColor.grayDark, size: Dim.s11, weight: FontWeight.w600);
  static TextStyle medGrayDark12 = textStyle(color: AppColor.grayDark, size: Dim.s12, weight: FontWeight.w600);
  static TextStyle medGrayLight10 = textStyle(color: AppColor.grayLight, size: Dim.s10, weight: FontWeight.w600);
  static TextStyle medGrayLight8 = textStyle(color: AppColor.grayLight, size: Dim.s8, weight: FontWeight.w600);

  static TextStyle regularPrimary9 = textStyle(size: Dim.s9 );
  static TextStyle regularGray8 = textStyle(color: AppColor.grayDark, size: Dim.s8);
  static TextStyle regularOrange8 = textStyle(color: AppColor.accent, size: Dim.s8);
  static TextStyle regularGray6 = textStyle(color: AppColor.grayDark, size: Dim.s6);
  static TextStyle regularGray10 = textStyle(color: AppColor.grayDark, size: Dim.s10);
  static TextStyle regularGrayDark10 = textStyle(color: AppColor.grayDark2, size: Dim.s10, weight: FontWeight.w500);
  static TextStyle regularGrayLineThrough10 = textStyle(color: AppColor.grayDark, size: Dim.s10, isLineThrough: true);
  static TextStyle regularGrayLineThrough9 = textStyle(color: AppColor.grayDark, size: Dim.s9, isLineThrough: true, weight: FontWeight.w600);
  static TextStyle regularBlack6 = textStyle(color: AppColor.text, size: Dim.s6);
  static TextStyle regularWhite6 = textStyle(color: AppColor.white, size: Dim.s6);
  static TextStyle regularWhite8 = textStyle(color: AppColor.white, size: Dim.s8);
  static TextStyle regularBlack8 = textStyle(color: AppColor.text, size: Dim.s8);
  static TextStyle regularBlack10 = textStyle(color: AppColor.text, size: Dim.s10);
  static TextStyle regularRed8 = textStyle(color: AppColor.red, size: Dim.s8);
  static TextStyle regularRed6 = textStyle(color: AppColor.red, size: Dim.s6);

//------------
  static final titleTextStyle = TextStyle(
    fontSize:Dim.fontSize28,
    color: AppColor.blackColor,
    letterSpacing: 2.0,

  );
  static final kBodyPrimaryTextStyle =
  TextStyle(fontSize:Dim.fontSize16, color: AppColor.hintFormColor);
static final buttonTextStyle =
  TextStyle(fontSize:Dim.fontSize14, color: AppColor.whiteColor);

static final homeTextAppBar = TS.boldPrimary13 ;
  // TextStyle(fontSize:Dim.fontSize19, color: AppColor.waitingColor,fontFamily: "Bold");
static final cardText =
  TextStyle(fontSize:Dim.fontSize16, color: AppColor.primaryColor,fontFamily: "Bold");

static final vacationTypeTextStyle =
  TextStyle(fontSize:Dim.fontSize14, color: AppColor.vacationTypeTextColor,fontFamily: "Bold");



  static final kBodyLightTextStyle = TextStyle(
      fontFamily: "Bold",
      fontSize:Dim.fontSize16,
      color: AppColor.hintEditTextColor,
      decoration: TextDecoration.none);
}
