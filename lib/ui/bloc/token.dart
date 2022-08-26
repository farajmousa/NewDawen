import 'dart:convert';

import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/helper/user_constant.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class TokenBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  TokenBloc(this.repository);

  Future<void> getToken() async {
    emit(Result.loading());
    try {

      var resultToken = await repository.call(ApiMethod.post, Urls.tokenAuth,
          body: {
            "userNameOrEmailAddress": "admin",
            "password": "123qwe",
            "rememberClient": "true"
          },
          isFormData: false, addLang: false, isNewResponse: false);
      appLog("Token: $resultToken");
      Map<String, dynamic> mapToken = jsonDecode(resultToken);
      if (mapToken.containsKey("result")) {
        sm.setValue(UserConstant.accessToken,
            mapToken["result"]["accessToken"].toString());
        emit(Result.success(true));
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
      appLog("Error TokenBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
