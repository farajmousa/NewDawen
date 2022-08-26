import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/ui/screen/home.dart';
import 'package:sky_vacation/ui/screen/notification.dart';
import 'package:sky_vacation/ui/screen/account.dart';
import 'package:sky_vacation/helper/localize.dart';
import '../../data/api/api_method.dart';
import '../../data/api/api_urls.dart';
import '../../data/model/entity/notification_data.dart';
import '../../helper/app_color.dart';
import '../../helper/user_constant.dart';
import '../../main.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ResumableState<MainScreen> {
  List notificationList = [];
  int notificationCount = 0;
  String currentPage = AppRoute.main;
  int currentTabIndex = 0;
  User? currentUser;
  Company? company;
  bool isThereNotification = false;

  @override
  void initState() {
    initComponents();
    getNotificationsLength();
    super.initState();
  }

  @override
  void onResume() {
    print("Home onResume");

    super.onResume();
  }

  initComponents() {
    currentUser = sm.getUser();
    company = sm.getCompany();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Container(
          color: AppColor.whiteColor,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: currentPage == AppRoute.main
                    ? HomeScreen(
                        notificationList,
                        isThereNotification,
                        () => setState(() {
                              currentPage = AppRoute.userInfo;
                            }) , getNotificationsLength)
                    : currentPage == AppRoute.notifications
                        ? NotificationScreen()
                        : AccountScreen(
                            currentUser: currentUser,
                          )),
          ),
        ),
      ),
      // ),
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: Container(
          // margin: EdgeInsets.symmetric(horizontal: Dim.w5),
          child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.primary,
        selectedItemColor: AppColor.accentDark,
        unselectedItemColor: AppColor.white,
        currentIndex: currentTabIndex,
        onTap: (index) {
          currentTabIndex = index;
          if (index == 0) {
            setState(() {
              currentPage = AppRoute.main;
            });
          } else if (index == 1) {
            setState(() {
              currentPage = AppRoute.notifications;
            });
          } else if (index == 2) {
            setState(() {
              currentPage = AppRoute.userInfo;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Trans.of(context).t("homeText"),
          ),
          BottomNavigationBarItem(
            icon: notificationIcon(Icons.notifications,
                notificationCount < 9 ? notificationCount.toString() : "9+"),
            label: Trans.of(context).t("notificationsIconText"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 24,
            ),
            label: Trans.of(context).t("personIconText"),
          ),
        ],
      )),
    );
  }

  Widget floatButton() {
    return SpeedDial(
      backgroundColor: AppColor.primaryColor,
      childMargin: EdgeInsets.fromLTRB(
          0, 0, MediaQuery.of(context).size.width * 0.475, 50),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3.0, color: Colors.white),
        ),
        child: Icon(
          Icons.add,
          size: 28.0,
          color: AppColor.whiteColor,
        ),
      ),
      closeManually: false,
      curve: Curves.bounceInOut,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        (null != company && (company?.CompCode ?? "").startsWith("2"))
            ? SpeedDialChild(
                backgroundColor: AppColor.primaryColor,
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.whiteColor,
                ),
                label: Trans.of(context).t("saleOrderText"),
                labelStyle: TS.cardText,
                onTap: () {
                  // Get.toNamed(AppStrings.addSaleOrderScreenId);
                })
            : SpeedDialChild(
                backgroundColor: Colors.transparent, child: Center()),
        SpeedDialChild(
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              Icons.calendar_today,
              color: AppColor.whiteColor,
            ),
            label: Trans.of(context).t("vacationTypeRadioButton"),
            labelStyle: TS.cardText,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.vacationTypeRadioButton);
            }),
        SpeedDialChild(
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              Icons.work,
              color: AppColor.whiteColor,
            ),
            label: Trans.of(context).t("workOutDoorTypeRadioButton"),
            labelStyle: TS.cardText,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.workOutDoorTypeRadioButton);
            }),
        SpeedDialChild(
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              Icons.access_time,
              color: AppColor.whiteColor,
            ),
            label: Trans.of(context).t("excuseTypeRadioButton"),
            labelStyle: TS.cardText,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.excuseTypeRadioButton);
            }),
      ],
    );
  }

  getNotificationsLength() async {
    print("notificationList");
    int userId = sm.getUser()?.usId ?? 0;
    String token = sm.getValue(UserConstant.accessToken);
    var result = await get(
        Uri.parse(
            "${sm.getCompany()?.Url}${Urls.getHomeCounters}/$userId?lang=$currentLocale"),
        headers: {'Authorization': 'Bearer $token'});
    notificationList = jsonDecode(result.body)["result"]["response_data"];
    print(notificationList);
    print("notificationList");
    setState(() {
      notificationCount = int.parse(notificationList[0]["actionValue"]) +
          int.parse(notificationList[1]["actionValue"]) +
          int.parse(notificationList[2]["actionValue"]);
      isThereNotification = true;
    });
  }

  Widget notificationIcon(IconData icon, String text) {
    return Stack(
      children: [
        Icon(
          icon,
          color: AppColor.whiteColor,
        ),
        notificationCount > 0
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: AppColor.red,
                    ),
                    margin: EdgeInsets.all(0),
                    width: 15,
                    height: 15,
                    child: Center(
                        child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ))),
              )
            : SizedBox(),
      ],
    );
  }
}

// BorderRadius.all(Radius.circular(40))
