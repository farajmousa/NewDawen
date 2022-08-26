import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/localize.dart';
import '../../helper/app_color.dart';

import '../../main.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final double? titleSize;
  final Color? titleColor;
  final Color? iconColor;
  final String? endImagePath;
  final String? startImagePath;
  final IconData? endIconPath;
  final IconData? startIconPath;
  final double? iconSize;
  final Function? onTap;
  final Function? onChanged;
  final double? width;
  final double? height;
  final double? margin;
  final bool? fillWidth;
  final double? paddingValue;
  final double? marginHorizontal;
  final double? marginVertical;
  final Color? bkgColor;
  final bool? showShadow;
  final BoxDecoration? decoration;
  final double? radius;
  final FontWeight? fontWight;
  final TextAlign? textAlign;
  final MainAxisAlignment? mainAlignment;
  final CrossAxisAlignment? crossAlignment;
  final bool? isTextUnderLine;
  final bool? isTextAllCaps;
  final Color? borderColor;
  final double? iconSpace;
  final bool isRequired;

  AppButton(
      {Key? key,
      this.title,
      this.endImagePath,
      this.startImagePath,
      this.startIconPath,
      this.endIconPath,
      this.iconSize,
      this.titleSize,
      this.titleColor,
      this.iconColor,
      this.width,
      this.height,
      this.margin,
      this.fillWidth,
      this.paddingValue,
      this.marginHorizontal,
      this.marginVertical,
      this.bkgColor,
      this.showShadow,
      this.decoration,
      this.onTap,
      this.onChanged,
      this.radius,
      this.fontWight,
      this.textAlign,
      this.mainAlignment,
      this.crossAlignment,
      this.isTextUnderLine,
      this.isTextAllCaps,
      this.borderColor,
      this.iconSpace,
      this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultHeight =
        (SizerUtil.deviceType == DeviceType.mobile) ? 6.0.h : 7.h;
    double _height = height ?? defaultHeight;
    double _radius = Dim.w2; //_height / 2;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal ?? 0,
          vertical: marginVertical ?? Dim.h2),
      child:
          Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? _radius)),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  if (null != this.onTap) this.onTap!();
                },
                child: Container(
                    constraints: BoxConstraints(
                        maxWidth: width ?? double.infinity, maxHeight: _height),
                    alignment: Alignment.center,
                    decoration: decoration ??
                        AppDecor.decoration(
                            isShadow: false,
                            borderRadius: radius ?? _radius,
                            bkgColor: bkgColor ?? AppColor.primary,
                            borderColor: borderColor),
                    child: Row(
                      mainAxisAlignment: mainAlignment ?? MainAxisAlignment.center,
                      crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.center, //(null == width)? CrossAxisAlignment.stretch:
                    children: [
                        if (null != startImagePath)
                          Image.asset(
                              startImagePath!,
                              width: iconSize ?? 2.0.h,
                              height: iconSize ?? 2.0.h,
                              fit: BoxFit.contain,
                              color: iconColor ?? AppColor.accent,
                            ),
                        if (null != startIconPath)
                           Icon(
                              startIconPath,
                              size: iconSize ?? 2.0.h,
                              color: iconColor ?? AppColor.accent,
                            ),
                        if (null != startIconPath || null != startImagePath)
                          SizedBox(
                              width: iconSpace ?? ((null != title) ? Dim.w1 : 0)),

                        if ((title ?? "").isNotEmpty)
                          RichText(
                            text:  TextSpan(
                              style: TS.textStyle(
                                  size: titleSize ?? Dim.s10,
                                  color: titleColor ?? Colors.white,
                                  weight: fontWight ?? FontWeight.bold,
                                  isUnderLine: isTextUnderLine ?? false),
                              children: <TextSpan>[
                                 TextSpan(
                                    text: (isTextAllCaps ?? false)
                                        ? (title ?? "").toUpperCase()
                                        : (title ?? "")),
                                if(isRequired) TextSpan(
                                    text: ' * ',
                                    style: TS.textStyle(
                                        weight: FontWeight.bold,
                                        color: AppColor.red,
                                        size: Dim.s10, isUnderLine: false)),
                              ],
                            ),
                          ),
                        if (null != endIconPath || null != endImagePath)
                          SizedBox(
                              width: iconSpace ?? ((null != title) ? Dim.w1 : 0)),

                        if (null != endImagePath)
                           Image.asset(
                              endImagePath!,
                              width: iconSize ?? 2.0.h,
                              height: iconSize ?? 2.0.h,
                              fit: BoxFit.contain,
                              color: iconColor ?? AppColor.accent,
                            ),

                        if (null != endIconPath)
                         Icon(
                              endIconPath,
                              size: iconSize ?? 2.0.h,
                              color: iconColor ?? AppColor.accent,
                            ),

                      ],
                    ))),
          )
    );
  }
}

