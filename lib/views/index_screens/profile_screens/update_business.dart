import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:leen_alkhier_store/data/requests/business_register_request.dart';
import 'package:leen_alkhier_store/data/responses/business_info_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/business_info_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/sector_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/map_dialog.dart';
import 'package:leen_alkhier_store/views/widgets/pdf_viewer.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UpdateBusiness extends StatefulWidget {
  String? businessStatus;
  UpdateBusiness({this.businessStatus});
  @override
  _SignupCompanyState createState() => _SignupCompanyState();
}

class _SignupCompanyState extends State<UpdateBusiness> {
  var updateCompanyFormKey = GlobalKey<FormState>();

  var updateCompanyScaffoldKey = GlobalKey<ScaffoldState>();

  var registerationNumberController = TextEditingController();

  var companyNameController = TextEditingController();
  var taxNumberController = TextEditingController();

  var tradeMarkController = TextEditingController();

  var notesController = TextEditingController();

  Files? commerical;
  Files? tax;
  String commerical_remotePDFpath = "";
  String tax_remotePDFpath = "";
  String? commerical_image_url;
  String? tax_image_url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var businessInfoProvider =
        Provider.of<BusinessInfoProvider>(context, listen: false);
    var sectorsProvider = Provider.of<SectorProvider>(context, listen: false);
    registerationNumberController.text =
        businessInfoProvider.businessInfoResponse!.data!.registrationNumber!;
    companyNameController.text =
        businessInfoProvider.businessInfoResponse!.data!.name!;
    taxNumberController.text =
        businessInfoProvider.businessInfoResponse!.data!.taxNumber.toString();

    notesController.text =
        businessInfoProvider.businessInfoResponse!.data!.notes!;
    tradeMarkController.text =
        businessInfoProvider.businessInfoResponse!.data!.tradeMark!;

