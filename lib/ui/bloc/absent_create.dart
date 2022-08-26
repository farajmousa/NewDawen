import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class AbsentCreateBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  AbsentCreateBloc(this.repository);

  Future<void> create(
      DateTime dateStart,
      DateTime dateEnd,
      int bossIdHead,
      int bossId,
      int bossIdSubstitute,
      int selectedType,
      int shiftId,
      String reason,
      {int? holidayId}) async {
    emit(Result.loading());
    try {
      var result = await repository.call(
          (null == holidayId || holidayId == 0)
              ? ApiMethod.post
              : ApiMethod.put,
          (null == holidayId || holidayId == 0)
              ? Urls.excuseCreate
              : Urls.excuseUpdate,
          body: {
            "empid": 0,
            "datehj": au.getDateHijri(DateTime.now()).toString(),
            "dategr": au.formatDateTime(dateStart),
            "minitcount": 0,
            "holiday": 0,
            "legation": 0,
            "nadb": 0,
            "course": 0,
            "mission": 0,
            "absent1": 0,
            "thodor": "string",
            "tenseraf": "string",
            "aftershift": 0,
            "edafiMinutesSbahi": 0,
            "edafiMinutesmase": 0,
            "excminit": 0,
            "id": holidayId ?? 0
          });

      appLog("login result: $result");
      Map<String, dynamic> map = jsonDecode(result);
      print("map['success']: ${map['success']}");
      if (map.containsKey("result") &&
          map["result"] != null &&
          map['success'].toString() == "true") {
        emit(Result.success(true));
      } else if (map.containsKey("result") &&
          map['success'].toString().isNotEmpty) {
        appLog("Step 22");
        emit(Result.error("${map['success'].toString()}"));
      } else {
        appLog("Step 3");
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
      appLog("Error AbsentCreateBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
