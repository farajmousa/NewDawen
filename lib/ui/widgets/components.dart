import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_constant.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_button.dart';
import 'app_svg.dart';

class Components {
  void handleApiError(BuildContext context, {String? error}) {
    try {
      if (null != error && error.isNotEmpty) {
        if (error == 'no_internet_connection') {
          displayDialogImage(
              context,
              Trans.of(context).t("no_internet_connection"),
              AppAsset.no_internet);
        } else {
          // displayDialog(
          //     context,
          //     (error == "codeBadRequest")
          //         ? Trans.of(context).t("codeBadRequest")
          //         : error);

          // showToastedd((error == "codeBadRequest")
          //     ? Trans.of(context).t("codeBadRequest")
          //     : error);

          showCustomToast(context , (error == "codeBadRequest")
              ? Trans.of(context).t("codeBadRequest")
              : error);
        }
      } else {
        displayDialog(context, Trans.of(context).t("codeBadRequest"));
      }
    } catch (e) {
      displayDialog(context, Trans.of(context).t("codeBadRequest"));
    }
  }

  void displayDialog(BuildContext context, String? msg) {
    showModalBottomSheet(
        context: context,
        shape: AppDecor.sheetShape,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: AppColor.bkg,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              // height: Dim.h80,
              decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              padding:
                  EdgeInsets.symmetric(horizontal: Dim.h3, vertical: Dim.h3),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: Dim.h2,
                // runSpacing: Dim.h4,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: SizedBox(
                          width: Dim.w10,
                          height: Dim.w10,
                          child: Icon(
                            Icons.close,
                            color: AppColor.red,
                            size: Dim.w6,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Dim.h1),
                    child: Text(
                      msg ?? "",
                      textAlign: TextAlign.center,
                      style: TS.textStyle(
                          size: Dim.s12,
                          color: AppColor.text,
                          weight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {});
  }

  void displayDialogImage(BuildContext context, String msg, String imagePath) {
    showModalBottomSheet(
        context: context,
        shape: AppDecor.sheetShape,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: AppColor.bkg,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Dim.h3, vertical: Dim.h3),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: Dim.h2,
                // runSpacing: Dim.h4,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: SizedBox(
                          width: Dim.w10,
                          height: Dim.w10,
                          child: Icon(
                            Icons.cancel,
                            color: AppColor.red,
                            size: Dim.w6,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Image.asset(
                      imagePath,
                      width: Dim.w50,
                      height: Dim.w40,
                    ),
                  ),
                  SizedBox(
                    height: Dim.h2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Dim.h1),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: TS.textStyle(
                          size: Dim.s12,
                          color: AppColor.text,
                          weight: FontWeight.w600),
                    ),
                  ),
                  AppButton(
                    title: Trans.of(context).t("retry"),
                    marginVertical: Dim.h2,
                    onTap: () {
                      Phoenix.rebirth(context);
                    },
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {});
  }

  void displayDialogSuccess(
      BuildContext context, String? msg, String? msg2, String imgPath) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (cont, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              height: Dim.h50 + Dim.h2,
              padding:
                  EdgeInsets.symmetric(horizontal: Dim.h3, vertical: Dim.h3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.cancel,
                          color: AppColor.red,
                          size: Dim.w6,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dim.h2,
                  ),
                  AppSVG(
                    name: imgPath,
                    width: Dim.h15,
                    height: Dim.h15,
                  ),
                  SizedBox(
                    height: Dim.h1,
                  ),
                  Text(
                    msg ?? "",
                    textAlign: TextAlign.center,
                    style: TS.boldBlack16,
                  ),
                  SizedBox(
                    height: Dim.h1,
                  ),
                  Text(
                    msg2 ?? "",
                    textAlign: TextAlign.center,
                    style: TS.medGrayDark10,
                  ),
                  SizedBox(
                    height: Dim.h3,
                  ),
                  Center(
                    child: AppButton(
                      width: Dim.w35,
                      height: Dim.h5,
                      radius: Dim.w1,
                      bkgColor: AppColor.primaryBkg,
                      title: Trans.of(context).t("ok"),
                      titleColor: AppColor.primary,
                      marginVertical: 0,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  displayToast(BuildContext context, String message,
      {double? size, int? duration, Color? bkgColor, Positioned? positioned}) {
    showToast(
      "$message",
      context: context,
    );
  }

  // void showToasted() => Fluttertoast.showToast(
  //     msg: "login success",  gravity: ToastGravity.TOP);

  Widget flippedWidget(BuildContext context, Widget widget) {
    String locale = Localizations.localeOf(context).languageCode;

    return (locale == AppLocale.AR)
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: widget,
          )
        : widget;
  }

  PreferredSize appBar(String title, {bool? showBack, Function()? backTapped}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Dim.h8),
      // here the desired height
      child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: (showBack ?? true)
              ? IconButton(
                  padding: EdgeInsets.all(Dim.w3),
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  iconSize: Dim.w5,
                  onPressed: backTapped,
                )
              : Center(),
          actions: [
            // Builder(
            //   builder: (context) => Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //
            //   ],)
            // ),
          ],
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TS.boldPrimary11,
          )
          // Text("title", textAlign: TextAlign.ce,
          ),
    );
  }

  Widget appBarText(String title) {
    return Text(
      "$title",
      style: TS.medWhite8,
    );
  }

  Widget notFoundWidget(BuildContext context, {double marginTop = 0}) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dim.h10,
            ),

            Image.asset(AppAsset.noResults), //noResults
            SizedBox(
              height: Dim.h4,
            ),
            Text(
              Trans.of(context).t("codeNotFound"),
              style: TS.medGrayDark12,
            ),
          ],
        ),
      ),
    );
  }

  void showToastedd(String msg) => Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_LONG,
      );

  // FToast? fToast;
  showCustomToast(BuildContext context, String msg) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Text(msg,style:  TextStyle(fontSize: 18),),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 15),
      gravity: ToastGravity.TOP
    );
  }
}
