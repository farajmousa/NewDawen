import 'dart:convert';

import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/helper/user_constant.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

//company/99/99

class LoginCompanyBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  LoginCompanyBloc(this.repository);

  Future<void> login(
    String? email,
    String? password,
  ) async {
    emit(Result.loading());
    try {
      String url = "${Urls.companyLogin}/$email/$password";

      var result = await repository.call(ApiMethod.get, url,isBaseApi: true, addLang: false, isNewResponse: false);
      Map<String, dynamic> map = jsonDecode(result);
      if (map['Status'] == "Success") {
        Company company = Company.decodedJson(result);
        sm.setCompany(company);

        var resultToken = await repository.call(ApiMethod.post, Urls.tokenAuth,
            body: {
              "userNameOrEmailAddress": "admin",
              "password": "123qwe",
              "rememberClient": "true"
            },
            isFormData: false, addLang: false, isNewResponse: false);
        appLog("Token: $resultToken");
        Map<String, dynamic> mapToken =
            jsonDecode(resultToken); //{map["result"]["accessToken"]}
        if (mapToken.containsKey("result")) {
          sm.setValue(UserConstant.accessToken,
              mapToken["result"]["accessToken"].toString());
          emit(Result.success(true));
        } else {
          emit(Result.error('codeBadRequest'));
        }
      } else if (map.containsKey("Status") &&
          map['Status'].toString().isNotEmpty) {
        appLog("Step 2");
        emit(Result.error("${map['Status'].toString()}"));
      } else {
        emit(Result.error('codeBadRequest'));
      }
    } on ForbiddenException {
      emit(Result.forbidden());
    } on NotFoundException {
      emit(Result.error('wrong_user_data'));
    } on BaseException catch (errorBody) {
      if (errorBody.message.isNotEmpty) {
        emit(Result.error(errorBody.message));
      } else {
        emit(Result.error('codeBadRequest'));
      }
    } on Exception catch (e) {
      emit(Result.error('codeBadRequest'));
    } catch (e) {
      appLog("Error LoginCompanyBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
