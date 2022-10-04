import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class NotificationCounter {
  String? actionValue;
  String? actionName;


  NotificationCounter({
    this.actionValue,
    this.actionName,
  });

  static NotificationCounter fromJson(Map<String, dynamic> json) {
    try {
      return NotificationCounter(
          actionValue: json['actionValue'],
          actionName: json['actionName'],

      );

    } catch (e) {
      appLog("Error parsing NotificationCounter: ${e.toString()}");
      return NotificationCounter();
    }
  }

  Map<String, dynamic> toJson() => {
      };

  String encodedJson() => json.encode(toJson());

  static NotificationCounter decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$actionValue";
}
