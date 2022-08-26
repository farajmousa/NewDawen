import 'dart:convert';

import 'package:sky_vacation/main.dart';
import 'package:sky_vacation/helper/app_util.dart';

class LocationData {
  int? id;
  String? name;
  String? latitude;
  String? longitude;

  LocationData({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
  });

  static LocationData fromJson(Map<String, dynamic> json) {
    try {
      return LocationData(
          id: json['id'],
          name: json['name']??json['name'],
          latitude: json['latitude'],
          longitude: json['longitude'],
      );

    } catch (e) {
      appLog("Error parsing LocationData: ${e.toString()}");
      return LocationData();
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  String encodedJson() => json.encode(toJson());

  static LocationData decodedJson(String source) => fromJson(json.decode(source));

  @override
  String toString() => "$name";
}
