import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'header.dart';

void warningDialog(BuildContext context, String msg) {

  double height = (SizerUtil.deviceType == DeviceType.mobile) ? Dim.h4 : Dim.h5;

  showDialog<bool>(
    context: context,
    builder: (context) {

      return StatefulBuilder(builder: (context, setState) {

        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: Dim.h15,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Dim.h3 * 2, vertical: 0),
              children: <Widget>[
                header(context, "confirm_message"),
                Text("$msg", style: TS.medBlack10,),

                SizedBox(
                  height: Dim.h1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      width: Dim.w24,
                      height: height,
                      titleSize: Dim.s7,
                      title: Trans.of(context).t("agree"),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
