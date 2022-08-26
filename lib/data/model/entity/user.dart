
import 'dart:convert';

import 'package:sky_vacation/helper/app_util.dart';

class User{
 int? usId;
 int?  depId;
 int? shiftId;
 String? name, image, job, department, year;
bool? active, audit, imageRequired;

 User({this.usId, this.name, this.image, this.job, this.department, this.year, this.active,
  this.audit, this.imageRequired, this.depId, this.shiftId});


 static User fromJson(Map<String, dynamic> json) {
  try {
   return User(
       usId: json['usId'],
       depId: json['depId'],
       shiftId: json['shiftId'],
       name: json['name'] ,
       image: json['image'] ,
       job: json['job'] ,
       department: json['department'] ,
       year: json['year'] ,
       active: json['active'],
       audit: json['audit'] ,
       imageRequired: json['imageRequired'] );

  } catch (e) {
   appLog("Error parsing IdName: ${e.toString()}");
   return User();
  }
 }

 Map<String, dynamic> toJson() => {
  'usId': usId,
  'depId': depId,
  'shiftId': shiftId,
  'name': name,
  'image': image,
  'job': job,
  'department': department,
  'year': year,
  'active': active,
  'audit': audit,
  'imageRequired': imageRequired
 };

 String encodedJson() => json.encode(toJson());

 static User decodedJson(String source) => fromJson(json.decode(source));



 @override
  String toString() {
    return 'User{usId: $usId, name: $name, photo: $image, job: $job, department: $department, year: $year, Active: $active, Audit: $audit, ImageRequired: $imageRequired}';
  }
}

