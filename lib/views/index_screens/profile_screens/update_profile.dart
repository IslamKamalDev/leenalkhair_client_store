import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/requests/user_register_request.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/auth/login.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/delete_account/enter_password.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var updateFormKey = GlobalKey<FormState>();

  var updateScaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();

  var familyController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confPasswordController = TextEditingController();
  bool remove_account_status = false;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      if (value.getString("remove_account") == "true") {
        remove_account_status = true;
      }
    });
    // TODO: implement initState
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context, listen: false);
    var citiesProvider = Provider.of<CitiesProvider>(context, listen: false);
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () {
      userRegisterationProvider.changeCity(citiesProvider.citiesResponse.data!
          .firstWhere((element) =>
              element.id == userInfoProvider.userInfoResponse!.data!.cityId));
    });
    nameController.text = userInfoProvider.userInfoResponse!.data!.firstName!;
    familyController.text = userInfoProvider.userInfoResponse!.data!.lastName!;
    emailController.text = userInfoProvider.userInfoResponse!.data!.email!;
    phoneController.text =
        userInfoProvider.userInfoResponse!.data!.mobileNumber!;
  }

  @override
  Widget build(BuildContext context) {
    var citiesProvider = Provider.of<CitiesProvider>(context);
    var userRegisterationProvider = Provider.of<UserRegisterationProvider>(context);
    var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);

    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: updateScaffoldKey,
        backgroundColor: CustomColors.GREY_COLOR_A,
        appBar: CustomViews.appBarWidget(
          context: context,
          title: kPerson_info
      ) ,
        body: Directionality(
          textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child:GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Form(
                key: updateFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height:20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                    lablel: kfirst_name,
                                    controller: nameController,
                                    formKey: updateFormKey,
                                    errorMessage: kEnter_the_username,
                                    // icon: Icon(Icons.person),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                    lablel: klast_name,
                                    formKey: updateFormKey,
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
                            (userRegisterationProvider.selectedCity != null)
                                ? Row(
                                    children: [
                                      Text(translator
                                          .translate(kcity)),
                                    ],
                                  )
                                : Container(),
                            Container(
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
                                    hint: Text(kcity.tr()),
                                    value: userRegisterationProvider.selectedCity,
                                    items: citiesProvider.citiesResponse.data!
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
                              child: CustomTextField(
                                controller: emailController,
                                lablel: kEmail,
                                formKey: updateFormKey,
                                isEditable: false,
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
                                  controller: phoneController,
                                  lablel: PhoneCode_label,
                                  isEditable: false,
                                  formKey: updateFormKey,
                                  errorMessage: kEnter_phone,
                                  isMobile: true,
                                  isPhoneCode: true,
                                  // icon: Icon(Icons.phone_android),
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
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            remove_account_status
                                ? InkWell(
                                    onTap: () {
                                      CustomViews.navigateTo(context,
                                          EnterPass(), "Enter password");
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${"Do you want to account".tr()}',
                                          style: TextStyle(
                                              color: CustomColors.RED_COLOR),
                                        ),
                                      ],
                                    ))
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: ScreenUtil().setHeight(45),
                              child: CustomRoundedButton(
                                fontSize: 15,
                                text: kupdate,
                                textColor: Colors.white,
                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                pressed: () async {
                                  if (updateFormKey.currentState!.validate() &&
                                      validateInputs(
                                          scaffoldKey: updateScaffoldKey,
                                          ctx: context)) {
                                    CustomViews.showLoadingDialog(
                                        context: context);

                                    //Update User
                                    await userRegisterationProvider
                                        .updateUser(
                                            requestBody: UserRegisterRequest(
                                                firstName: nameController.text,
                                                email: emailController.text,
                                                lastName: familyController.text,
                                                cityId: userRegisterationProvider
                                                    .selectedCity!.id
                                                    .toString(),
                                                mobileNumber:
                                                    phoneController.text,
                                                status:
                                                    userRegisterationProvider
                                                                .status ==
                                                            false
                                                        ? 'New'
                                                        : 'Active',
                                                lang: MyMaterial.app_langauge,
                                                password:
                                                    passwordController.text))
                                        .whenComplete(() =>
                                            CustomViews.dismissDialog(
                                                context: context))
                                        .then((value) async {
                                      if (userRegisterationProvider.userRegisterResponse!.status == null) {

                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            message: 'something_error',
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false
                                        );

                                      } else {
                                        CustomViews.showSnackBarView(
                                            title_status: true,
                                            message: 'profile_info_success_update',
                                            backgroundColor: CustomColors.PRIMARY_GREEN,
                                            success_icon: true
                                        );


                                        userInfoProvider.userInfoResponse!.data!
                                            .firstName = nameController.text;
                                        userInfoProvider.userInfoResponse!.data!
                                            .lastName = familyController.text;

                                        userInfoProvider.userInfoResponse!.data!
                                            .email = emailController.text;
                                        userInfoProvider.userInfoResponse!.data!
                                                .mobileNumber =
                                            phoneController.text;
                                        userInfoProvider.userInfoResponse!.data!
                                                .cityId =
                                            userRegisterationProvider
                                                .selectedCity!.id;
                                        PreferenceManager.getInstance()!
                                            .saveString("username",
                                                emailController.text);

                                        if (passwordController
                                            .text.isNotEmpty) {
                                          PreferenceManager.getInstance()!
                                              .saveString("password",
                                                  passwordController.text);
                                        }

                                        await Future.delayed(
                                            Duration(seconds: 1), () {
                                          Navigator.pop(context);
                                        });
                                      }
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
                      ),
                    )
                  ],
                ),
              ),
            )),
      )
      ),
    );
  }

  bool validateInputs({var scaffoldKey, required var ctx}) {
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
    if (passwordController.text.isNotEmpty && passwordController.text.length < 6) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KPassword_Limit,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (passwordController.text.isNotEmpty && (passwordController.text != confPasswordController.text)) {
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
