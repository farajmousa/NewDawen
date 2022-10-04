import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/app_util.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/bloc/logout.dart';
import 'package:sky_vacation/ui/components/sheet/change_language_sheet.dart';
import 'package:sky_vacation/ui/components/sheet/confirmation_msg_sheet.dart';
import 'package:sky_vacation/ui/widgets/app_button.dart';
import 'package:sky_vacation/ui/widgets/app_image.dart';
import 'package:sky_vacation/ui/widgets/separator.dart';
import '../../base/result.dart';
import '../../di/injection_container.dart';
import '../../helper/app_color.dart';
import '../../helper/app_constant.dart';
import '../../helper/user_constant.dart';
import '../../main.dart';
import '../widgets/loading_indicator.dart';
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
  bool isLoading = false;

  LogoutBloc logoutBloc = sl<LogoutBloc>();

  refresh() {
    if (mounted) setState(() {});
  }

  loading(bool load) {
    isLoading = load;
    refresh();
  }

  @override
  void initState() {
    logoutBloc.mainStream.listen(_observeLogOut);

    super.initState();
  }

  @override
  void dispose() {
    logoutBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLog("widget.currentUser.Image: ${widget.currentUser?.image}");
    return Scaffold(
      backgroundColor: AppColor.bkgGray,
      appBar: comp.appBar(Trans.of(context).t("homeProfile"),
          backTapped: () {}, showBack: false),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: Dim.w6, vertical: 0),
          children: <Widget>[
            SizedBox(
              height: Dim.h3,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Dim.w6, vertical: Dim.w6),
              decoration: AppDecor.decoration(
                  bkgColor: AppColor.bkg, borderRadius: Dim.w4, ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      if (widget.currentUser?.image != null)
                        Container(
                          alignment: Alignment.center,
                          decoration: AppDecor.decoration(
                              bkgColor: AppColor.accentDark.withOpacity(0.1),
                              borderWidth: 1,
                              borderRadius: Dim.w3),
                          child: AppImage(
                            img: "${widget.currentUser?.image}",
                            width: Dim.w16,
                            height: Dim.w16,
                            placeholderSize: Dim.w8,
                            radius: Dim.w3,
                            placeholder: AppAsset.profile,
                            bkgColor: AppColor.primary,
                            placeHolderColor: AppColor.white,
                          ),
                        ),
                      SizedBox(width: Dim.w4,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( widget.currentUser?.name ?? '',
                            style: TS.medBlack12,),
                          // SizedBox(height: Dim.h_5,),
                          Text( sm.getCompany()?.CompName ?? '',
                            style: TS.regularGray10,)
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim.h3,
            ),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: Dim.w6, vertical: Dim.h3),
              decoration: AppDecor.decoration(
                bkgColor: AppColor.bkg, borderRadius: Dim.w4, ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  row(Trans.of(context).t("job"),
                      widget.currentUser?.job ?? ''),
                  Separator(
                    verticalMargin: Dim.h1_5,
                  ),
                  row(Trans.of(context).t("management"),
                      widget.currentUser?.department ?? ''),
                  if (widget.currentUser?.year != null)
                    row(Trans.of(context).t("moneyYear"),
                        widget.currentUser?.year ?? ''),
                ],
              ),
            ),
            if (isLoading)
              LoadingIndicator(
                fullScreen: false,
              ),
            SizedBox(
              height: Dim.h3,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Dim.w6, vertical: Dim.h2),
              decoration: AppDecor.decoration(
                  bkgColor: AppColor.bkg, borderRadius: Dim.w4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // AppButton(
                  //   title: Trans.of(context).t("change"),
                  //   marginVertical: Dim.h1,
                  //   onTap: () {
                  //     changeLanguageSheet(context);
                  //   },
                  // ),
                  InkWell(
                    onTap: () {
                      changeLanguageSheet(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: Dim.h1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Trans.of(context).t("app_language"),
                            style: TS.medBlack10,
                          ),
                          Text(
                            (currentLocale == AppLocale.AR)
                                ? "العربية"
                                : "English",
                            style: TS.medOrange10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Separator(
                    verticalMargin: Dim.h1_5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: Dim.h1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Trans.of(context).t("app_version"),
                          style: TS.medBlack10,
                        ),
                        Text(
                          '$appVersion',
                          style: TS.medGrayDark10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              title: Trans.of(context).t("logout"),
              radius: Dim.w4,
              height: Dim.h7,
              titleSize: Dim.s12,
              marginVertical: Dim.h3,
              bkgColor: AppColor.red,
              onTap: () {
                if (!isLoading) {
                  msgConfirmSheet(context, Trans.of(context).t("logout_msg"),
                      Trans.of(context).t("logOutInfo"), () {
                    logoutBloc.logout(logoutPassword);
                    //http://faragmosa-001-site8.itempurl.com/api/Login/LogOut/1/1234566?lang=en?lang=en
                    // logOutFunc();
                  }, onChanged, errorText);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget row(String title, String value) {
    return Container(
        margin: EdgeInsets.only(bottom: Dim.h_8),
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style: TS.medBlack10,
            ),
            SizedBox(
              width: Dim.w3,
            ),
            Text(
              '$value',
              style: TS.medGrayDark10,
            ),
          ],
        ));
  }

  onChanged(text) {
    if (errorText != null) {
      setState(() {
        errorText = null;
      });
    }
    logoutPassword = text;
  }

  void _observeLogOut(Result<bool> result) {
    loading(false);
    if (result is SuccessResult) {
      comp.displayToast(context, Trans.of(context).t("done_success"));

      sm.deleteCompany();
      Phoenix.rebirth(context);
    } else if (result is ErrorResult) {
      comp.handleApiError(context,
          error: result.getErrorMessage(), img: AppAsset.failed);
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

  logOutFunc() async {
    appLog(logoutPassword);
    if (logoutPassword == "") {
      warningDialog(context, Trans.of(context).t("logOutWarning"));
      return;
    }

    Uri url = Uri.parse(
        "${sm.getCompany()!.Url}/Login/LogOut/${sm.getUser()?.usId}/$logoutPassword?lang=$currentLocale");
    Response response = await get(url, headers: {
      'Authorization': 'Bearer ${sm.getValue(UserConstant.accessToken)}'
    });
    appLog(response.body);
    appLog(
        "${sm.getCompany()!.Url}/Login/LogOut/${sm.getUser()?.usId}/$logoutPassword?lang=${currentLocale}");
    Map body = jsonDecode(response.body);
    if (int.parse(body["result"]["response_code"]) > 299) {
      warningDialog(context, body["result"]["response_message"]);
      return;
    }
    sm.deleteCompany();
    Phoenix.rebirth(context);
    Navigator.of(context).pop();
  }
}
