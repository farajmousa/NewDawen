
import 'dart:convert';

import 'package:sky_vacation/helper/app_util.dart';

class Company{
 int? Id;
 String? CompCode, CompName, Url, CompLogo;


 Company({this.Id, this.CompCode, this.CompName, this.Url, this.CompLogo, });

 static Company fromJson(Map<String, dynamic> json) {
  try {
   return Company(
    Id: json['Id'],
    CompCode: json['CompCode'],
    CompName: json['CompName'],
    Url: json['Url'],
    CompLogo: json['CompLogo'],
   );

  } catch (e) {
   appLog("Error parsing IdName: ${e.toString()}");
   return Company();
  }
 }
 
 Map<String, dynamic> toJson() => {
  'Id': Id,
  'CompCode': CompCode,
  'CompName': CompName,
  'Url': Url,
  'CompLogo': CompLogo,
 };

 String encodedJson() => json.encode(toJson());

 static Company decodedJson(String source) => fromJson(json.decode(source));

 
 @override
  String toString() {
    return 'Company{Id: $Id, CompCode: $CompCode, CompName: $CompName, Url: $Url, CompLogo: $CompLogo}';
  }

}
