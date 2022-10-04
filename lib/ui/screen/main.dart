import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/ui/screen/home.dart';
import 'package:sky_vacation/ui/screen/notification.dart';
import 'package:sky_vacation/ui/screen/account.dart';
import 'package:sky_vacation/helper/localize.dart';
import '../../base/result.dart';
import '../../data/model/entity/notific_counter.dart';
import '../../di/injection_container.dart';
import '../../helper/app_color.dart';
import '../../helper/dim.dart';
import '../../main.dart';
import '../../helper/app_util.dart';
import '../bloc/home_notification_counter.dart';
import 'package:collection/collection.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ResumableState<MainScreen> {
  // List notificationList = [];
  // int notificationCount = 0;
  String currentPage = AppRoute.main;
  int currentTabIndex = 0;
  User? currentUser;
  Company? company;
  List<NotificationCounter> notificationCounters = [];
  bool isThereNotification = false;
  HomeNotificationCounterBloc homeNotificationCounterBloc =
      sl<HomeNotificationCounterBloc>();

  @override
  void initState() {
    initComponents();
    homeNotificationCounterBloc.mainStream.listen(_observeNotificationCounter);
    homeNotificationCounterBloc.get();
    // getNotificationsLength();
    super.initState();
  }

  @override
  void onResume() {
    appLog("Home onResume");

    super.onResume();
  }

  initComponents() {
    currentUser = sm.getUser();
    company = sm.getCompany();
  }

  @override
  void dispose() {
    homeNotificationCounterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Container(
          color: (currentTabIndex == 1) ? AppColor.bkg:AppColor.bkgGray,
          height: MediaQuery.of(context).size.height,
          child: Container(
              child: (currentPage == AppRoute.main)
                  ? HomeScreen(
                      holidayCounter: parseNotificationCounter("HoldeyReq"),
                      excuseCounter: parseNotificationCounter("ExcuseReq"),
                      navigateToProfile: () => setState(() {
                            currentPage = AppRoute.userInfo;
                          }))
                  : (currentPage == AppRoute.notifications)
                      ? NotificationScreen()
                      : AccountScreen(
                          currentUser: currentUser,
                        )),
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
            icon: Image.asset(
              AppAsset.home,
              width: Dim.w5,
              height: Dim.w5,
              color:
                  (currentTabIndex == 0) ? AppColor.accentDark : AppColor.white,
            ),
            label: Trans.of(context).t("homeText"),
          ),
          BottomNavigationBarItem(
            icon: notificationIcon(
                Icons.notifications,
                parseNotificationCounter("EmployeeLogs") < 9
                    ? parseNotificationCounter("EmployeeLogs").toString()
                    : "9+"),
            label: Trans.of(context).t("notificationsIconText"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAsset.profile,
              width: Dim.w5,
              height: Dim.w5,
              color:
                  (currentTabIndex == 2) ? AppColor.accentDark : AppColor.white,
            ),
            label: Trans.of(context).t("homeProfile"),
          ),
        ],
      ),
    );
  }

  Widget floatButton() {
    return SpeedDial(
      backgroundColor: AppColor.primary,
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
          color: AppColor.white,
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
                backgroundColor: AppColor.primary,
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.white,
                ),
                label: Trans.of(context).t("saleOrderText"),
                labelStyle: TS.medBlack10,
                onTap: () {
                  // Get.toNamed(AppStrings.addSaleOrderScreenId);
                })
            : SpeedDialChild(
                backgroundColor: Colors.transparent, child: Center()),
        SpeedDialChild(
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.calendar_today,
              color: AppColor.white,
            ),
            label: Trans.of(context).t("vacationTypeRadioButton"),
            labelStyle: TS.medBlack10,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.vacationTypeRadioButton);
            }),
        SpeedDialChild(
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.work,
              color: AppColor.white,
            ),
            label: Trans.of(context).t("workOutDoorTypeRadioButton"),
            labelStyle: TS.medBlack10,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.workOutDoorTypeRadioButton);
            }),
        SpeedDialChild(
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.access_time,
              color: AppColor.white,
            ),
            label: Trans.of(context).t("excuseTypeRadioButton"),
            labelStyle: TS.medBlack10,
            onTap: () {
              // Get.toNamed(AppStrings.vacationRequestScreenId,
              //     arguments: AppStrings.excuseTypeRadioButton);
            }),
      ],
    );
  }

  Widget notificationIcon(IconData icon, String text) {
    return Stack(
      children: [
        Icon(
          icon,
          color: (currentTabIndex == 1)
              ? AppColor.accentDark
              : AppColor.white,
          size: Dim.w6,
        ),
        parseNotificationCounter("EmployeeLogs") > 0
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: AppColor.red,
                    ),
                    margin: EdgeInsets.all(0),
                    width: Dim.w4,
                    height: Dim.w4,
                    child: Center(
                        child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ))),
              )
            : SizedBox(),
      ],
    );
  }

  //--------
  getNotificationsLength() async {
    // appLog("notificationList");
    // int userId = sm.getUser()?.usId ?? 0;
    // String token = sm.getValue(UserConstant.accessToken);
    // var result = await get(
    //     Uri.parse(
    //         "${sm.getCompany()?.Url}${Urls.getHomeCounters}/$userId?lang=$currentLocale"),
    //     headers: {'Authorization': 'Bearer $token'});
    // notificationList = jsonDecode(result.body)["result"]["response_data"];
    // appLog(notificationList.toString());
    // appLog("notificationList");
    // setState(() {
    //   notificationCount = int.parse(notificationList[0]["actionValue"]) +
    //       int.parse(notificationList[1]["actionValue"]) +
    //       int.parse(notificationList[2]["actionValue"]);
    //   isThereNotification = true;
    // });
  }

  void _observeNotificationCounter(Result<List<NotificationCounter>> result) {
    if (result is SuccessResult) {
      notificationCounters = result.getSuccessData() ?? [];
      setState(() {});
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {}
  }

  int parseNotificationCounter(String key) {
    try {
       NotificationCounter? counter= notificationCounters.firstWhereOrNull((element) => element.actionName == key) ;
      if (null != counter) {
        return int.tryParse(counter.actionValue ?? "0") ?? 0;
      } else {
        return 0;
      }
    } catch (_) {
      return 0;
    }
  }
}

// BorderRadius.all(Radius.circular(40))
