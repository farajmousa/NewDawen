import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class ExcuseData {
  String? excwhy;
  int? empid;
  int? dbbossid;
  int? dbbossIdd;
  int? adminAffairsBossId;
  int? empsupport;
  int? bossid;
  String? stime;
  String? etime;
  String? edate;
  String? ehdate;
  int? typeid;
  int? exstatues;
  String? exstatuestext;
  String? dbbcancle;
  String? bcancle;
  int? shiftid;
  int? id;

  ExcuseData({
    this.excwhy,
    this.empid,
    this.dbbossid,
    this.dbbossIdd,
    this.adminAffairsBossId,
    this.empsupport,
    this.bossid,
    this.stime,
    this.etime,
    this.edate,
    this.ehdate,
    this.typeid,
    this.exstatues,
    this.exstatuestext,
    this.dbbcancle,
    this.bcancle,
    this.shiftid,
    this.id,
  });

  static ExcuseData fromJson(Map<String, dynamic> json) {
    try {
      return ExcuseData(
        excwhy: json['excwhy'],
        empid: json['empid'],
        dbbossid: json['dpbossid'],
        dbbossIdd: json['dpbossid'],
        adminAffairsBossId: json['adminAffairsBossId'],
        empsupport: json['empsupport'],
        bossid: json['bossid'],
        stime: json['stime'],
        etime: json['etime'],
        edate: json['edate'],
        ehdate: json['ehdate'],
        typeid: json['typeid'],
        exstatues: json['exstatues'],
        exstatuestext: json['exstatuestext'],
        dbbcancle: json['dbbcancle'],
        bcancle: json['bcancle'],
        shiftid: json['shiftid'],
        id: json['id'],
      );
    } catch (e) {
      appLog("Error parsing ExcuseData: ${e.toString()}");
      return ExcuseData();
    }
  }

  // Map<String, dynamic> toJson() => {
  //       'datereq': excwhy,
  //       'empid': empid,
  //     };

  // String encodeJson() => json.encode(toJson());

  static ExcuseData decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$empid";
}
