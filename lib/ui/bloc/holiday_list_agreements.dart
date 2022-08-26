import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/data/model/entity/holiday_agreement_data.dart';
import 'package:sky_vacation/helper/app_util.dart';
import '../../main.dart';

class HolidayListAgreementBloc extends BaseBloc<Result<List<HolidayAgreementData>>> {
  ApiRepo repository;

  HolidayListAgreementBloc(this.repository);

  Future<void> get() async {
    emit(Result.loading());
    try {
      var result = await repository.call(
        ApiMethod.get,
        "${Urls.holidayGetAllAgreements}?Empid=${sm.getUser()?.usId ?? 0}&StartFrom=1&EndTo=1000&lang=$currentLocale",
        addLang: false
      );

      print("#result: $result");
        List<HolidayAgreementData> dataList = (jsonDecode(result) as List)
            .map((itemWord) => HolidayAgreementData.fromJson(itemWord))
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
      appLog("Error HolidayListAgreementBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
