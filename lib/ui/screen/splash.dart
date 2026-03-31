import 'package:flutter/material.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/di/injection_container.dart';
import 'package:dawim/helper/app_asset.dart';
import 'package:dawim/helper/app_route.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/ui/bloc/token.dart';
import '../../main.dart';


class SplashScreen extends StatefulWidget {
  final String? locale;

  SplashScreen({
    Key? key,
    this.locale,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final TokenBloc _loginBloc = sl<TokenBloc>();

  @override
  void initState() {
    // _loginBloc.mainStream.listen(_observeLogin);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Future.delayed(Duration(seconds: 2), () async {
        if (sm.getCompany() != null) {
          if (sm.getUser() != null) {
            Navigator.of(context).pushReplacementNamed(AppRoute.main);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoute.login);
          }
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoute.company);
        }
      // });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child:
            Center(
              child: Image.asset(AppAsset.logo, width: Dim.h40, height: Dim.h40, fit: BoxFit.contain,),
            )
      ),
    );
  }

//  ----------
  void _observeLogin(Result<bool> result) {
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      Navigator.of(context).pushReplacementNamed(AppRoute.main);
    } else if (result is ErrorResult) {
      sm.deleteCompany();
      Navigator.of(context).pushReplacementNamed(AppRoute.company);
    } else if (result is LoadingResult) {}
  }
}
