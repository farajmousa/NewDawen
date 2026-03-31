import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/di/injection_container.dart';
import 'package:dawim/helper/app_color.dart';
import 'package:dawim/helper/app_route.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/helper/font_style.dart';
import 'package:dawim/helper/localize.dart';
import 'package:dawim/ui/bloc/loginCompany.dart';
import 'package:dawim/ui/components/rounded_button.dart';
import '../../helper/app_asset.dart';
import '../../helper/app_decoration.dart';
import '../../main.dart';

class LoginCompanyScreen extends StatefulWidget {
  @override
  _LoginCompanyScreenState createState() => _LoginCompanyScreenState();
}

class _LoginCompanyScreenState extends ResumableState<LoginCompanyScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  String? _userNameError;
  String? _passwordError;
  bool? _autoValidate, _obscureText;
  bool disable = false;
  bool isLoading = false;

  final LoginCompanyBloc _loginBloc = sl<LoginCompanyBloc>();

  refresh() {
    if (mounted) setState(() {});
  }

  void loading(bool load) {
    isLoading = load;
    refresh();
  }

  initComponents() {
    _userNameError = null;
    _passwordError = null;
    _autoValidate = false;
    _obscureText = true;
  }

  //

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc.mainStream.listen(_observeLogin);

    super.initState();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bkgGray,
        body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dim.w6, vertical: Dim.h4),
                margin: EdgeInsets.symmetric(horizontal: Dim.w6, vertical: Dim.h3),
                decoration: AppDecor.decoration(
                    bkgColor: AppColor.bkg, borderRadius: Dim.h3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppAsset.logo,
                      width: Dim.h30,
                      height: Dim.h24,
                    ),
                    Text(
                      Trans.of(context).t("welcome_back"),
                      style: TS.boldPrimary10,
                    ),
                    SizedBox(
                      height: Dim.h3,
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
                        prefixIcon: const Icon(Icons.email),
                        hintText: Trans.of(context).t("companyNameHintText"),
                        hintStyle: TS.regularGray8,
                        enabled: true,
                        errorText: _userNameError,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Dim.w6, vertical: Dim.h2),
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
                              Trans.of(context).t("companyNameError");
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
                        hintStyle: TS.regularGray8,
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Dim.w6, vertical: Dim.h2),
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
                          // _authBloc.dispatch(CompanyRequested(
                          //     userName: _userNameController.text.trim(),
                          //     password: _passwordController.text.trim()));
                        } else {
                          setState(() {
                            disable = false;
                            isLoading = false;
                            _autoValidate = true;
                          });
                        }
                      },
                      text: Trans.of(context).t("loginCompanyButtonText"),
                      disabled: disable,
                      loading: isLoading,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$appVersion',
                        style: TS.regularBlack8,
                      ),),
                  ],
                ),
              ),
            ),
          )),
        ));
  }

  void _observeLogin(Result<bool> result) {
    loading(false);
    disable = false;
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      Navigator.of(context).pushNamed(AppRoute.login);
    } else if (result is ErrorResult) {
      comp.handleApiError(context,
          error: result.getErrorMessage(), img: AppAsset.failed);
    } else if (result is LoadingResult) {
      loading(true);
    }
  }
}
