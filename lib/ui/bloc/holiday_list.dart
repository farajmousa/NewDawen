import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/holiday_data.dart';
import 'package:sky_vacation/helper/app_util.dart';

import '../../main.dart';

class HolidayListBloc extends BaseBloc<Result<List<HolidayData>>> {
  ApiRepo repository;

  HolidayListBloc(this.repository);

  Future<void> get() async {
    emit(Result.loading());
    try {
      int userId = sm.getUser()?.usId ?? 0;
      var result = await repository.call(
        ApiMethod.get,
        "${Urls.holidayGetAll}/$userId",
      );

      List<HolidayData> dataList = (jsonDecode(result) as List)
          .map((itemWord) => HolidayData.fromJson(itemWord))
          .toList();

      emit(Result.success(dataList));
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
