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

class HolidayCreateBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  HolidayCreateBloc(this.repository);

  Future<void> create(DateTime date, int period, int bossIdHead, int bossIdDepart,
      int bossIdSubstitute, int selectedType,
      {int? holidayId}) async {
    emit(Result.loading());
    try {
      DateTime endDate = DateTime(date.year, date.month, (date.day + period));

      var result = await repository.call(
          (null == holidayId || holidayId == 0)
              ? ApiMethod.post
              : ApiMethod.put,
          (null == holidayId || holidayId == 0)
              ? Urls.holidayCreate
              :"${Urls.holidayUpdate}/$currentLocale",
          body: {
            "empid": sm.getUser()?.usId ?? 0,
            "dbbossid": bossIdDepart,
            "bossid": bossIdHead,
            "empsupport": bossIdSubstitute,
            "briod": period,
            "holdaytype": selectedType,
            "startDate": au.formatDateTimeZone(date),


            "datereq": "",
            "startHdate": "",
            "endDate": "",
            "endHdate": "",
            "adminAffairsBossId": 0,
            "hstatues": 0,
            "hstatuestext": "",
            "dbbcancle": "",
            "bcancle": "",
            "id": holidayId ?? 0
          }, addLang: false);

      appLog("login result: $result");
      // Map<String, dynamic> map = jsonDecode(result);
      // print("map['success']: ${map['success']}");
      // if (map.containsKey("result") &&
      //     map["result"] != null &&
      //     map['success'].toString() == "true") {
        emit(Result.success(true));
      // } else if (map.containsKey("result") &&
      //     map['success'].toString().isNotEmpty) {
      //   appLog("Step 22");
      //   emit(Result.error("${map['success'].toString()}"));
      // } else {
      //   appLog("Step 3");
      //   emit(Result.error('codeBadRequest'));
      // }
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
      appLog("Error HolidayCreateBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
