import 'package:flutter/material.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/ui/bloc/token.dart';
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
  final TokenBloc _loginBloc = sl<TokenBloc>();

  @override
  void initState() {
    _loginBloc.mainStream.listen(_observeLogin);
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {

      if (sm.getCompany() != null) {
        if (sm.getUser() != null) {
          _loginBloc.getToken();
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoute.login);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoute.company);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child:
            Image.asset(AppAsset.logo, width: Dim.h40, height: Dim.h40,),
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
