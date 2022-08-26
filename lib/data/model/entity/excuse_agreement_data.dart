import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class ExcuseAgreementData {
  String? empName;
  String? excwhy;
  String? typename;
  String? edate;
  String? shName;
  String? exstatuestext;
  int? id;

  ExcuseAgreementData({
    this.empName,
    this.excwhy,
    this.shName,
    this.typename,
    this.edate,
    this.exstatuestext,
    this.id,
  });

  static ExcuseAgreementData fromJson(Map<String, dynamic> json) {
    try {
      return ExcuseAgreementData(
        empName: json['empName'],
        excwhy: json['excwhy'],
        shName: json['shName'],
        typename: json['typename'],
        edate: json['edate'],
        exstatuestext: json['exstatuestext'],
        id: json['id'],
      );
    } catch (e) {
      appLog("Error parsing ExcuseAgreementData: ${e.toString()}");
      return ExcuseAgreementData();
    }
  }

  Map<String, dynamic> toJson() => {
        'empName': empName,
        'excwhy': excwhy,
      };

  String encodeJson() => json.encode(toJson());

  static ExcuseAgreementData decodedJson(String source) =>
      fromJson(json.decode(source));

  @override
  String toString() => "$excwhy";
}
