import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/Settings.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';

import '../ServicesURLs.dart';

class ApiClient {
  static Map<String, String?> headers() {
    var mHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    mHeaders["lang"] = MyMaterial.app_langauge ?? 'ar';

/*    mHeaders["lang"] = (MyMaterial.app_langauge != null
        ? MyMaterial.app_langauge
        : "ar")!;*/

    if (TokenUtil.getTokenFromMemory()!.isNotEmpty) {
      mHeaders[HttpHeaders.authorizationHeader] =
          "Bearer ${TokenUtil.getTokenFromMemory()}";
    }
    return mHeaders;
  }

  static Future<Response> getRequest(
      String? endPoint, Map<String, dynamic>? queryParams) async {
    //create url with (baseUrl + endPoint) and query Params if any

    Uri url = Uri(
        scheme: ServicesURLs.development_environment_scheme,
        host: ServicesURLs.development_environment_without_http,
        // port: ServicesURLs.development_environment_port,
        path: endPoint,
        queryParameters: queryParams);
    //network logger
    //GET network request call
  //  print("headers() : ${headers()}");
    final response =
        await http.get(url, headers: headers() as Map<String, String>?);
    return response;
  }

  static Future<http.Response> postRequest(
      String? endPoint, dynamic requestBody,
      {bool isMultipart = false,
      List<http.MultipartFile>? multiPartValues}) async {
    Uri url = Uri(
        scheme: ServicesURLs.development_environment_scheme,
        host: ServicesURLs.development_environment_without_http,
        // port: ServicesURLs.development_environment_port,
        path: endPoint);

    if (requestBody != null) log(requestBody.toString());
    //POST network request call

    var response;
    if (!isMultipart) {
      log("**NotMultipart**");
   //   print("headers() : ${headers()}");
      response = await http.post(url,
          headers: headers() as Map<String, String>?, body: requestBody);
     print("request : ${response}");
    } else {
      Map<String, dynamic> p = jsonDecode(requestBody);
      Map<String, String> convertedMap = {};
      p.forEach((key, value) {
        convertedMap[key] = value;
      });

      log("multiPartValues: ${multiPartValues}");
   //   print("headers() : ${headers()}");
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers() as Map<String, String>)
        ..fields.addAll(convertedMap)
        ..files.addAll(multiPartValues!);
     print("request : ${request}");

      response = await http.Response.fromStream(await request.send());
    }
  //  print("fromStream response : ${response}");
    return response;
  }
}
