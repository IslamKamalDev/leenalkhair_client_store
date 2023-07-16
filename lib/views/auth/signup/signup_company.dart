import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/sector_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';

import 'package:leen_alkhier_store/data/requests/business_register_request.dart';
import 'package:leen_alkhier_store/providers/business_register_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/auth/confirm_code.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/map_dialog.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/views/widgets/title_text.dart';
import 'package:leen_alkhier_store/views/widgets/welcome_dialog.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../../index.dart';

class SignupCompany extends StatefulWidget {
  SignupCompany();
  @override
  _SignupCompanyState createState() => _SignupCompanyState();
}

class _SignupCompanyState extends State<SignupCompany> {
  var signupCompanyFormKey = GlobalKey<FormState>();

  var signupCompanyScaffoldKey = GlobalKey<ScaffoldState>();

  var registerationNumberController = TextEditingController();

  var company_nameController = TextEditingController();
  var tax_numberController = TextEditingController();

  var addressController = TextEditingController();
  var tradeMarkController = TextEditingController();

  var notesController = TextEditingController();
  AnalyticsService analytics = AnalyticsService();

  File? commercial;
  File? tax;

  @override
  void initState() {
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context, listen: false);
    var sectorsProvider = Provider.of<SectorProvider>(context, listen: false);
    sectorsProvider.selectedSector = null;
    userRegisterationProvider.selectedCity = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var citiesProvider = Provider.of<CitiesProvider>(context);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context);
    var sectorsProvider = Provider.of<SectorProvider>(context);

    return Directionality(
      textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child:Scaffold(
      key: signupCompanyScaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomViews.appBarWidget(
        context: context,
        title: kNewAccount,
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(14)),

              child: SingleChildScrollView(
                child: Form(
                  key: signupCompanyFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleWithImage(
                            icon: ImageAssets.profileInfo,
                            text: translator
                                .translate(kPerson_info),
                            iconcolor: CustomColors.BLACK_COLOR,
                            backgroundcolor2: CustomColors.WHITE_COLOR,
                          ),
                          //
                          Column(
                            children: [
                              Container(
                                height: 1,
                                width: 90.w,
                                color: CustomColors.GREY_COLOR,
                              ),
                              Text("")
                            ],
                          ),

                          TitleWithImage(
                            icon: ImageAssets.companyInfo,
                            text: kCompany_info.tr(),
                            iconcolor: CustomColors.WHITE_COLOR,
                            backgroundcolor2: CustomColors.PRIMARY_GREEN,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: CustomTextField(
                          lablel: kCompany_name,
                          hasBorder: true,
                          formKey: signupCompanyFormKey,
                          controller: company_nameController,
                          errorMessage: kEnter_company_name,
                          // icon: Icon(Icons.account_box_rounded),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: ScreenUtil().setHeight(35),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: CustomColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: CustomColors.GREY_COLOR)),
                          child: DropdownButton(
                              isExpanded: true,
                              underline: Container(),
                              hint: Text(kselectCity.tr()),
                              value: userRegisterationProvider.selectedCity,
                              items: citiesProvider.citiesResponse.data!
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e.name!),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (dynamic v) =>
                                  userRegisterationProvider.changeCity(v))),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: ScreenUtil().setHeight(35),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: CustomColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CustomColors.PRIMARY_GREEN)),
                          child: DropdownButton(
                              isExpanded: true,
                              underline: Container(),
                              hint: Text(kselectsector.tr()),
                              value: sectorsProvider.selectedSector,
                              items: sectorsProvider.sectorResponse.sector!
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                            translator
                                                        .locale
                                                        .languageCode ==
                                                    'ar'
                                                ? e.nameAr
                                                : e.name),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (dynamic v) =>
                                  sectorsProvider.changeSector(v))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: CustomTextField(
                          lablel: 'trade_mark',
                          formKey: signupCompanyFormKey,
                          controller: tradeMarkController,
                          errorMessage: 'Enter_the_commercial_Mark',
                          // icon: Icon(Icons.markunread_mailbox),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: CustomTextField(
                              lablel: kCommercial_Registration_No,
                              formKey: signupCompanyFormKey,
                              isMobile: true,
                              isValidator: false,
                              controller: registerationNumberController,
                              errorMessage:
                                  kEnter_the_commercial_registration_number,
                              // icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: CustomTextField(
                              lablel: kTax_number,
                              isMobile: true,
                              isValidator: false,
                              formKey: signupCompanyFormKey,
                              controller: tax_numberController,
                              errorMessage: kEnter_tax_number,
                              // icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        kupload_documents.tr(),
                        style: TextStyle(
                            color: CustomColors.BLACK_COLOR,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              FilePicker.platform
                                  .pickFiles(
                                type: FileType.any,
                              )
                                  .then((value) async {
                                if (value != null) {

                                 if(value.files[0].extension!.toString() == "png"
                                 || value.files[0].extension!.toString() == "jpg"
                                 || value.files[0].extension!.toString() == "jpeg"){
                                   commercial = await FlutterNativeImage.compressImage(value.files[0].path!,
                                       quality: 20, percentage: 60);
                                 }else{

                                   commercial = File(value.files[0].path!);

                                   final bytes = commercial?.readAsBytesSync().lengthInBytes;
                                   final kb = bytes! / 1024;
                                   final mb = kb / 1024;
                                   print("*** mb *** : ${mb}");
                                   if(mb > 2){
                                     commercial = null;
                                     CustomViews.showSnackBarView(
                                         title_status: false,
                                         message: kexceed_file_size.tr(),
                                         backgroundColor: CustomColors.RED_COLOR,
                                         success_icon: false);
                                   }
                                 }
                                  setState(() {});
                                }
                              });
                            },
                            child: DottedBorder(
                              color: CustomColors.GREY_LIGHT_A_COLOR,
                              strokeWidth: 1,
                              radius: Radius.circular(12),
                              dashPattern: [8],
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  child: (commercial == null)
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                  "${kCommercial_Registration.tr()}"),
                                            ),
                                            Image.asset(
                                              ImageAssets.uploadFile,
                                              width: 30,
                                              height: 30,
                                            ),
                                          ],
                                        )
                                      : Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FilePicker.platform
                                  .pickFiles(
                                type: FileType.any,
                              )
                                  .then((value) async {
                                if (value != null) {
                                  if(value.files[0].extension!.toString() == "png"
                                      || value.files[0].extension!.toString() == "jpg"
                                      || value.files[0].extension!.toString() == "jpeg"){

                                    tax = await FlutterNativeImage.compressImage(value.files[0].path!,
                                        quality: 20, percentage: 60);
                                  }else{
                                    tax = File(value.files[0].path!);
                                    final bytes = tax?.readAsBytesSync().lengthInBytes;
                                    final kb = bytes! / 1024;
                                    final mb = kb / 1024;
                                    print("*** mb *** : ${mb}");
                                    if(mb > 2){
                                      tax = null;
                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          message: kexceed_file_size.tr(),
                                          backgroundColor: CustomColors.RED_COLOR,
                                          success_icon: false);
                                    }
                                  }
                                  setState(() {});
                                }
                              });
                            },
                            child: DottedBorder(
                              color: CustomColors.GREY_LIGHT_A_COLOR,
                              strokeWidth: 1,
                              radius: Radius.circular(12),
                              dashPattern: [8],
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: (tax == null)
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                  "${ktex_con.tr()}"),
                                            ),
                                            Image.asset(
                                              ImageAssets.uploadFile,
                                              width: 30,
                                              height: 30,
                                            ),
                                          ],
                                        )
                                      : Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: ScreenUtil().setHeight(40),
                        child: CustomRoundedButton(
                          fontSize: 15,
                          text: kcreate_company,
                          textColor: Colors.white,
                          backgroundColor: CustomColors.ORANGE,
                          borderColor: CustomColors.ORANGE,
                          // pressed: () {},
                          pressed: () async {
                            if (signupCompanyFormKey.currentState!.validate() &&
                                validateInputs(
                                    scaffoldKey: signupCompanyScaffoldKey,
                                    ctx: context)) {
                              CustomViews.showLoadingDialog(context: context);
                              var businessRegistrationProvider =
                                  Provider.of<BusinessRegisterationProvider>(
                                      context,
                                      listen: false);



                              await businessRegistrationProvider
                                  .registerBusiness(
                                      requestBody: BusinessRegisterRequest(
                                          trade_mark: tradeMarkController.text,
                                          registrationNumber:
                                              registerationNumberController.text,
                                          name: company_nameController.text,
                                          tax_number: tax_numberController.text,
                                          commerical: commercial,
                                          city_id: userRegisterationProvider
                                              .selectedCity!.id
                                              .toString(),
                                          sector_id: sectorsProvider
                                              .selectedSector!.id
                                              .toString(),
                                          tax: tax,
                                          latitude: 0.0,
                                          longitude: 0.0)
                              ).whenComplete(() {
                                CustomViews.dismissDialog(context: context);
                              }).then((value) async {

                                if (businessRegistrationProvider
                                    .businessRegisterResponse.status!) {

                                  Future.delayed(Duration(seconds: 2),
                                      () async {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    var productsProvider =
                                        Provider.of<ProductProvider>(context,
                                            listen: false);
                                    await productsProvider.getAllProduct();
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          WelcomeDialog(
                                        context: context,
                                      ),
                                    );

                                  });
                                } else {
                                  CustomViews.showSnackBarView(
                                      title_status: false,
                                      backend_message:
                                          businessRegistrationProvider
                                              .businessRegisterResponse
                                              .message!,
                                      backgroundColor: CustomColors.RED_COLOR,
                                      success_icon: false);

                                  if (businessRegistrationProvider
                                              .businessRegisterResponse
                                              .message ==
                                          'you haven\'t verify the otp' ||
                                      businessRegistrationProvider
                                              .businessRegisterResponse
                                              .message ==
                                          'يجب التحقق من رقم الهاتف اولا') {
                                    var userInfoProvider =
                                        Provider.of<UserInfoProvider>(context);
                                    await userInfoProvider.getUserInfo();

                                   analytics.setUserProperties(
                                        userRole: " Confirm Code Screen");
                                    CustomViews.navigateToRepalcement(context,
                                        ConfirmCode(), "Confirm Code Screen");
                                  }
                                }
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )))),
    );
  }

  bool validateInputs({var scaffoldKey, required var ctx}) {
    var compProvider =
        Provider.of<BusinessRegisterationProvider>(ctx, listen: false);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(ctx, listen: false);
    var sectorsProvider = Provider.of<SectorProvider>(context, listen: false);

    if (userRegisterationProvider.selectedCity == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: "Choose_the_city",
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);

      return false;
    }
    if (sectorsProvider.selectedSector == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: "Choose_the_sector",
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);
      return false;
    }
    if (registerationNumberController.text.length != 10) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: "reg_num_validation",
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);
      return false;
    }
    if (tax_numberController.text.isEmpty) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: ktax_number_validation,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);
      return false;
    }
    return true;
  }
}
