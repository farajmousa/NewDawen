import 'dart:convert';

import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/user.dart';
import 'package:sky_vacation/helper/user_constant.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

//مدير قسم الشئون الموظفين نواف فضل اسم المستخدم 123 الرقم السري 123456
//المدير العام احمد شاهانه اسم المستخدم 102الرقم السري 123456
//موظف عادي عبد الفتاح اسم المستخدم 135 الرقم السري 123456
//مديره خالد اسم المستخدم 1010 كلمة المرور 123456

class LoginBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  LoginBloc(this.repository);

  Future<void> login(
    String? email,
    String? password,
  ) async {
    emit(Result.loading());
    try {

      String url = "${Urls.userLogin}/$email/$password";
      print("login URL : $url");
      var result = await repository.call(
        ApiMethod.get,
        url,
      );
      appLog("login result: $result");

      User user = User.decodedJson(result);
      appLog("login result 1: $user");
      sm.setUser(user);
      if (user.active ?? false) {
        sm.setUser(user);
        sm.setValue(UserConstant.LOGIN_EMAIL, email ?? "");
        sm.setValue(UserConstant.LOGIN_PASSWORD, password ?? "");
        appLog("login result 2: $result");
        emit(Result.success(true));
      } else {
        emit(Result.error("This user isn't active"));
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
      appLog("Error LoginBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
