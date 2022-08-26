import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/model/entity/id_name.dart';
import 'package:sky_vacation/helper/app_util.dart';

class DirectorsBloc extends BaseBloc<Result<Map<String, List<IdName>>>> {
  ApiRepo repository;

  DirectorsBloc(this.repository);

  Future<void> get(String url) async {
    emit(Result.loading());
    try {
      var result = await repository.call(
        ApiMethod.get,
        url,
      );

        List<IdName> dataList = (jsonDecode(result) as List)
            .map((itemWord) => IdName.fromJson(itemWord))
            .toList();

        emit(Result.success({url:dataList}));

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
      appLog("Error DirectorsBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
