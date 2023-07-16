import 'dart:developer';
import 'dart:ui' as ui;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/requests/user_login_request.dart';
import 'package:leen_alkhier_store/data/requests/user_register_request.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/phoneCode_provider.dart';
import 'package:leen_alkhier_store/providers/reset_password_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/providers/user_verfiy_otp_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/fcm.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_company.dart';
import 'package:leen_alkhier_store/views/widgets/Custom_appbar.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/title_text.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import '../../../utils/local_const.dart';
import '../confirm_code.dart';

class SignupProfile extends StatefulWidget {
  @override
  _SignupProfileState createState() => _SignupProfileState();
}

class _SignupProfileState extends State<SignupProfile> {
  final signupFormKey = GlobalKey<FormState>();

  var signupScaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();

  var familyController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confPasswordController = TextEditingController();
  String? device_token;
  bool value = false;
  bool checked = false;
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context, listen: false);
    userRegisterationProvider.selectedCity = null;

    getDeviceToken().then((value) {
      device_token = value;
      fbToken = value!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var citiesProvider = Provider.of<CitiesProvider>(context);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context);

    var userProvider = Provider.of<UserProvider>(context);
    var resetPasswordProvider = Provider.of<ResetPasswordProvider>(context);
    var productsProvider = Provider.of<ProductProvider>(context, listen: false);
    var phoneCodeProvider = Provider.of<PhoneCodeProvider>(context);
    var verfiyOtpProvidervalue =
        Provider.of<verfiyOtpProvider>(context, listen: true);

    return  Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:Scaffold(
      key: signupScaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomAppBar(
        title: Text(
          '${kNewAccount.tr()}',
          style: TextStyle(color: CustomColors.BLACK_COLOR, fontSize: 18),
        ),
      ),
      body:GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Form(
              key: signupFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleWithImage(
                        icon: ImageAssets.profileInfo,
                        text: kPerson_info.tr(),
                        iconcolor: CustomColors.WHITE_COLOR,
                        backgroundcolor2: CustomColors.PRIMARY_GREEN,
                      ),
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
                      // (
                      //   thickness: 2,
                      //   height: 2,
                      //   indent: 50,
                      //   endIndent: 50,
                      //   color: CustomColors.BLACK_COLOR,
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     CustomViews.navigateToRepalcement(
                      //         context,
                      //         SignupCompany(
                      //           // fromCreatContract:
                      //           //     widget.fromCreatContract,
                      //           isFromProfile: false,
                      //         ),
                      //         "Signup Company Screen");
                      //   },
                      //   child:
                      TitleWithImage(
                        icon: ImageAssets.companyInfo,
                        text: kCompany_info.tr(),
                        iconcolor: CustomColors.BLACK_COLOR,
                        backgroundcolor2: CustomColors.WHITE_COLOR,
                      ),
                      // Column(
                      //   children: [
                      //     Container(
                      //       width: 45,
                      //       height: 45,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5),
                      //           border: Border.all(
                      //               color: CustomColors.GREY_LIGHT_B_COLOR),
                      //           color: CustomColors.WHITE_COLOR),
                      //       padding: EdgeInsets.all(5),
                      //       child: ClipOval(
                      //         child: Image.asset(
                      //           ImageAssets.companyInfo,
                      //           color: CustomColors.BLACK_COLOR,
                      //         ),
                      //       ),
                      //     ),
                      //     Text(translator
                      //         .translate(kCompany_info)!)
                      //   ],
                      // ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14)),
                      height: MediaQuery.of(context).size.height * 0.89,
                      // color: Colors.red,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                    lablel: kfirst_name,
                                    formKey: signupFormKey,
                                    controller: nameController,
                                    errorMessage: kEnter_the_username,
                                    // icon: Icon(Icons.person),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                    lablel: klast_name,
                                    errorMessage: kEnter_the_family_name,
                                    controller: familyController,
                                    // icon: Icon(Icons.people_alt_rounded),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            userRegisterationProvider.selectedCity != null
                                ? Row(
                                    children: [
                                      Text(kcity.tr()),
                                    ],
                                  )
                                : Container(),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: CustomColors.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                child: DropdownButton(
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(kselectCity.tr()),
                                    value:
                                        userRegisterationProvider.selectedCity,
                                    items: citiesProvider.citiesResponse.data!
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.name!),
                                              value: e,
                                            ))
                                        .toList(),
                                    onChanged: (dynamic v) =>
                                        userRegisterationProvider
                                            .changeCity(v))),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomTextField(
                                controller: emailController,
                                formKey: signupFormKey,
                                lablel: kEmail,
                                // icon: Icon(Icons.email),
                                errorMessage: kEnter_email,
                                isEmail: true,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                child: CustomTextField(
                                  // icon: Icon(Icons.phone_android),
                                  isPhoneCode: true,
                                  formKey: signupFormKey,
                                  isMobile: true,
                                  errorMessage: kEnter_phone,
                                  controller: phoneController,
                                  direction: TextDirection.ltr,
                                  alignment: TextAlign.left,
                                  lablel: kphone,
                                  isQuantity: false,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomTextField(
                                controller: passwordController,
                                hasPassword: true,
                                lablel: kPassword,
                                formKey: signupFormKey,
                                errorMessage: kEnter_password,
                                // icon: Icon(
                                //   Icons.lock,
                                // )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomTextField(
                                controller: confPasswordController,
                                hasPassword: true,
                                lablel: kConfirmPassword,
                                formKey: signupFormKey,
                                errorMessage: kEnter_password,

                              ),
                            ),


                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: ScreenUtil().setHeight(45),
                              child: CustomRoundedButton(
                                fontSize: 15,
                                text: knext,
                                textColor: Colors.white,
                                backgroundColor: CustomColors.BLACK_COLOR,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                pressed: () async {
                                  if (signupFormKey.currentState!.validate() &&
                                      validateInputs(context,
                                          scaffoldKey: signupScaffoldKey,
                                          ctx: context)) {
                                    CustomViews.showLoadingDialog(
                                        context: context);
                                    //Register User
                                    userRegisterationProvider
                                        .registerUser(
                                            requestBody: UserRegisterRequest(
                                                firstName: nameController.text,
                                                email: emailController.text,
                                                lastName: familyController.text,
                                                cityId:
                                                    userRegisterationProvider
                                                        .selectedCity!.id
                                                        .toString(),
                                                mobileNumber:
                                                    phoneController.text,
                                                country_code:
                                                    phoneCodeProvider.phoneCode,
                                                password:
                                                    passwordController.text,
                                                device_token: device_token))
                                        .whenComplete(() =>
                                            CustomViews.dismissDialog(
                                                context: context))
                                        .then((value) async {
                                      if (userRegisterationProvider.userRegisterResponse!.status == null ||
                                          userRegisterationProvider.userRegisterResponse!.status == false) {


                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            message: Kalready_registered,
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false
                                        );

                                      } else {
                                        log("User Registered Successfully...");
                                        await TokenUtil.saveToken(
                                            userRegisterationProvider
                                                .userRegisterResponse!.token!);
                                        //get and save user permissions
                                        var allEmployeesProvider =
                                            Provider.of<AllEmployeesProvider>(
                                                context,
                                                listen: false);
                                        allEmployeesProvider.setUserPermissons(
                                            token:
                                                TokenUtil.getTokenFromMemory());
                                        //VerifyUser
                                        resetPasswordProvider.setEmail(
                                            m: phoneController.text);

                                        CustomViews.showLoadingDialog(
                                            context: context);
                                        var userProvider =
                                            Provider.of<UserProvider>(context,
                                                listen: false);

                                        userProvider
                                            .loginUser(
                                                requestBody: LoginRequestBody(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    device_token: device_token))
                                            .whenComplete(() =>
                                                CustomViews.dismissDialog(context: context))
                                            .then((value) async {
                                          if (!userProvider.userLoginResponse!.status!) {

                                            CustomViews.showSnackBarView(
                                                title_status: false,
                                                backend_message: userProvider .userLoginResponse!.message!,
                                                backgroundColor: CustomColors.RED_COLOR,
                                                success_icon: false
                                            );
                                          } else {
                                            log("Successful Login");
                                            TokenUtil.saveToken(userProvider.userLoginResponse!.token!);
                                            var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
                                            await userInfoProvider.getUserInfo();
                                            await productsProvider.getAllProduct();
                                            analytics.setUserProperties(
                                                userRole:
                                                "Signup Company Screen");
                                            CustomViews
                                                .navigateToRepalcement(
                                                context,
                                                SignupCompany(),
                                                "Signup Company Screen");
                                 /*           CustomViews.navigateTo(context,
                                                ConfirmCode(
                                                  isFromSignUp: false,
                                                  isToConfirmPass: false,
                                                  email: userInfoProvider
                                                      .userInfoResponse!
                                                      .data!
                                                      .email,
                                                  phone: phoneController.text
                                                      .toString(),
                                                ),
                                                "Confirm Password");*/

                                            // showModalBottomSheet(
                                            //   isScrollControlled: true,
                                            //   context: context,

                                            //   builder: (context) {
                                            //     // verfiyOtpProvidervalue
                                            //     //     .resend_timer_status = true;
                                            //     return ConfirmCode(
                                            //       isFromSignUp: false,
                                            //       isToConfirmPass: false,
                                            //       email: userInfoProvider
                                            //           .userInfoResponse!
                                            //           .data!
                                            //           .email,
                                            //       phone: phoneController.text
                                            //           .toString(),
                                            //     );
                                            //   },
                                            // );
                                          }
                                        });

                                        // });
                                      }
                                    }).catchError((e) {
                                      log("Error Signup User:$e");
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )),)
    );
  }

  bool validateInputs(BuildContext context,
      {var scaffoldKey, required var ctx}) {
    var userRegProv =
        Provider.of<UserRegisterationProvider>(ctx, listen: false);
    if (!EmailValidator.validate(emailController.text)) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KEnter_the_email_correctly,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );
      return false;
    }
    if (userRegProv.selectedCity == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KChoose_the_city,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );
      return false;
    }

    if (passwordController.text.length < 6) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KPassword_Limit,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (passwordController.text != confPasswordController.text) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KPassword_not_match,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    return true;
  }

}
