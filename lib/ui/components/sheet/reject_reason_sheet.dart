import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_text_field.dart';
import 'package:sky_vacation/ui/widgets/header.dart';



void rejectReasonSheet(BuildContext context, Function(String) sendTapped) {

   TextEditingController _controller = TextEditingController();
  Widget content  = Container(
    height: Dim.h80,
    child:
      ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Dim.w8, vertical: Dim.marginV2),
        children: <Widget>[
          headerLined(context, "reject_reason", vPadding: 0),

          AppTextField(
            fillColor: AppColor.white,
            paddingVertical: Dim.h1_5,
            isRequired: true,
            hint: "${Trans.of(context).t("insert_reason")}",
            inputType: TextInputType.text,
            controller: _controller,
          ),
          SizedBox(
            height: Dim.h6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                width: Dim.w35,
                height: Dim.sheetBtnHeight,
                titleSize: Dim.s8,
                title: Trans.of(context).t("send"),
                titleColor: AppColor.white,
                onTap: () {
                  sendTapped(_controller.text);
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: Dim.w2,
              ),
              AppButton(
                width: Dim.w35,
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
      ),
  );


  showModalBottomSheet(
      context: context,
      shape: AppDecor.sheetShape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColor.bkgGray,
      isScrollControlled: true,
      builder: (context) => content).whenComplete(() {

  });

}
