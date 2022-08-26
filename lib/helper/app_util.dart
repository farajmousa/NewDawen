import 'dart:developer';
import 'dart:typed_data';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'permissions.dart';
import 'app_constant.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:hijri/hijri_calendar.dart';
import 'package:collection/collection.dart';

class AppUtil {
  static Future<bool> isOnline() async {
    final ConnectivityResult connectivityResult =
    await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      appLog('No Connection');
      return false;
    } else {
      return false;
    }
  }

  bool isValidEmail(String value) {
    return RegExp(Const.emailRegx).hasMatch(value);
  }

  bool isValidPhone(String value) {
    return RegExp(Const.mobileRegex).hasMatch(value);
  }

  List<int> getDateDiff(String date) {
    DateTime timeCreatedAt = DateTime.parse(date);
    DateTime timeNow = DateTime.now();
    int diffMinutes = timeNow
        .difference(timeCreatedAt)
        .inMinutes;
    int diffHour = 0;
    if (diffMinutes > 60) {
      diffHour = (diffMinutes ~/ 60).toInt();
      diffMinutes = (diffMinutes % 60).toInt();
    }

    return [diffHour, diffMinutes];
  }

  String getCurrentDateTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
  String formatDateTime(DateTime date) {
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }
  String formatDateTimeZone(DateTime date) {
    var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    String formattedDate = formatter.format(date);
    return formattedDate;
  }
  String formatDateString(String oldDate) {
    var formatterOld =  DateFormat('yyyy-MM-dd\'T\'HH:mm:ss');
    DateTime date = formatterOld.parse(oldDate);
    var formatter =  DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }
  DateTime formatDateGlobal(String oldDate) {
    var formatterOld =  DateFormat('yyyy-MM-dd\'T\'HH:mm:ss');
    DateTime date = formatterOld.parse(oldDate);
    return date;
  }

  HijriCalendar getDateHijri(DateTime date){
    return HijriCalendar.fromDate(date);
  }

  String formatTime(TimeOfDay time) {
    var formatter = new DateFormat('HH:mm:ss');
    String formattedDate = formatter.format(DateTime(0,0,0,time.hour, time.minute, 0 ));
    return formattedDate;
  }
  TimeOfDay parseTime(String oldDate) {
    var formatterOld =  DateFormat('HH:mm:ss');
    DateTime date = formatterOld.parse(oldDate);
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }
  //--------------map--------------
  Map<String, dynamic> cleanInputMap(Map<String, dynamic> input,
      {bool isFormData = true}) {
    Map<String, dynamic> output = {};

    for (var entry in input.entries) {
      if (null != entry.value &&
          "null" != entry.value.toString() &&
          [] != entry.value &&
          '[]' != entry.value.toString() &&
          entry.value
              .toString()
              .isNotEmpty) {
        if (entry.value is List<dynamic> && isFormData) {
          List<dynamic> array = entry.value;
          for (int i = 0; i < array.length; i++) {
            output.addEntries(
                {MapEntry('${entry.key}[$i]', array[i])});
          }
        } else {
          output.addEntries({MapEntry(entry.key, entry.value)});
        }
      }
    }

    return output;
  }

  String? getMapValue(Map<String, String> map, String? key) {
    if (null == key) return null;
    String? value = (map.containsKey(key)) ? map[key] : key.toLowerCase();
    return value;
  }

  String? getMapKey(Map<String, String> map, String? value) {
    if (null == value) return null;
    String? key = map.keys.firstWhereOrNull(
            (k) => (map[k] ?? "").toLowerCase() == value.toLowerCase());

    return (key == "") ? null : key;
  }

  //-----------------------------

  Future<Uint8List> loadImageNetwork(String imgName) async {
    Response response = await get(Uri.parse('$imgName'));
    return response.bodyBytes;
  }

  //-------
  String getDistanceDimen(double? distance) {
    double dist = distance ?? 0.0;

    if (dist == 0) return "";

    if (dist < 1 && dist > 0) {
      dist = dist * 1000;
      return "$dist m";
    }
    return "$dist Km";
  }

  String getPrice(double? price) {
    double _price = price ?? 0.0;
    return "$_price SAR";
  }


  double? roundNumber(int round, String value) {
    double? num = double.tryParse(value);
    if (null == num) return num;
    String newNum = num.toStringAsFixed(round);
    return double.tryParse(newNum);
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void hideKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<bool> getDistance(double latitude, double longitude) async{
    try {
      Location location = new Location();
      bool locationPermission = await getPermission(Permission.location);

      if (locationPermission == false) {
        return false;
      }
      print("locationPermission: $locationPermission");

      LocationData _locationData = await location.getLocation();
      print("step 1");
      double distance = Geolocator.distanceBetween(
        latitude,
        latitude,
        _locationData.latitude ?? 0,
        _locationData.longitude ?? 0,
      );
      ////"Latitude":29.278984,"Longitude":34.933913
      print("Location:: ${_locationData.latitude} - ${_locationData.longitude}");
      print("Dustanse: $distance");

      return (distance) < 100.0; //100.0
    }catch(e){
      return false;
    }
  }

  static Future<List<double>?> getMyLocation() async{
    Location location = new Location();
    bool locationPermission = await getPermission(Permission.location);

    if(locationPermission == false){
      return null;
    }
    print("locationPermission: $locationPermission");
    LocationData _locationData = await location.getLocation();
    print("step 1");
    print("Location:: ${_locationData.latitude} - ${_locationData.longitude}") ;
    List<double> loc = [] ;
    loc.add(_locationData.latitude ?? 0);
    loc.add(_locationData.longitude ?? 0);

    return loc;
  }


  static viewToast(BuildContext context,{String? content,Color? backgroundColor, double? fontSize, int? toastTime}) {
    showToast("${content ?? ""}",
        context: context,
        duration:(null != toastTime) ? Duration(seconds: toastTime) :  Duration(seconds: 3));
  }


}

void appLog(String value) {
  log("$value");
  //
}

