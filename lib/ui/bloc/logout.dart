import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import 'package:sky_vacation/helper/app_util.dart';

class LogoutBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  LogoutBloc(this.repository);

  // Future<void> logout() async {
  //   emit(Result.loading());
  //   try {
  //     var result =
  //     await repository.call(ApiMethod.get, Urls.logout, );
  //     emit(Result.success(true));
  //   }  on ForbiddenException {
  //     emit(Result.forbidden());
  //   } on NotFoundException {
  //     emit(Result.error('codeNotFound'));
  //   } on BaseException catch (errorBody) {
  //     if (errorBody.message.isNotEmpty) {
  //       emit(Result.error(errorBody.message));
  //     } else {
  //       emit(Result.error('codeBadRequest'));
  //     }
  //   } on Exception catch (e) {
  //     emit(Result.error('codeBadRequest'));
  //   } catch(e){
  //     appLog("Error LogoutBloc: ${e.toString()}");
  //     emit(Result.error('codeBadRequest'));
  //   }
  // }

}
