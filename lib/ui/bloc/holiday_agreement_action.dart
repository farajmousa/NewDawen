import 'dart:convert';
import 'package:dawim/base/base_bloc.dart';
import 'package:dawim/base/base_exception.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_method.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/helper/app_util.dart';

import '../../main.dart';

class HolidayAgreementActionBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  HolidayAgreementActionBloc(this.repository);

  Future<void> checkAccepted(String url, int holidayId,
      {String? rejectReason ,bool isHoliday = true}) async {
    emit(Result.loading());
    try {
      var result = await repository.call(
          ApiMethod.post,
          (null == rejectReason)
              ? url
              : "$url?Empid=${sm.getUser()?.usId ?? 0}&${(isHoliday)?"Holdayreqid":"ExcuseReqid"}=$holidayId&RejectReason=$rejectReason&lang=$currentLocale",
          addLang: false );

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
      appLog("Error HolidayAgreementActionBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
