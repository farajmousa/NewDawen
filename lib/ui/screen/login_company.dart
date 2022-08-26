import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/di/injection_container.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_route.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/ui/bloc/loginCompany.dart';
import 'package:sky_vacation/ui/components/rounded_button.dart';
import '../../helper/app_asset.dart';
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
  void loading(bool load){
    isLoading = load;
    refresh();
  }
  initComponents(){
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
      backgroundColor: AppColor.white,
      body: SafeArea(
            child:
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                    margin: EdgeInsets.only(bottom: 26.0),
                    padding: EdgeInsets.symmetric(horizontal: Dim.w8),
                    child:  Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          Image.asset(AppAsset.logo, width: Dim.h40, height: Dim.h40,),

                          Text(Trans.of(context).t("welcome_back"), style: TS.boldBlack16,),
                          SizedBox(height: Dim.h5,),
                          TextFormField(

                            focusNode: _userNameFocusNode,
                            keyboardAppearance:
                            Brightness.light,
                            controller: _userNameController,
                            keyboardType:
                            TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,

                              fillColor: AppColor.grayTF,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                  Icons.email
                              ),
                              hintText: Trans.of(context).t("companyNameHintText"),
                              hintStyle: TS.kBodyLightTextStyle,
                              enabled: true,
                              errorText: _userNameError,
                              contentPadding:
                              EdgeInsets.all(8.0),
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
                                  .requestFocus(
                                  _passwordFocusNode);
                            },
                            validator: (_) {
                              if ((_userNameController.text
                                  .trim()
                                  .length == 0)) {
                                _userNameError = Trans.of(context).t("companyNameError");
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: Dim.h2,),
                          TextFormField(

                            focusNode: _passwordFocusNode,
                            obscureText: _obscureText ?? false,
                            keyboardAppearance:
                            Brightness.light,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.grayTF,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide.none
                              ),
                              alignLabelWithHint: true,
                              hintText: Trans.of(context).t("passwordHintText"),
                              hintStyle: TS.kBodyLightTextStyle,
                              errorText: _passwordError,

                              prefixIcon: Icon(
                                  Icons.lock
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText?? false
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText =
                                    !(_obscureText?? false);
                                  });
                                },
                              ),
                              contentPadding:
                              EdgeInsets.all(8.0),
                            ),
                            onChanged: (text) {
                              setState(() {
                                _autoValidate = false;
                                _userNameError = null;
                                _passwordError = null;
                              });
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                  FocusNode());
                            },
                            validator: (_) {
                              if ((_passwordController.text
                                  .trim()
                                  .length == 0)) {
                                _passwordError = Trans.of(context).t("passwordError");
                              }
                              return null;
                            },
                          ),

                          RoundedButton(

                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if ((_userNameController.text
                                  .trim()
                                  .length > 0 && _passwordController.text
                                  .trim()
                                  .length > 0)) {
                                setState(() {
                                  disable = true;
                                  isLoading = true;
                                  _autoValidate = false;
                                  _userNameError = null;
                                  _passwordError = null;
                                });
                                _loginBloc.login(_userNameController.text.trim(), _passwordController.text.trim());
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
                        ],
                      ),
                    ),
                  ),
                )

            ),
        )


    );
  }


  void _observeLogin(Result<bool> result) {
    loading(false);
    disable = false;
    if (result is SuccessResult) {
      if (null == result.getSuccessData()) return;
      Navigator.of(context).pushNamed(AppRoute.login);
    } else if (result is ErrorResult) {
      comp.handleApiError(context, error: result.getErrorMessage());
    } else if (result is LoadingResult) {
      loading(true);
    } 
  }
}
