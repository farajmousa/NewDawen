import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class HolidayAgreementData {
  String? empName;
  int? period;
  String? hname;
  String? empsup;
  int? empsupport;
  String? startHDate;
  int? id;

  HolidayAgreementData({
    this.empName,
    this.period,
    this.empsupport,
    this.hname,
    this.empsup,
    this.startHDate,
    this.id,
  });

  static HolidayAgreementData fromJson(Map<String, dynamic> json) {
    try {
      return HolidayAgreementData(
        empName: json['empName'],
        period: json['period'],
        empsupport: json['empsupport'],
        hname: json['hname'],
        empsup: json['empsup'],
        startHDate: json['startHDate'],
        id: json['id'],
      );
    } catch (e) {
      appLog("Error parsing HolidayAgreementData: ${e.toString()}");
      return HolidayAgreementData();
    }
  }

  Map<String, dynamic> toJson() => {
        'empName': empName,
        'period': period,
      };

  String encodeJson() => json.encode(toJson());

  static HolidayAgreementData decodedJson(String source) =>
      fromJson(json.decode(source));

  @override
  String toString() => "$period";
}
