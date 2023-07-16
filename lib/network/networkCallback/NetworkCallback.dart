import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:leen_alkhier_store/network/client/ApiClient.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class NetworkCall {
  static Future<Map<String, dynamic>?> makeCall(
      {String? endPoint,
      HttpMethod? method,
      dynamic requestBody,
      Map<String, dynamic>? queryParams,
      bool isMultipart = false,
      List<MultipartFile>? multiPartValues}) async {
    try {
   //   print(" endPoint : ${endPoint}");
      Response response;
      if (method == HttpMethod.GET) {

   //   print("queryParams : ${queryParams}");
        response = (await ApiClient.getRequest(endPoint, queryParams));
    //  print("HttpMethod.GET response : ${response.body}");
      }
      else {
        response = (await ApiClient.postRequest(endPoint, requestBody,
            isMultipart: isMultipart, multiPartValues: multiPartValues));
        if (endPoint == "api/v3/assign_product") {
          contractProductsList = [];
        }
    print("postRequest response : ${response.body}");
      }

      if (response.statusCode == NetworkStatusCodes.OK_200.value) {
        return jsonDecode(response.body);
      } else if (response.statusCode ==
              NetworkStatusCodes.ServerInternalError.value ||
          response.statusCode == NetworkStatusCodes.BadRequest.value) {
        //  log("API POST Error:${response.body}");

        return jsonDecode(response.body);
      } else if (response.statusCode ==
          NetworkStatusCodes.UnAuthorizedUser.value) {
        var result = jsonDecode(response.body) as Map<String, dynamic>;
        result['error'] = {"code": response.statusCode};
        return result;
      } else {
        return jsonDecode(response.body);
      }
    } on SocketException catch (_) {
      return {
        "success": false,
        "error": {
          "code": 0,
          "message":
              "No internet connection, please check you network and try again",
          "details": ""
        }
      };
    }
  }
}
