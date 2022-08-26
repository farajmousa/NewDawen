import 'package:flutter/material.dart';
import 'package:sky_vacation/ui/screen/absents.dart';
import 'package:sky_vacation/ui/screen/check_in_out.dart';
import 'package:sky_vacation/ui/screen/excuses_agreements.dart';
import 'package:sky_vacation/ui/screen/holidays_agreements.dart';
import 'package:sky_vacation/ui/screen/login_company.dart';
import 'package:sky_vacation/ui/screen/excuses.dart';
import 'package:sky_vacation/ui/screen/leaves.dart';
import 'package:sky_vacation/ui/screen/login_user.dart';
import 'package:sky_vacation/ui/screen/holidays.dart';
import 'package:sky_vacation/ui/screen/main.dart';
import 'package:sky_vacation/ui/screen/offline.dart';
import 'package:sky_vacation/ui/screen/splash.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case offline:
        return MaterialPageRoute(builder: (_) => OfflineScreen());
      case login:
        return MaterialPageRoute(
            builder: (_) => LoginUserScreen());
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case company:
        return MaterialPageRoute(builder: (_) => LoginCompanyScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginUserScreen());
      case holidays:
        return MaterialPageRoute(builder: (_) => HolidayScreen());
      case holidaysAgreements:
        return MaterialPageRoute(builder: (_) => HolidaysAgreementsScreen());
      case excuse:
        return MaterialPageRoute(builder: (_) => ExcuseScreen());
      case excuseAgreements:
        return MaterialPageRoute(builder: (_) => ExcusesAgreementsScreen());
      case leaves:
        return MaterialPageRoute(builder: (_) => LeaveScreen());
      case absents:
        return MaterialPageRoute(builder: (_) => AbsentsScreen());
      case checkInOut:
        return MaterialPageRoute(builder: (_) => CheckInOutScreen());


      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => ExcuseScreen());
    }
  }
  static const String initial = "/";
  static const String offline = "/offline";
  static const String company = "/company";
  static const String login = "/login";
  static const String register = "/register";
  static const String main = "/main";
  static const String home = "/home";
  static const String checkInOut = "/checkInOut";
  static const String holidays = "/holidays";
  static const String holidaysAgreements = "/holidaysAgreements";
  static const String excuse = "/excuse";
  static const String excuseAgreements = "/excuseAgreements";
  static const String notifications = "/notifications";
  static const String userInfo = "/userInfo";
  static const String leaves = "/leaves";
  static const String absents = "/absents";

}

class RouteArgument {
  List<dynamic>? param;

  RouteArgument({
    this.param,
  });

  @override
  String toString() {
    return 'RouteArgument: $param';
  }
}
