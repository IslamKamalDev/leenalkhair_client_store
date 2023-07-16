import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:leen_alkhier_store/data/responses/all_msg_response.dart';
import 'package:leen_alkhier_store/providers/msg_provider.dart';
import 'package:leen_alkhier_store/providers/notification_bloc.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'dart:ui' as ui;
class Chat extends StatefulWidget {
  bool isContact;

  Chat({this.isContact = false});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final scrollController = ScrollController();

  var names = ['ahmed', 'mohamed', 'mustafa', 'ibrahim'];

  var msgController = TextEditingController();
  var msgKey = GlobalKey<ScaffoldState>();
  AllMsgResponse? allMsgResponse;
  Stream<LocalNotification>? _notificationsStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var msgProvider = Provider.of<MsgProvider>(context, listen: false);
    _notificationsStream = NotificationsBloc.instance.notificationsStream;

    _notificationsStream!.listen((notification) {
      // TODO: Implement your logic here
      log('Chat Notification: $notification');
      if (mounted && allMsgResponse != null) {
        allMsgResponse!.data!
            .add(Data(content: notification.msg, userType: notification.type));
        setState(() {});
        scrollToBottom();
      }
    });
    msgProvider.getAllMsgs().then((value) {
      //print("AllMsgStatus:${allMsgResponse.status}");
      allMsgResponse = value;
      setState(() {});
      if (value!.status!) {
        scrollToBottom();
      }
    });
  }

  void scrollToBottom() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var msgProvider = Provider.of<MsgProvider>(context);

    return Directionality(
        textDirection: translator.activeLanguageCode == 'ar'?ui.TextDirection.rtl : ui.TextDirection.ltr,
        child:Scaffold(
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomViews.appBarWidget(
        context: context,
        title: "chat_us",
        route: More(),
      ) ,
      body: Card(
        elevation: 10,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [

                    Expanded(
                        child: (allMsgResponse == null)
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : (allMsgResponse!.status == false)
                            ? Center(
                          child: Text(allMsgResponse!.message!),
                        )
                            : ListView(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          children: [
                            ...allMsgResponse!.data!.map((e){
                              if   (e.userType == "user"){
                            return    Container(
                                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                                  child: Align(
                                    alignment: (e.userType == "admin"?Alignment.topLeft:Alignment.topRight),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: (e.userType  == "user"?CustomColors.YELLOW_LIGHT:CustomColors.SECONDART_GREEN),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Text(e.content!, style: TextStyle(fontSize: 15),),
                                    ),
                                  ),
                                );
                              }else{
                                return      Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil.defaultSize.width * 0.02
                                      , vertical: ScreenUtil.defaultSize.width * 0.03),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                      color: CustomColors.SECONDART_GREEN),
                                  child:   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: ScreenUtil.defaultSize.width * 0.75,
                                        child: Text(e.content!),
                                      ),
                                      Image(image: AssetImage(ImageAssets.chat_image,), width: ScreenUtil.defaultSize.width * 0.1,
                                        height: ScreenUtil.defaultSize.width * 0.1,),

                                    ],
                                  ),
                                );
                              }

                            },
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Divider(),
            Directionality(
              textDirection:(translator.activeLanguageCode == "en")
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              child: CustomTextField(

                  onFieldSubmitted: (){
                    if (msgController.text.isNotEmpty) {
                      FocusScope.of(context).unfocus();
                      if (allMsgResponse!.data == null) {
                        allMsgResponse!.data = [];
                        allMsgResponse!.status = true;
                      }
                      allMsgResponse!.data!.add(Data(
                          content: msgController.text, userType: "user"));

                      setState(() {});
                      scrollToBottom();
                      msgProvider
                          .sendMsg(msg: msgController.text)
                          .then((value) {
                        if (!value!.status!) {
                          names.removeLast();
                          CustomViews.showSnackBarView(
                              title_status: false,
                              message: 'حدث خطأ في الإرسال',
                              backgroundColor: CustomColors.RED_COLOR,
                              success_icon: false
                          );

                        }
                      });
                      msgController.clear();
                    }
                  },
                  chat: true,
                  lablel: "type_msg".tr(),
                  controller: msgController,
                  hasBorder: false,

                  icon: IconButton(
                    onPressed: () {
                      if (msgController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();

                        if (allMsgResponse!.data == null) {
                          allMsgResponse!.data = [];
                          allMsgResponse!.status = true;
                        }
                        allMsgResponse!.data!.add(Data(
                            content: msgController.text, userType: "user"));

                        setState(() {});
                        scrollToBottom();
                        msgProvider
                            .sendMsg(msg: msgController.text)
                            .then((value) {
                          if (!value!.status!) {

                            names.removeLast();
                            CustomViews.showSnackBarView(
                                title_status: false,
                                message: 'حدث خطأ في الإرسال',
                                backgroundColor: CustomColors.RED_COLOR,
                                success_icon: false
                            );
                          }
                        });
                        msgController.clear();
                      }
                    },

                    icon: Directionality(
                      textDirection:  (translator.activeLanguageCode == "en")
                          ? ui.TextDirection.ltr
                          : ui.TextDirection.rtl,
                      child: Icon(
                        Icons.send,
                        color: CustomColors.PRIMARY_GREEN,
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      )
        )
    );
  }
}