import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sky_vacation/base/base_exception.dart';
import 'package:sky_vacation/data/model/entity/company.dart';
import 'package:sky_vacation/helper/app_constant.dart';
import 'package:sky_vacation/helper/app_util.dart';
import 'package:sky_vacation/helper/user_constant.dart';
import 'package:http/http.dart';
import '../../main.dart';
import 'api_method.dart';
import 'api_urls.dart';

class ApiRepo {
  final Client client;

  ApiRepo(this.client);

  Map<String, String> header = {};

  Future<String> call(ApiMethod method, String endPoint,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queries,
      List<MultipartFile>? images,
      bool isFormData = false,
      bool isBaseApi = false,
      bool addLang = true,
      bool isNewResponse = true}) async {
    try {
      String token = sm.getValue(UserConstant.accessToken);
      if (token.isNotEmpty)
        header = {...header, 'Authorization': 'Bearer $token'};
      if (!isFormData) {
        header = {...header, 'Content-type': 'application/json'};
      } else {
        header.remove('Content-type');
      }


      Company? company = sm.getCompany();

      String urlPath = (isBaseApi)
          ? "${Urls.baseUrl}$endPoint"
          : "${company?.Url}$endPoint";
      if(addLang)urlPath = "$urlPath?lang=$currentLocale";

      String encodedUri = Uri.encodeFull(urlPath);
      Uri uri = Uri.parse(encodedUri);
      // if (uri.scheme == "https") {
      //   uri = Uri.https(uri.authority, uri.path, queries);
      // } else {
      //   uri = Uri.http(uri.authority, uri.path, queries);
      // }

      Response response;
      StreamedResponse streamedResponse;
      String responseString;
      int statusCode = 0;

      switch (method) {
        case ApiMethod.get:
          response = await get(uri, headers: header);
          statusCode = response.statusCode;
          responseString = response.body;
          break;
        case ApiMethod.delete:
          response = await delete(uri, headers: header);
          statusCode = response.statusCode;
          responseString = response.body;
          break;
        case ApiMethod.post:
          response = await post(uri,
              body: (isFormData) ? body : json.encode(body),
              headers: header); //
          statusCode = response.statusCode;
          responseString = response.body;
          break;
        case ApiMethod.put:
          response = await put(uri,
              body: (isFormData) ? body : json.encode(body), headers: header);
          statusCode = response.statusCode;
          responseString = response.body;
          break;
        case ApiMethod.multipart:
          appLog("multipart");
          var request = MultipartRequest(
            "POST",
            uri,
          );
          request.headers.addAll(header);
          if (null != body && body.isNotEmpty) {
            request.fields.addAll(body as Map<String, String>);
          }
          if (null != images && images.isNotEmpty) {
            request.files.addAll(images);
            appLog("request.files.");
          }

          streamedResponse = await request.send();
          var responseData = await streamedResponse.stream.toBytes();
          statusCode = streamedResponse.statusCode;
          responseString = String.fromCharCodes(responseData);
          break;
      }

      appLog("Request Header: $header");
      appLog("Request Url: $method - $urlPath");
      if (null != queries) appLog("Request Queries: $queries");
      if (null != body)
        appLog("Request Body: ${(isFormData) ? body : json.encode(body)}");
      appLog("Response: $statusCode - $responseString");

      if (statusCode >= 200 && statusCode < 400) {
        if(!isNewResponse) {
          return responseString;
        }else{
          Map<String, dynamic> map = jsonDecode(responseString);
          if ( map.containsKey("result") && map["result"]['response_code'] == "200" ) {
            return json.encode(map["result"]["response_data"]);
          }else if ( map.containsKey("result") && map["result"]['response_message'].toString().isNotEmpty ) {
            throw BaseException(map["result"]['response_message']);
          }else{
            throw BaseException('codeBadRequest');
          }
        }
      }

      if (statusCode == 401 ||
          responseString
              .contains("Current user did not login to the application")) {
        Phoenix.rebirth(appContext!);
        throw UnAuthException();
      }
      if (statusCode == 404) {
        return responseString;
      } else {
        appLog("Step 4");
        throw BaseException('codeBadRequest');
      }
    } on SocketException catch (_) {
      throw BaseException('no_internet_connection');
    }
  }
}
