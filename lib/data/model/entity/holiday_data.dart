import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class HolidayData {
  String? datereq;
  int? empid;
  int? dbbossid;
  int? adminAffairsBossId;
  int? empsupport;
  int? bossid;
  String? startDate;
  String? startHdate;
  String? endDate;
  String? endHdate;
  int? briod;
  int? hstatues;
  String? hstatuestext;
  String? dbbcancle;
  String? bcancle;
  int? holdaytype;
  int? id;


  HolidayData({
    this.datereq,
    this.empid,
    this.dbbossid,
    this.adminAffairsBossId,
    this.empsupport,
    this.bossid,
    this.startDate,
    this.startHdate,
    this.endDate,
    this.endHdate,
    this.briod,
    this.hstatues,
    this.hstatuestext,
    this.dbbcancle,
    this.bcancle,
    this.holdaytype,
    this.id,

  });

  static HolidayData fromJson(Map<String, dynamic> json) {
    try {
      return HolidayData(
          datereq: json['datereq'],
          empid: json['empid'],
          dbbossid: json['dbbossid'],
          adminAffairsBossId: json['adminAffairsBossId'],
          empsupport: json['empsupport'],
          bossid: json['bossid'],
          startDate: json['startDate'],
          startHdate: json['startHdate'],
          endDate: json['endDate'],
          endHdate: json['endHdate'],
          briod: json['briod'],
          hstatues: json['hstatues'],
        hstatuestext: json['hstatuestext'],
        dbbcancle: json['dbbcancle'],
        bcancle: json['bcancle'],
        holdaytype: json['holdaytype'],
        id: json['id'],

      );
    } catch (e) {
      appLog("Error parsing HolidayData: ${e.toString()}");
      return HolidayData();
    }
  }

  Map<String, dynamic> toJson() => {
        'datereq': datereq,
        'empid': empid,
      };

  String encodeJson() => json.encode(toJson());

  static HolidayData decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$empid";
}
