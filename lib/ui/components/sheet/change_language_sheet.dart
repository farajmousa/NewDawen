import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/header.dart';
import 'package:flutter/material.dart';

import '../../../helper/user_constant.dart';




void changeLanguageSheet(BuildContext context) {

  String lang = currentLocale ;
  showModalBottomSheet(
      context: context,
      shape: AppDecor.sheetShape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColor.bkg,
      isScrollControlled: true,
      builder: (context){
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {


          return Wrap(
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: Dim.w8, vertical: Dim.marginV2),
                children: <Widget>[
                  headerLined(context, "language"),

                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColor.accent,
                    title: Text(
                      "English",
                      style: TS.medBlack10,
                    ),
                    groupValue: lang,
                    value: "en",
                    onChanged: (String? val){
                      setState(() {
                        lang = val ?? "";
                      });
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColor.accent,
                    title: Text(
                      "العربية",
                      style: TS.medBlack10,
                    ),
                    groupValue: lang,
                    value: "ar",
                    onChanged:  (String? val){
                      setState(() {
                        lang = val ?? "" ;
                      });
                    },
                  ),


                  SizedBox(
                    height: Dim.h6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        width: Dim.w32,
                        bkgColor: AppColor.primary,
                        height: Dim.sheetBtnHeight,
                        titleSize: Dim.s8,
                        title: Trans.of(context).t("save"),
                        titleColor: AppColor.white,
                        onTap: () {
                          sm.setValue(UserConstant.AppLang, lang);
                          Navigator.of(context).pop();
                          Phoenix.rebirth(context);
                        },
                      ),
                      SizedBox(
                        width: Dim.w2,
                      ),
                      AppButton(
                        width: Dim.w32,
                        height: Dim.sheetBtnHeight,
                        titleSize: Dim.s8,
                        bkgColor: AppColor.red,
                        borderColor: AppColor.red,
                        titleColor: AppColor.white,
                        title: Trans.of(context).t("cancel"),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        });

      }).whenComplete(() {
  });

}
