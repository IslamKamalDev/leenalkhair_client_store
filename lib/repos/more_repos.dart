import 'dart:async';
import 'dart:convert';

import 'package:leen_alkhier_store/data/responses/all_msg_response.dart';
import 'package:leen_alkhier_store/data/responses/send_msg_response.dart';
import 'package:leen_alkhier_store/data/responses/suggest_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class MoreRepository {
  static Future<SuggestResponse> sendNotes({String? note}) async {
    return SuggestResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/add_suggestion",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"details": note}))));
  }

  static Future<SendMsgResponse> sendMsg({String? message}) async {
    return SendMsgResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/save_message",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"message": message}))));
  }

  static Future<AllMsgResponse> getMsgs() async {
    return AllMsgResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/messages",
      method: HttpMethod.GET,
    )));
  }
}
