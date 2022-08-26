import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/ui/bloc/login.dart';
import 'package:sky_vacation/ui/components/rounded_button.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/ui/widgets/app_image.dart';

class LoginUserScreen extends StatefulWidget {
  @override
  _LoginUserScreenState createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends ResumableState<LoginUserScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  String? _userNameError;
  String? _passwordError;
  bool? _autoValidate, _obscureText;
  bool disable = false;
  bool isLoading = false;
  String? companyLogo;
  final LoginBloc _loginBloc = sl<LoginBloc>();

  refresh() {
    if (mounted) setState(() {});
  }

  void loading(bool load) {
    isLoading = load;
    refresh();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(Trans.of(context).t("ok")),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Trans.of(context).t("alert")),
      content: Text(Trans.of(context).t("unActiveMsg")),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc.mainStream.listen(_observeLogin);
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    var prefs = sm.getCompany();
    setState(() {
      companyLogo = prefs?.CompLogo;
      print("companyLogo $companyLogo");
    });
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (null != sm.getCompany()?.CompLogo)
                AppImage(
                  img: sm.getCompany()?.CompLogo ?? "",
                  fit: BoxFit.contain,
                  height: Dim.h24,
                  width: Dim.h24,
                  bkgColor: Colors.transparent,
                ),
              SizedBox(
                height: Dim.h4,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 26.0),
                padding: EdgeInsets.symmetric(horizontal: Dim.w8),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "${Trans.of(context).t("welcome_to")}:  ${sm.getCompany()?.CompName}",
                        style: TS.boldBlack16,
                      ),
                      SizedBox(
                        height: Dim.h5,
                      ),
                      TextFormField(
                        focusNode: _userNameFocusNode,
                        keyboardAppearance: Brightness.light,
                        controller: _userNameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.grayTF,
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email),
                          hintText: Trans.of(context).t("userNameHintText"),
                          hintStyle: TS.kBodyLightTextStyle,
                          enabled: true,
                          errorText: _userNameError,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        onChanged: (text) {
                          setState(() {
                            _autoValidate = false;
                            _userNameError = null;
                            _passwordError = null;
                          });
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (_) {
                          if ((_userNameController.text.trim().length == 0)) {
                            _userNameError =
                                Trans.of(context).t("userNameError");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Dim.h2,
                      ),
                      TextFormField(
                        focusNode: _passwordFocusNode,
                        obscureText: _obscureText ?? false,
                        keyboardAppearance: Brightness.light,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.grayTF,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none),
                          alignLabelWithHint: true,
                          hintText: Trans.of(context).t("passwordHintText"),
                          hintStyle: TS.kBodyLightTextStyle,
                          errorText: _passwordError,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ?? false
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !(_obscureText ?? false);
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        onChanged: (text) {
                          setState(() {
                            _autoValidate = false;
                            _userNameError = null;
                            _passwordError = null;
                          });
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        validator: (_) {
                          if ((_passwordController.text.trim().length == 0)) {
                            _passwordError =
                                Trans.of(context).t("passwordError");
                          }
                          return null;
                        },
                      ),
                      RoundedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if ((_userNameController.text.trim().length > 0 &&
                              _passwordController.text.trim().length > 0)) {
                            setState(() {
                              disable = true;
                              isLoading = true;
                              _autoValidate = false;
                              _userNameError = null;
                              _passwordError = null;
                            });
                            _loginBloc.login(_userNameController.text.trim(),
                                _passwordController.text.trim());
                          } else {
                            setState(() {
                              disable = false;
                              isLoading = false;
                              _autoValidate = true;
                            });
                          }
                        },
                        text: Trans.of(context).t("loginButtonText"),
                        disabled: disable,
                        loading: isLoading,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Text(
                          Trans.of(context).t("loginCompanyButtonText"),
                          style: TS.textStyle(
                              size: Dim.s12,
                              isUnderLine: true,
                              weight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          sm.deleteCompany();
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoute.company);
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//--------------------------------------------

  void _observeLogin(Result<bool> result) {
    loading(false);
    disable = false;
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      Navigator.of(context).pushNamed(AppRoute.main);
      showToasted(Trans.of(context).t("loginsuccess"));
      //  comp.displayToast(context,
      //                     Trans.of(context).t("loginsuccess"));
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    }
  }

 void  showToasted( String msg) =>
       Fluttertoast.showToast(msg: msg,
       gravity: ToastGravity.TOP,
       timeInSecForIosWeb: 10,
       backgroundColor: Colors.green,
       toastLength: Toast.LENGTH_LONG,
       );
       
      
}
