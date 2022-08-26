import 'dart:convert';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/model/entity/notification_data.dart';
import '../../base/base_exception.dart';
import '../../data/api/api_method.dart';
import '../../data/api/api_urls.dart';
import '../../helper/app_util.dart';
import '../../main.dart';


class NotificationsBloc extends BaseBloc<Result<List<NotificationData>?>> {
  ApiRepo repository;

  NotificationsBloc(this.repository);

  Future<void> getNotifications() async {
    emit(Result.loading());
    try {

      int userId = sm.getUser()?.usId?? 0 ;
      var result = await repository.call(ApiMethod.get, "${Urls.getNotifications}/$userId",);

      List<NotificationData> dataList = (jsonDecode(result) as List)
          .map((itemWord) => NotificationData.fromJson(itemWord))
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
      appLog("Error NotificationsBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }
}
