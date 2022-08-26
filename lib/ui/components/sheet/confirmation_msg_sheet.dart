import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import 'package:sky_vacation/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';



void msgConfirmSheet(BuildContext context, String msg, String info,  Function agreeTapped , Function(String text) onChanged , String? errorText) {

  Widget content  = Wrap(

    children: [
      ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: Dim.w8, vertical: Dim.marginV2),
        children: <Widget>[
          headerLined(context, "confirm_msg"),

          Text(
            "$msg",
            style: TS.medBlack10,
          ),
          SizedBox(
            height: Dim.h2,
          ),
          Text(
            info,
            style: TS.medBlack10,
          ),

          SizedBox(
            height: Dim.h2,
          ),
          AppTextField(
            errorText: errorText,
            onValueChanged:(value) => onChanged(value!),
          ),
          SizedBox(
            height: Dim.h30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(

                width: Dim.w32,
                bkgColor: AppColor.primary,
                height: Dim.sheetBtnHeight,
                titleSize: Dim.s8,
                title: Trans.of(context).t("agree"),
                titleColor: AppColor.white,
                onTap: (){
                  agreeTapped();

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


  showModalBottomSheet(
      context: context,
      shape: AppDecor.sheetShape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColor.bkg,
      isScrollControlled: true,
      builder: (context){
        return content;
      }).whenComplete(() {

  });

}
