import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class ExecuseCreateBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  ExecuseCreateBloc(this.repository);

  Future<void> create(
      TimeOfDay? dateStart,
      TimeOfDay? dateEnd,
      DateTime date,
      int bossIdHead,
      int bossIdDepart,
      int bossIdSubstitute,
      int selectedType,
      String reason,
      {int? holidayId}) async {
    emit(Result.loading());
    try {

      var result = await repository.call(
           ApiMethod.put,
          (null == holidayId || holidayId == 0)
              ? Urls.excuseCreate
              : Urls.excuseUpdate,
          body: {
            "stime": (null != dateStart)? au.formatTime(dateStart): "00:00:00",
            "etime":  (null != dateEnd)? au.formatTime(dateEnd): "00:00:00",
            "edate": au.formatDateTimeZone(date),
            "empid": sm.getUser()?.usId ?? 0,
            "dpbossid": bossIdDepart,
            "bossid": bossIdHead ,
            "empsupport": bossIdSubstitute,
            "typeid": selectedType,
            "shiftid": sm.getUser()?.shiftId ?? 0,
            "excwhy":reason,
            "adminAffairsBossId": 0,
            "exstatues": 0,
            "exstatuestext": "",
            "dpbcancle": "",
            "bcancle": "",
            "id": holidayId ?? 0
          },);
      appLog("login result: $result");


        emit(Result.success(true));

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
      appLog("Error ExecuseCreateBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
