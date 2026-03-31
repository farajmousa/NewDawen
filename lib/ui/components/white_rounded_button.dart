import 'package:flutter/material.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/helper/font_style.dart';
import '../../helper/app_color.dart';
import 'package:dawim/helper/font_style.dart';
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
            color: AppColor.white,
            style: BorderStyle.solid,
            width: 3.0
          )
        ),
        color: AppColor.white,
        textColor: AppColor.accentDark,
        disabledColor: AppColor.gray,
        disabledTextColor: AppColor.text,
        padding: EdgeInsets.all(8.0),

        minWidth: double.infinity,
        height: 55.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: (loading  ?? false) ? Loading(loading: loading!,loadingColor: AppColor.primary,loadingAlignment: Alignment.centerLeft,):Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(
                  icon,
                  color: AppColor.primary,
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