    var citiesProvider = Provider.of<CitiesProvider>(context, listen: false);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context, listen: false);

    businessInfoProvider.businessInfoResponse!.data!.files!.forEach((element) {
      if(element.type == "commercial"){
        commerical = element;
        if(commerical!.fileName!.split('.')[1] == "pdf"){
          createFileOfPdfUrl(
            path: commerical!.fileUrl
          ).then((f) {
            setState(() {
              commerical_remotePDFpath = f.path;
              print("commerical remotePDFpath : ${commerical_remotePDFpath}");
            });
          });
        }else{
          commerical_image_url = element.fileUrl;
          print("commerical image_url : ${commerical_image_url}");
        }

      }else{
        tax = element;
        if(tax!.fileName!.split('.')[1] == "pdf"){
          createFileOfPdfUrl(
              path: tax!.fileUrl
          ).then((f) {
            setState(() {
              tax_remotePDFpath = f.path;
              print(" tax remotePDFpath : ${tax_remotePDFpath}");
            });
          });
        }else{
          tax_image_url = element.fileUrl;
          print("tax image_url : ${tax_image_url}");
        }
      }
    });
    Future.delayed(Duration(seconds: 0), () {
      businessInfoProvider.changeBusinessLocation(LatLng(
          double.parse(
              businessInfoProvider.businessInfoResponse!.data!.latitude!),
          double.parse(
              businessInfoProvider.businessInfoResponse!.data!.longitude!)));

      userRegisterationProvider.changeCity(citiesProvider.citiesResponse.data!
          .firstWhere((element) =>
              element.id ==
              businessInfoProvider.businessInfoResponse!.data!.city!.id));

      sectorsProvider.changeSector(sectorsProvider.sectorResponse.sector!
          .firstWhere((element) =>
              element.id ==
              businessInfoProvider
                  .businessInfoResponse!.data!.sectorId)); // change to sector
    });
  }

  @override
  Widget build(BuildContext context) {
    var businessInfoProvider = Provider.of<BusinessInfoProvider>(context);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context);
    var citiesProvider = Provider.of<CitiesProvider>(context);
    var sectorsProvider = Provider.of<SectorProvider>(context);

    return Directionality(
      textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child:SafeArea(
      bottom: false,
      child: Scaffold(
        key: updateCompanyScaffoldKey,
        backgroundColor: CustomColors.GREY_COLOR_A,
       appBar: CustomViews.appBarWidget(
          context: context,
          title:kCompany_info,
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14)),
                      child: SingleChildScrollView(
                        child: Form(
                          key: updateCompanyFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: CustomTextField(
                                  lablel: kCompany_name,
                                  isEditable: false,
                                  controller: companyNameController,
                                  errorMessage: kEnter_company_name,
                                  // icon: Icon(Icons.account_box_rounded),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                  height: ScreenUtil().setHeight(35),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: CustomColors.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: CustomColors.GREY_LIGHT_A_COLOR
                                              .withOpacity(.5))),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      value: userRegisterationProvider
                                          .selectedCity,
                                      hint: Text(userRegisterationProvider
                                                  .selectedCity ==
                                              null
                                          ? ""
                                          : userRegisterationProvider
                                                  .selectedCity!.name ??
                                              ""),
                                      items: (widget.businessStatus !=
                                              "Pending")
                                          ? null
                                          : citiesProvider.citiesResponse.data!
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(e.name!),
                                                    value: e,
                                                  ))
                                              .toList(),
                                      onChanged: (dynamic v) {
                                        userRegisterationProvider.changeCity(v);
                                      })),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                  height: ScreenUtil().setHeight(35),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: CustomColors.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: CustomColors.GREY_LIGHT_A_COLOR
                                              .withOpacity(0.5))),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      value: sectorsProvider.selectedSector,
                                      hint: Text(
                                          sectorsProvider.selectedSector == null
                                              ? ""
                                              : translator
                                                          .locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? sectorsProvider
                                                      .selectedSector!.nameAr
                                                  : sectorsProvider
                                                          .selectedSector!
                                                          .name ??
                                                      ""),
                                      items:
                                          (widget.businessStatus != "Pending")
                                              ? null
                                              : sectorsProvider
                                                  .sectorResponse.sector!
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(translator.activeLanguageCode == 'ar'
                                                            ? e.nameAr
                                                            : e.name),
                                                        value: e,
                                                      ))
                                                  .toList(),
                                      onChanged: (dynamic v) {
                                        sectorsProvider.changeSector(v);
                                      })),

                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: CustomTextField(
                                  lablel: 'trade_mark',
                                  // formKey: signupCompanyFormKey,
                                  isEditable: false,
                                  controller: tradeMarkController,
                                  errorMessage: 'Enter_the_commercial_Mark',
                                  // icon: Icon(Icons.markunread_mailbox),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: CustomTextField(
                                      lablel: kCommercial_Registration_No,
                                      isMobile: true,
                                      isEditable: false,
                                      isValidator:false,
                                      controller: registerationNumberController,
                                      errorMessage:
                                          kEnter_the_commercial_registration_number,
                                      // icon: Icon(Icons.format_list_numbered),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: CustomTextField(
                                      lablel: kTax_number,
                                      isEditable: false,
                                      isValidator:false,
                                      controller: taxNumberController,
                                      errorMessage: kEnter_tax_number,
                                      isMobile: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                           Row(
                             children: [
                               Text(
                                 "${'view_att'.tr()}",
                                 style: TextStyle(
                                     color: CustomColors.GREY_COLOR,
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold),
                               ),
                             ],
                           ),
                              SizedBox(
                                height: 15,
                              ),

                            businessInfoProvider.businessInfoResponse!.data!.files!.isEmpty ? Container()
                                  :   Column(
                              children: [
                                commerical== null ? Container() :           Row(
                                  children: [
                                    Text('\u2022'),
                                    SizedBox(width: 5),
                                     InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder:
                                                (context)=> PDFScreen(pdf_path: commerical_remotePDFpath,
                                              image: commerical!.fileName!.split('.')[1] == "pdf" ? false :true,
                                              image_path: commerical_image_url,
                                            ),));
                                          },
                                          child: Text(kCommercial_Registration_No.tr(),
                                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                                        )
                                  ],
                                ),
                                SizedBox(width: 10),
                                tax== null ? Container() :    Row(
                                  children: [
                                    Text('\u2022'),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> PDFScreen(pdf_path: tax_remotePDFpath,
                                          image: tax!.fileName!.split('.')[1] == "pdf" ? false :true,
                                          image_path: tax_image_url,
                                        ),));
                                      },
                                      child: Text(kTax_number.tr(),
                                        style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                                    )

                                  ],
                                ),
                              ],
                            ),


                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${'notice'.tr()}",
                                style: TextStyle(
                                    color: CustomColors.GREY_COLOR,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "${'notice_message'.tr()}",
                                  style: TextStyle(
                                      color: CustomColors.GREY_LIGHT_A_COLOR,
                                      fontSize: 16),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )),)
      ),
    );
  }

  bool validateInputs({var scaffoldKey, required var ctx}) {
    var businessInfoProv =
        Provider.of<BusinessInfoProvider>(ctx, listen: false);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(ctx, listen: false);
    var sectorsProvider = Provider.of<SectorProvider>(ctx, listen: false);

    if (userRegisterationProvider.selectedCity == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: "Choose_the_city",
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (sectorsProvider.selectedSector == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: "Choose_the_sector",
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (registerationNumberController.text.length != 10) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: 'reg_num_validation',
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }

    return true;
  }

  Future<File> createFileOfPdfUrl({String? path}) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "${path}";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
