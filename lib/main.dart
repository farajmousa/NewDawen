import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'data/model/push_notification.dart';
import 'di/injection_container.dart';
import 'helper/app_color.dart';
import 'helper/app_constant.dart';
import 'helper/app_route.dart';
import 'helper/app_theme.dart';
import 'helper/app_util.dart';
import 'helper/session_manager.dart';
import 'helper/user_constant.dart';
import 'ui/widgets/components.dart';
import 'di/injection_container.dart' as di;


final SessionManager sm = sl<SessionManager>();
final Components comp = sl<Components>();
final AppUtil au = sl<AppUtil>();
final Const constant = sl<Const>();
BuildContext? appContext ;
FirebaseMessaging? firebaseMessaging;
String currentLocale = AppLocale.AR;

//-----------------
final getIt = GetIt.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await initFirebase();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(Phoenix(child: MyApp()));
}

//------------------------------------------------------------------------------

class MyApp extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MyApp> {

  final appLocales = [
    Locale(AppLocale.AR),
    Locale(AppLocale.EN),
  ];

  @override
  void initState() {
    initLocaleNotification();
    tryingNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    FlutterStatusbarcolor.setStatusBarColor(AppColor.primary);
    currentLocale = (sm.getValue(UserConstant.AppLang).isNotEmpty)
        ? sm.getValue(UserConstant.AppLang)
        : AppLocale.EN;
    appLog("#CurrentLocale: $currentLocale");

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil.setScreenSize(constraints, orientation);
            return MaterialApp(
              color: AppColor.bkg,
              debugShowCheckedModeBanner: false,
              title: Const.appName,
              onGenerateRoute: AppRoute.routes,
              initialRoute: AppRoute.initial,
              //initialRoute,
              theme: AppTheme.appTheme,
              themeMode: ThemeMode.light,
              locale: Locale(currentLocale),
              supportedLocales: [
                Locale(AppLocale.AR),
                Locale(AppLocale.EN),
              ],
              localizationsDelegates: AppLocale.localizationDelegate,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        );
      },
    );
  }


}
