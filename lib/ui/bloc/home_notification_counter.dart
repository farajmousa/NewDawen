import 'dart:convert';

import 'package:dawim/base/base_bloc.dart';
import 'package:dawim/base/base_exception.dart';
import 'package:dawim/base/result.dart';
import 'package:dawim/data/api/api_method.dart';
import 'package:dawim/data/api/api_repo.dart';
import 'package:dawim/data/api/api_urls.dart';
import 'package:dawim/helper/app_util.dart';

import '../../data/model/entity/notific_counter.dart';
import '../../main.dart';

class HomeNotificationCounterBloc extends BaseBloc<Result<List<NotificationCounter>>> {
  ApiRepo repository;

  HomeNotificationCounterBloc(this.repository);

  Future<void> get(
      ) async {
    emit(Result.loading());
    try {
      String url = "${Urls.getHomeCounters}/${sm.getUser()?.usId}";

      appLog("getHomeCounters URL : $url");
      var result = await repository.call(
        ApiMethod.get,
        url,
        addLang: true
      );
      appLog("getHomeCounters result: $result");
      List<NotificationCounter> dataList = (jsonDecode(result) as List)
          .map((itemWord) => NotificationCounter.fromJson(itemWord))
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
      appLog("Error LoginBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}