Widget dateWidget(BuildContext context,  DateTime? selectedDate, Function(DateTime?) dateChanged, {String? title,}) {
  return InkWell(
    child: Container(
      decoration: AppDecor.decoration(borderColor: AppColor.grayMed),
      padding: EdgeInsets.symmetric(vertical: Dim.h1_5, horizontal: Dim.w4),
      margin: EdgeInsets.symmetric(vertical: Dim.h_5, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text((null != selectedDate)
                ? au.formatDateTime(selectedDate)
                : Trans.of(context).t(title?? "datePickerTimeHintText"),
              style: TS.medGrayDark10,
            ),
          ),
          Icon(
            Icons.date_range,
            color: AppColor.primaryColor,
          ),
        ],
      ),
    ),
    onTap: () {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(DateTime.now().year + 100),
          useRootNavigator: false,
          builder: (context, widget) {
            return Theme(
              data: ThemeData(
                  focusColor: AppColor.calenderSelectedColor,
                  brightness: Brightness.light,
                  backgroundColor: AppColor.whiteColor,
                  buttonColor: AppColor.primaryColor,
                  unselectedWidgetColor:
                  AppColor.calenderTodayColor,
                  dialogBackgroundColor: AppColor.whiteColor,
                  secondaryHeaderColor: AppColor.primaryColor),
              child: widget!,
            );
          },
          textDirection: TextDirection.rtl)
          .then((data) {
        print(data);
        dateChanged(data);
      }).catchError((error) {
      });
    },
  );
}
Widget timeWidget(BuildContext context,  TimeOfDay? selectedDate, Function(TimeOfDay?) dateChanged, {String? title,}) {
  return InkWell(
    child: Container(
      decoration: AppDecor.decoration(borderColor: AppColor.grayMed),
      padding: EdgeInsets.symmetric(vertical: Dim.h1_5, horizontal: Dim.w4),
      margin: EdgeInsets.symmetric(vertical: Dim.h_5, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text((null != selectedDate)
                ? au.formatTime(selectedDate)
                : Trans.of(context).t(title?? "datePickerTimeHintText"),
              style: TS.medGrayDark10,
            ),
          ),
          Icon(
            Icons.date_range,
            color: AppColor.primaryColor,
          ),
        ],
      ),
    ),
    onTap: () {
      showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          useRootNavigator: false,
          builder: (context, widget) {
            return Theme(
              data: ThemeData(
                  focusColor: AppColor.calenderSelectedColor,
                  brightness: Brightness.light,
                  backgroundColor: AppColor.whiteColor,
                  buttonColor: AppColor.primaryColor,
                  unselectedWidgetColor:
                  AppColor.calenderTodayColor,
                  dialogBackgroundColor: AppColor.whiteColor,
                  secondaryHeaderColor: AppColor.primaryColor),
              child: widget!,
            );
          },)
          .then((data) {
        print(data);
        dateChanged(data);
      }).catchError((error) {
      });
    },
  );
}