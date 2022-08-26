import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class IdName {
  int? id;
  String? name;
  String? Type;
  String? code;
  String? image_path;

  IdName({
    this.id,
    this.name,
    this.Type,
    this.code,
    this.image_path,
  });

  static IdName fromJson(Map<String, dynamic> json) {
    try {
      return IdName(
          id: json['id'],
          name: json['name']??json['fullUserName'],
          Type: json['Type'],
          code: json['code'],
          image_path: json['image_path'],
      );

    } catch (e) {
      appLog("Error parsing IdName: ${e.toString()}");
      return IdName();
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  String encodedJson() => json.encode(toJson());

  static IdName decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$name";
}
