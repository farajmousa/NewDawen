import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

import 'localize.dart';

class Const {
  static const String appName = "Dawim";
  static const String fontName = "OpenSans";

  static const String emailRegx =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String mobileCodeRegex = r'^[+][0-9]{1,6}$';
  static const String mobileRegex = r'^[0-9]{10,20}$';

  static DateFormat formatYMD = intl.DateFormat('yyyy-MM-dd');
  static DateFormat formatDMY = intl.DateFormat('dd/MM/yyyy');


  static const String oneSignalAppId = "10061170-611a-4764-9149-550b481ae906" ;
  static const String mapApiKey = "AIzaSyCjwo6StGEIFhDxttOUVC1lWaP7G6Nfu9w" ;
  static const String cartContent = "CartContent.txt" ;

  List<String> paymentStatusList = [
    "000.000.000",
    "000.200.100",
    "000.000.100",
    "000.100.110",
    "000.300.000",
    "000.600.000",
    "000.400.000",
    "000.100.110",
    "000.100.111",
    "000.100.112",
  ];


  //------------------------

  /// ROUTE NAMES
  static final String splashId = "/splashId";
  static final String companyScreenId = "/company-screen";
  static final String loginScreenId = "/login-screen";
  static final String homeScreenId = "/home-screen";
  static final String vacationRequestScreenId = "/vacation-request-screen";
  static final String checkInOutScreenId = "/check-in-out-screen";
  static final String checkInOutReportScreenId = "/check-in-out-report-screen";
  static final String salaryScreenId = "/salary-screen";
  static final String acceptScreenId = "/accept-screen";
  static final String vacationsScreenId = "/vacations-screen";
  static final String outDoorWorkScreenId = "/outdoor-work-screen";
  static final String excuseScreenId = "/excuse-screen";
  static final String leaveMoreInfoScreenId = "/leave-more-info-screen";
  static final String acceptMoreInfoScreenId = "/accept-more-info-screen";
  static final String accountStatementScreenId = "/account-statement-screen";
  static final String saleOrderScreenId = "/sale-order-screen";
  static final String addSaleOrderScreenId = "/add-sale-order-screen";
  static final String homeText = "الرئيسة";
  static final String notificationText = "تنبيهات";
  static final String userInfoText = "حسابي";
  static final String vacationTypeRadioButton = "اجازة";
  static final String workOutDoorTypeRadioButton = "الماموريات";
  static final String excuseTypeRadioButton = "اذن";
  static final String outdoorTypeRadioButton = "مأمورية";
  static final String normalVacationTypeRadioButton = "اعتيادي";
  static final String excuseVacationTypeRadioButton = "عارضة";
  static final String illVacationTypeRadioButton = "مرضي";
  static final String holidays = "متابعه الاجازات";
  static final String outDoorWorkText = "متابعه الماموريات";
  static final String excuses = "الاذونات";
  static final String personIconText = "حسابي";

  static daysInArabic(BuildContext context) =>
      (Localizations.localeOf(context).languageCode == "en")
          ? {
        "Monday": "الاثنين",
        "Tuesday": "الثلاثاء",
        "Wednesday": "الاربعاء",
        "Thursday": "الخميس",
        "Friday": "الجمعة",
        "Saturday": "السبت",
        "Sunday": "الاحد",
      }
          : {
        "Monday": "Monday",
        "Tuesday": "Tuesday",
        "Wednesday": "Wednesday",
        "Thursday": "Thursday",
        "Friday": "Friday",
        "Saturday": "Saturday",
        "Sunday": "Sunday",
      };

}

class AppLocale {
  static const String AR = "ar";
  static const String EN = "en";

  static final localizationDelegate = [
    Trans.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}

//----------enum----------------

class StatusType {
  static const success = "success";
  static const fail = "fails";
}
class OrderStatus {
  static const received = "RECEIVED";
  static const canceled = "CANCELLATION_APPROVED";

}

class CheckInOut {
  static const checkIn = 1;
  static const checkOut = 2;
  static const recheck = 5;
}

class PaymentStatus {
  static const paid = "PAID";
  static const notPaid = "NOT_PAID";
}

class BannerType {
  static const outsideApp = "OUTSIDE_APP";
  static const insideApp = "INAPP";
}
class BannerPosition {
  static const top = "TOP";
  static const bottom = "DOWN";
}