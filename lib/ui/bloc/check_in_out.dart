import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sky_vacation/base/base_bloc.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/base/result.dart';
import 'package:sky_vacation/data/api/api_method.dart';
import 'package:sky_vacation/data/api/api_repo.dart';
import 'package:sky_vacation/data/api/api_urls.dart';
import '../../main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class CheckInOutBloc extends BaseBloc<Result<bool>> {
  ApiRepo repository;

  CheckInOutBloc(this.repository);

  
    
     FToast? fToast;

    
  Future<void> create(
    int inoutmode,
    int? locationId,
  ) async {
    emit(Result.loading());
    try {
      int userId = sm.getUser()?.usId ?? 0;
      String? deviceId = await PlatformDeviceId.getDeviceId;
Position position = await _determinePosition();
                  print(position.latitude);
                  print(position.longitude);
                  print(position.accuracy);

      var result =
          await repository.call(ApiMethod.post, Urls.checkInOut, body: {
        "empid": "$userId",
        "inoutmode": "$inoutmode",
        "shiftid": "${sm.getUser()?.shiftId ?? 0}",
        "locationId": "${locationId ?? 0}",
        "mobSer": "$deviceId",
        "gdatetime": "${au.formatDateTimeZone(DateTime.now())}",
        "chektime": "${au.formatTime(TimeOfDay.now())}",
        "Latitude": position.latitude,
        "Longitude":position.longitude,
        "accuracy": position.accuracy
      }, addLang: false);
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
      appLog("Error CheckInOutBloc: ${e.toString()}");
      emit(Result.error('codeBadRequest'));
    }
  }



    Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
