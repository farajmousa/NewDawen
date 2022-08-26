import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

import '../../../helper/app_constant.dart';

class NotificationData {
  int? id;
  String? title;
  String? message;
  String? user_id;
  String? date;
  int? requestId;

  NotificationData({
    this.id,
    this.title,
    this.message,
    this.user_id,
    this.date,
    this.requestId
  });

  static NotificationData fromJson(Map<String, dynamic> json) {
    try {
      return NotificationData(
          id: json['id'],
          title: (currentLocale == AppLocale.EN)?json['logName'] : json['logAName'],
          message: (currentLocale == AppLocale.EN)?json['logDescription'] : json['logADescription'],
          user_id: json['user_id'],
          date: json['logDate'],
          requestId: json['requestId']
      );
    } catch (e) {
      appLog("Error parsing NotificationData: ${e.toString()}");
      return NotificationData();
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };

  String encodeJson() => json.encode(toJson());

  static NotificationData decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$title";
}
