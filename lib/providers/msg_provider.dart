import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/all_msg_response.dart';
import 'package:leen_alkhier_store/data/responses/send_msg_response.dart';
import 'package:leen_alkhier_store/repos/more_repos.dart';

class MsgProvider extends ChangeNotifier {
  SendMsgResponse? sendMsgResponse;
  AllMsgResponse? allMsgResponse;

  Future<SendMsgResponse?> sendMsg({String? msg}) async {
    sendMsgResponse = await MoreRepository.sendMsg(message: msg);

    return sendMsgResponse;
  }

  Future<AllMsgResponse?> getAllMsgs() async {
    allMsgResponse = await MoreRepository.getMsgs();

    return allMsgResponse;
  }
}
