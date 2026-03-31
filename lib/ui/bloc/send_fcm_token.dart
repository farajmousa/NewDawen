import 'dart:convert';
import 'dart:io';

import 'package:dawim/base/base_bloc.dart';
import 'package:dawim/base/base_exception.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_method.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/data/api/api_urls.dart';
import 'package:dawim/data/model/entity/user.dart';
import 'package:dawim/helper/user_constant.dart';
import '../../helper/app_constant.dart';
import '../../main.dart';
import 'package:dawim/helper/app_util.dart';

class SendFcmTokenBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  SendFcmTokenBloc(this.repository);

  Future<void> send() async {
    emit(Result.loading());
    try {
      String fcm = sm.getValue(UserConstant.FCM_TOKEN);

      var result = await repository.call(
          ApiMethod.put,
          "${Urls.sendFcmToken}/${sm.getUser()?.usId ?? 0}",
          addLang: false,
          body: {
            "userToken": fcm,
            "deviceType": "0", //"${(Platform.isAndroid)?'android': 'ios'}",
            "language": "${(currentLocale == AppLocale.AR) ? 0 : 1}",
            "empId": "${sm.getUser()?.usId ?? 0}",
          });
      appLog("sendFcmToken result: $result");

      // var result2 = await repository.call(
      //     ApiMethod.post,
      //     Urls.sendNotification,
      //     addLang: false,
      //     body: {
      //       "DeviceId": fcm,
      //       "IsAndroiodDevice": true,
      //       "Title": "my own title",
      //       "Body": "my own Body",
      //     },);

      // appLog("sendNotification result: $result2");

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
      appLog("Error SendFcmTokenBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
