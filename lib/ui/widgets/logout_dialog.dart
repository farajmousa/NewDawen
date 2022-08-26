import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/separator.dart';
import 'header.dart';

void logoutDialog(BuildContext context, Function() logoutTapped) {

  double height = (SizerUtil.deviceType == DeviceType.mobile) ? Dim.h4 : Dim.h5;

  showDialog<bool>(
    context: context,
    builder: (context) {

      return StatefulBuilder(builder: (context, setState) {

        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: Dim.h40,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Dim.h4 * 2, vertical: Dim.marginV2),
              children: <Widget>[
                header(context, "logout"),
                Separator(),
                SizedBox(
                  height: Dim.h4,
                ),

                Text(Trans.of(context).t("logout_msg"), style: TS.medBlack10,),

                SizedBox(
                  height: Dim.h4,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        width: Dim.w24,
                        height: height,
                        titleSize: Dim.s7,
                        title: Trans.of(context).t("logout"),
                        onTap: logoutTapped,
                      ),
                      SizedBox(
                        width: Dim.w2,
                      ),
                      AppButton(
                        width: Dim.w24,
                        height: height,
                        titleSize: Dim.s7,
                        bkgColor: AppColor.red,
                        borderColor: AppColor.red,
                        title: Trans.of(context).t("cancel"),
                        onTap: () {
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
