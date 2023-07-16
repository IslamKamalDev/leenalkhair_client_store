// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/extensions/connectivity/network_indicator.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/providers/pages_provider.dart';
import 'package:leen_alkhier_store/providers/tab_controller_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/fcm.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';

import 'package:leen_alkhier_store/data/requests/user_login_request.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/auth/forget_password.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_company.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_contract.dart';

import 'package:leen_alkhier_store/views/index.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/welcome_dialog.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loginFormKey = GlobalKey<FormState>();

  var loginScaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollConroller = ScrollController();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  bool? KeepMeLogedIn = false;
  bool? show_login_button = false;
  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Directionality(
          textDirection: MyMaterial.app_langauge == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child:SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: CustomViews.appBarWidget(
                  context: context,
                  title: "login",
                route: LoginOnBoarding()
              ) ,
              body:  GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();

                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: SingleChildScrollView(
                      controller: _scrollConroller,
                      child: Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil.defaultSize.width * 0.1,
                          ),
                         /* Row(children: [
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                child: Image.asset(ImageAssets.close),
                                width: 40,
                                height: 40,
                                // color: Colors.red,
                              ),
                            )
                          ]),*/
                          Center(
                            child: Form(
                              key: loginFormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  show_login_button! ? Container():        Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.defaultSize.width * 0.05),
                                    child: Image.asset(
                                      ImageAssets.launcher_icon,   // 'assets/logo.png',
                                      scale: 1,

                                    ),),

                                  Column(
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                            child: CustomTextField(
                                              // icon: Icon(Icons.phone_android),
                                              onTap: (){
                                                setState(() {
                                                  show_login_button = true;
                                                });
                                              },
                                              isPhoneCode: true,
                                              formKey: loginFormKey,
                                              isMobile: true,
                                              errorMessage: kEnter_phone,
                                              controller: emailController,
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
                                          // icon: Icon(Icons.lock),
                                          lablel: kPassword,
                                          onTap: (){
                                            setState(() {
                                              show_login_button = true;
                                            });
                                          },
                                          formKey: loginFormKey,
                                          errorMessage: kEnter_password,
                                          controller: passwordController,
                                          hasPassword: true,
                                          isQuantity: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // textDirection: TextDirection.ltr,
                                        children: [
                                          Row(
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                    unselectedWidgetColor:
                                                        CustomColors
                                                            .PRIMARY_GREEN),
                                                child: Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor: CustomColors
                                                      .PRIMARY_GREEN,
                                                  value: KeepMeLogedIn,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      KeepMeLogedIn = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Text(
                                                translator
                                                    .translate('remember_me'),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              analytics.setUserProperties(
                                                  userRole:
                                                      "Forget Password Screen");
                                              CustomViews.navigateTo(
                                                  context,
                                                  ForgetPassword(),
                                                  "Forget Password Screen");
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (ctx) => ForgetPassword()));
                                            },
                                            child: Text(
                                              kforget_password.tr(),
                                              style: TextStyle(
                                                  color: Colors.red[800]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        height: ScreenUtil().setHeight(45),
                                        child: CustomRoundedButton(
                                          fontSize: 15,
                                          text: kLogin1,
                                          textColor: Colors.white,
                                          backgroundColor:
                                              CustomColors.PRIMARY_GREEN,
                                          borderColor:
                                              CustomColors.PRIMARY_GREEN,
                                          pressed: () async {
                                            // if (KeepMeLogedIn == true) {
                                            //   keepUserLoggedIn();
                                            // }

                                            if (loginFormKey.currentState!
                                                    .validate() &&
                                                validateInputs(
                                                    scaffoldKey:
                                                        loginScaffoldKey)) {
                                              //Login

                                              CustomViews.showLoadingDialog(
                                                  context: context);
                                              await getDeviceToken()
                                                  .then((value) async {
                                                fbToken = value!;
                                                String? lang = await getLang();
                                                var userProvider =
                                                    Provider.of<UserProvider>(
                                                        context,
                                                        listen: false);

                                                userProvider
                                                    .loginUser(
                                                        requestBody: LoginRequestBody(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            device_token: value,
                                                            lang: lang == null
                                                                ? 'ar'
                                                                : lang))
                                                    .whenComplete(() async {
                                                  if (!userProvider
                                                      .userLoginResponse!
                                                      .status!) {
                                                    CustomViews.showSnackBarView(
                                                        title_status: false,
                                                        backend_message:
                                                            userProvider
                                                                .userLoginResponse!
                                                                .message!,
                                                        backgroundColor:
                                                            CustomColors
                                                                .RED_COLOR,
                                                        success_icon: false);

                                                    CustomViews.dismissDialog(
                                                        context: context);
                                                  } else {
                                                    log("Successful Login");
                                                    if (KeepMeLogedIn == true) {
                                                      PreferenceManager
                                                          .keepUserLoggedIn(
                                                              KeepMeLogedIn!);
                                                    }
                                                    await TokenUtil.saveToken(
                                                        userProvider
                                                            .userLoginResponse!
                                                            .token!);
                                                    var userInfoProvider =
                                                        Provider.of<
                                                                UserInfoProvider>(
                                                            context,
                                                            listen: false);

                                                    //get and save user permissions
                                                    var allEmployeesProvider =
                                                        Provider.of<
                                                                AllEmployeesProvider>(
                                                            context,
                                                            listen: false);
                                                    allEmployeesProvider
                                                        .setUserPermissons(
                                                            token: TokenUtil
                                                                .getTokenFromMemory());
                                                    allEmployeesProvider
                                                        .getEmployeeBranches()
                                                        .then((value) {
                                                      var businessBranchesProvider =
                                                          Provider.of<
                                                                  BusinessBranchesProvider>(
                                                              context,
                                                              listen: false);
                                                      if (value!
                                                          .branches!.isEmpty) {
                                                        Shared.user_has_branches =
                                                            false;
                                                      } else {
                                                        Shared.user_has_branches =
                                                            true;
                                                        value.branches!.forEach(
                                                            (element) async {
                                                          if (value.branches!
                                                                  .indexOf(
                                                                      element) ==
                                                              0) {
                                                            businessBranchesProvider
                                                                .changeBranch(
                                                                    element);
                                                          }
                                                        });
                                                      }
                                                    });

                                                    userInfoProvider
                                                        .getUserInfo();
                                                    Shared
                                                        .pages = await PagesProvider
                                                            .getPages()
                                                        .whenComplete(() =>
                                                            CustomViews
                                                                .dismissDialog(
                                                                    context:
                                                                        context));
                                                    Shared.business_info_id =
                                                        userInfoProvider
                                                            .userInfoResponse!
                                                            .data!
                                                            .businessInfoId;

                                                    var tabeControllerProvider =
                                                        Provider.of<
                                                                TabControllerProvider>(
                                                            context,
                                                            listen: false);
                                                    tabeControllerProvider
                                                        .changeTab(0);

                                                    if (userProvider
                                                            .userLoginResponse!
                                                            .data!
                                                            .businessInfo ==
                                                        false) {
                                                      analytics.setUserProperties(
                                                          userRole:
                                                              "Signup Company Screen");
                                                      CustomViews
                                                          .navigateToRepalcement(
                                                              context,
                                                              SignupCompany(),
                                                              "Signup Company Screen");
                                                    } else {
                                                      if (userProvider
                                                              .userLoginResponse!
                                                              .data!
                                                              .businessInfoStatus ==
                                                          'Pending') {
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              WelcomeDialog(
                                                            context: context,
                                                          ),
                                                        );
                                                      } else if (userProvider
                                                              .userLoginResponse!
                                                              .data!
                                                              .businessInfoStatus ==
                                                          'Rejected') {
                                                        analytics.setUserProperties(
                                                            userRole:
                                                                "Signup Company Screen");
                                                        CustomViews
                                                            .navigateToRepalcement(
                                                                context,
                                                                SignupCompany(),
                                                                "Signup Company Screen");
                                                      } else if (userProvider
                                                              .userLoginResponse!
                                                              .data!
                                                              .businessInfoStatus ==
                                                          'Approved') {
                                                        print(
                                                            "userProvider.userLoginResponse!.data!.contract  : ${userProvider.userLoginResponse!.data!.contract}");
                                                        print(
                                                            "userProvider.userLoginResponse!.data!.contractStatus : ${userProvider.userLoginResponse!.data!.contractStatus}");
                                                        if (userProvider
                                                                .userLoginResponse!
                                                                .data!
                                                                .contract ==
                                                            false) {
                                                          analytics
                                                              .setUserProperties(
                                                                  userRole:
                                                                      "Signup Contract Screen");
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      SignupContract()));
                                                        } else {
                                                          if (userProvider
                                                                  .userLoginResponse!
                                                                  .data!
                                                                  .contractStatus ==
                                                              'Approved') {
                                                            if (!userInfoProvider
                                                                .userInfoResponse!
                                                                .product!) {
                                                              var homeTabsProvider =
                                                                  Provider.of<
                                                                          HomeTabsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              var categoriesProvider =
                                                                  Provider.of<
                                                                          CategoryProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                              homeTabsProvider.setCategory(
                                                                  categoriesProvider
                                                                      .allCategoriesResponse!
                                                                      .data![0]);
                                                              analytics
                                                                  .setUserProperties(
                                                                      userRole:
                                                                          "Create Products");

                                                              CustomViews.navigateToRepalcement(
                                                                  context,
                                                                  CreateProducts(
                                                                      islogin:
                                                                          true,
                                                                      title:
                                                                          '${kcreate_product.tr()}'),
                                                                  "Create Products");
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .popUntil(
                                                                      (route) =>
                                                                          route
                                                                              .isFirst);
                                                              CustomViews
                                                                  .navigateToRepalcement(
                                                                      context,
                                                                      Index(),
                                                                      "");
                                                            }
                                                            // });
                                                          } else if (userProvider
                                                                  .userLoginResponse!
                                                                  .data!
                                                                  .contractStatus ==
                                                              "Pending") {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  WelcomeDialog(
                                                                context:
                                                                    context,
                                                              ),
                                                            );
                                                          } else if (userProvider
                                                                  .userLoginResponse!
                                                                  .data!
                                                                  .contractStatus ==
                                                              "Rejected") {
                                                            analytics
                                                                .setUserProperties(
                                                                    userRole:
                                                                        "Signup Contract Screen");
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) =>
                                                                            SignupContract()));
                                                          } else if (userProvider
                                                                  .userLoginResponse!
                                                                  .data!
                                                                  .contractStatus ==
                                                              "Terminated") {
                                                            analytics
                                                                .setUserProperties(
                                                                    userRole:
                                                                        "Signup Contract Screen");
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (ctx) =>
                                                                            SignupContract()));
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                });
                                              }).then((value) async {});
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
  }

  bool validateInputs({var scaffoldKey}) {
    return true;
  }

  Future<String?> getLang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? Lang = pref.getString('language_code');
    return Lang;
  }
}
