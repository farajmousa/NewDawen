import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'loading.dart';


class WhiteRoundedButton extends StatelessWidget {
  WhiteRoundedButton(
      {this.text,this.icon, this.onPressed, this.disabled,this.loading});
  final String? text;
  final Function()? onPressed;
  bool? disabled;
  bool? loading;
  IconData? icon;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: Dim.h1),

      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: AppColor.whiteColor,
            style: BorderStyle.solid,
            width: 3.0
          )
        ),
        color: AppColor.whiteColor,
        textColor: AppColor.accentColor,
        disabledColor: AppColor.whiteDisabledColor,
        disabledTextColor: AppColor.accentDisabledColor,
        padding: EdgeInsets.all(8.0),

        minWidth: double.infinity,
        height: 55.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: (loading  ?? false) ? Loading(loading: loading!,loadingColor: AppColor.primaryColor,loadingAlignment: Alignment.centerLeft,):Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(
                  icon,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Text(
                  '$text',
                  style: TS.medPrimary10,
                ),
              ),
            )
          ]
        ),
        onPressed: (disabled ?? false) ? null : onPressed,
      ),
    );
  }
}
