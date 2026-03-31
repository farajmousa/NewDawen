import 'dart:convert';

import 'package:dawim/base/base_bloc.dart';
import 'package:dawim/base/base_exception.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_method.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/data/api/api_urls.dart';
import 'package:dawim/data/model/entity/company.dart';
import 'package:dawim/helper/user_constant.dart';
import '../../main.dart';
import 'package:dawim/helper/app_util.dart';

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

      var resultLoginCompany = await repository.call(ApiMethod.get, url,
          isBaseApi: true, addLang: false, isNewResponse: false);
      Map<String, dynamic> map = jsonDecode(resultLoginCompany);
      if (map['Status'] == "Success") {
        Company company = Company.decodedJson(resultLoginCompany);

        var resultToken = await repository.call(ApiMethod.post, Urls.tokenAuth,
            body: {
              "userNameOrEmailAddress": "admin",
              "password": "123qwe",
              "rememberClient": "true"
            },
            baseUrl: company.Url,
            isFormData: false,
            addLang: false,
            isNewResponse: false);
        appLog("Token: $resultToken");
        Map<String, dynamic> mapToken =
            jsonDecode(resultToken); //{map["result"]["accessToken"]}
        if (mapToken.containsKey("result")) {

          //save login response
          sm.setCompany(company);
          //-------
          sm.setValue(UserConstant.accessToken,
              mapToken["result"]["accessToken"].toString());
          emit(Result.success(true));
        } else {
          emit(Result.error('codeBadRequest'));
        }
      } else if (map.containsKey("Status") &&
          map['Status'].toString().isNotEmpty) {
        appLog("Step 2");
        emit(Result.error(map['Status'].toString()));
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
