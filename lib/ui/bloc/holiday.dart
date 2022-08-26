import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/helper/app_util.dart';

class CheckItemAcceptedBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  CheckItemAcceptedBloc(this.repository);

  Future<void> checkAccepted(String url, int holidayId) async {
    emit(Result.loading());
    try {
      var result = await repository.call(
        ApiMethod.get,
        Urls.holidayGet,
        queries: {"id": "$holidayId"}
      );
      Map<String, dynamic> map = jsonDecode(result);
      if (map.containsKey("result") && map["result"] == null) {
        emit(Result.success(true));
      } else {
        emit(Result.success(false));
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
      appLog("Error CheckItemAcceptedBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
