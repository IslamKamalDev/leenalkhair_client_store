import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:leen_alkhier_store/providers/notes_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class Suggesstions extends StatefulWidget {
  @override
  _SuggesstionsState createState() => _SuggesstionsState();
}

class _SuggesstionsState extends State<Suggesstions> {
  var noteController = TextEditingController();

  var suggestScaffoldKey = GlobalKey<ScaffoldState>();

  final suggestFormKey = GlobalKey<FormState>();

  FocusNode fieldFocus = FocusNode();


  List<SocialMedia> images = [];


  @override
  void initState() {
    var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    images = [SocialMedia(
        image: ImageAssets.call,
        link: userInfoProvider.appVersionResponse!.mobileNumber
    ),SocialMedia(
        image: ImageAssets.whatsapp,
        link: userInfoProvider.appVersionResponse!.whatsapp
    ),
      SocialMedia(
          image: ImageAssets.twitter,
          link: userInfoProvider.appVersionResponse!.twitter
      ),
      SocialMedia(
          image: ImageAssets.instagram,
          link:userInfoProvider.appVersionResponse!.instgram
      )];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var noteProvider = Provider.of<NoteProvider>(context);
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:Scaffold(
      key: suggestScaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomViews.appBarWidget(
          context: context,
          title: "suggests",
        route: More(),
      ) ,
      body: SafeArea(
        bottom: false,

        child: SingleChildScrollView(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: suggestFormKey,
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [


                  Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.defaultSize.width * 0.1),
                  child:    Container(
                    color: CustomColors.WHITE_COLOR,
                    child:  TextFormField(
                      controller: noteController,
                      onTap: (){
                        if(noteController.selection == TextSelection.fromPosition(TextPosition(offset: noteController.text.length -1))){
                          setState(() {
                            noteController.selection = TextSelection.fromPosition(TextPosition(offset: noteController.text.length));
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Plz_enter_the_note";
                        }
                        return null;
                      },
                      minLines: 8,
                      maxLines: 10,

                      keyboardType: TextInputType.multiline,
                      focusNode: fieldFocus,
                      decoration: InputDecoration(
                        hintText:"Plz_enter_the_note".tr(),
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                        ),
                      ),
                    ),
                  ),
                  ),
                      SizedBox(height: ScreenUtil.defaultSize.width * 0.1,),
                      CustomRoundedButton(
                        fontSize: 15,
                        backgroundColor: CustomColors.PRIMARY_GREEN,
                        borderColor: CustomColors.PRIMARY_GREEN,
                        text: ksend,
                        textColor: Colors.white,
                        pressed: () async {
                          FocusScope.of(context).unfocus();

                          if (!suggestFormKey.currentState!.mounted)
                            suggestFormKey.currentState!.build(context);
                          if (suggestFormKey.currentState!.validate()) {
                            CustomViews.showLoadingDialog(context: context);
                            await noteProvider
                                .setNote(note: noteController.text)
                                .whenComplete(() =>
                                CustomViews.dismissDialog(
                                    context: context))
                                .then((value) {
                              if (noteProvider.suggestResponse != null &&
                                  noteProvider.suggestResponse!.message == "successful") {

                                CustomViews.showSnackBarView(
                                    title_status: true,
                                    message: 'success_suggest',
                                    backgroundColor: CustomColors.PRIMARY_GREEN,
                                    success_icon: true
                                );
                                Navigator.pop(context);
                              } else {

                                CustomViews.showSnackBarView(
                                    title_status: false,
                                    message: 'error_suggest',
                                    backgroundColor: CustomColors.RED_COLOR,
                                    success_icon: false
                                );

                              }
                            });
                          }
                        },
                      ),

             Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.defaultSize.width * 0.05),
             child:   Container(
               height: ScreenUtil.defaultSize.width * 0.1,
               //      width: ScreenUtil.defaultSize.width * 0.8,
               child:     ListView.builder(
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemCount: images.length,
                 itemBuilder: (context, index) {
                   return IconButton(
                     icon: FaIcon(
                       index == 0? FontAwesomeIcons.squarePhone :
                       index == 1 ?FontAwesomeIcons.squareWhatsapp :
                       index == 2 ? FontAwesomeIcons.squareTwitter :
                       index == 3 ? FontAwesomeIcons.squareInstagram  : FontAwesomeIcons.squareInstagram ,
                       color:
                       index == 0? Color(0xFF89BFB3) :
                       index == 1? Color(0xFF4F8E54) :
                       index == 2? Color(0xFF5AA8D1) :
                       index == 3? Color(0xFFC64B96) : Color(0xFFC64B96),
                       size: ScreenUtil.defaultSize.width * 0.1,
                     ),
                     onPressed: () {
                       switch (index) {
                         case 0:
                           _launchURL(
                               'tel:${images[index].link}');
                           break;
                         case 1:
                           _launchURL(
                               "whatsapp://send?phone=${images[index].link}"
                           );
                           break;
                         case 2:
                           _launchURL(images[index].link!);
                           break;
                         case 3:
                           _launchURL(images[index].link!);
                           break;
                       }
                     },
                   );
                 },
               ),
             ),)
                    ],
                  ),),
              )),
        )
      ),
        )  );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SocialMedia{
  String? image;
  String? link;
  SocialMedia({this.image,this.link});
}