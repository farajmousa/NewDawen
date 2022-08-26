import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/components/sheet/change_language_sheet.dart';
import 'package:sky_vacation/ui/components/sheet/confirmation_msg_sheet.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_image.dart';
import '../../helper/app_color.dart';
import '../../helper/app_constant.dart';
import '../../helper/user_constant.dart';
import '../../main.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/msg_dialog.dart';
import '../widgets/warningDialog.dart';

class AccountScreen extends StatefulWidget {
  User? currentUser;

  AccountScreen({
    this.currentUser,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String logoutPassword = "";
  String? errorText;
  @override
  Widget build(BuildContext context) {
    print("widget.currentUser.Image: ${widget.currentUser?.image}");
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.h3),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dim.w4, vertical: Dim.w6),
          decoration: AppDecor.decoration(
              borderColor: AppColor.grayLight, borderRadius: Dim.w6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (widget.currentUser?.image != null)
                Container(
                  alignment: Alignment.center,
                  decoration: AppDecor.circleDecoration(borderColor: AppColor.grayLight, borderWidth: 1),
                  child:
                  AppImage(
                    img: "${widget.currentUser?.image}",
                    width: Dim.w30,
                    height: Dim.w30,
                    radius: Dim.w30,
                    placeholder: AppAsset.profile,
                  ),
                ),
              SizedBox(
                height: Dim.h2,
              ),
              row(Trans.of(context).t("name"), widget.currentUser?.name ?? ''),
              row(Trans.of(context).t("job"), widget.currentUser?.job ?? ''),
              row(Trans.of(context).t("management"),
                  widget.currentUser?.department ?? ''),
              if (widget.currentUser?.year != null)
                row(Trans.of(context).t("moneyYear"), widget.currentUser?.year ?? ''),
            ],
          ),
        ),
        SizedBox(height: Dim.h6,),
        AppButton(
          title: Trans.of(context).t("changeLang"),
          marginVertical: Dim.h1,
          onTap: () {
            changeLanguageSheet(context);
          },
        ),
        AppButton(
          title: Trans.of(context).t("logout"),
          marginVertical: Dim.h1,
          bkgColor: AppColor.red,
          onTap: () {
            msgConfirmSheet(context, Trans.of(context).t("logout_msg") , Trans.of(context).t("logOutInfo"),logOutFunc , onChanged , errorText);
          },
        ),
      ],
    );
  }

  Widget row(String title, String value) {
    return Container(
        margin: EdgeInsets.only(bottom: Dim.h_8),
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style: TS.medBlack12,
            ),
            SizedBox(
              width: Dim.w3,
            ),
            Text(
              '$value',
              style: TS.medGrayDark12,
            ),
          ],
        ));
  }

  onChanged(text) {
    print(errorText != null);
    if(errorText != null) {
      setState(() {
        errorText = null;
      });
    }
    logoutPassword = text ;
  }

  logOutFunc()async{
    print(logoutPassword);
    if(logoutPassword == ""){
      warningDialog(context , Trans.of(context).t("logOutWarning") );
      return ;
    }

    Uri url = Uri.parse("${sm.getCompany()!.Url}/Login/LogOut/${sm.getUser()?.usId}/$logoutPassword?lang=$currentLocale");
    Response response = await get(url, headers:  {'Authorization': 'Bearer ${sm.getValue(UserConstant.accessToken)}'});
      print(response.body);
      print("${sm.getCompany()!.Url}/Login/LogOut/${sm.getUser()?.usId}/$logoutPassword?lang=${currentLocale}");
    Map body = jsonDecode(response.body);
    if(int.parse(body["result"]["response_code"]) > 299){
      warningDialog(context , body["result"]["response_message"] );
      return ;
    }
    sm.deleteCompany();
    Phoenix.rebirth(context);
    Navigator.of(context).pop();
  }
}





