import 'dart:convert';
import 'package:dawim/base/base_bloc.dart';
import 'package:dawim/base/base_exception.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_method.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/data/model/entity/id_name.dart';
import 'package:dawim/helper/app_util.dart';

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
