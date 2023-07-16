import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:leen_alkhier_store/data/requests/user_register_request.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/business_info_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/delivery_timing_duration_provider.dart';
import 'package:leen_alkhier_store/providers/pages_provider.dart';
import 'package:leen_alkhier_store/providers/sector_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/Settings.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/fcm.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/auth/confirm_code.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_company.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/about.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/chat.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/suggestions.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/privacy.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/terms.dart';
import 'package:leen_alkhier_store/views/index_screens/more_screens/veraion_details.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/update_business.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/update_email.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/update_mobile.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_screens/update_profile.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  AnalyticsService analytics = AnalyticsService();
  var profile_ScaffoldKey = GlobalKey<ScaffoldState>();
  var click_counter = 0;
  bool finance_status=false;

  @override
  Widget build(BuildContext context) {
    var userRegisterationProvider =
        Provider.of<UserRegisterationProvider>(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    //ResetDataProviders
    var citiesProvider = Provider.of<CitiesProvider>(context);
    var sectorsProvider = Provider.of<SectorProvider>(context, listen: false);

    var catsProvider = Provider.of<CategoryProvider>(context);
    var productsProvider = Provider.of<ProductProvider>(context);
    var contractProducts =
        Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context,
            listen: false);
    var deliveryProvider = Provider.of<DeliveryTimingDurationProvider>(context);

    var businessInfoProvider = Provider.of<BusinessInfoProvider>(context);
    var contractInfoProvider = Provider.of<ContractInfoProvider>(context);

    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: CustomColors.GREY_COLOR_A,
            body: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(
                    height: 20,
                  ),
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child:  Row(
                                children: [
                            Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                  child:   Container(
                                    width: ScreenUtil.defaultSize.width * 0.1,
                                    height: ScreenUtil.defaultSize.width * 0.1,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CustomColors.GREY_LIGHT_B_COLOR),
                                        borderRadius: BorderRadius.circular(30),
                                        color: CustomColors.PRIMARY_GREEN),
                                    padding: EdgeInsets.all(5),
                                    child: ClipOval(
                                      child: Image.asset(
                                        ImageAssets.profileInfo,
                                        color: CustomColors.WHITE_COLOR,
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        kwelcome.tr(),
                                        style: TextStyle(
                                            color: CustomColors.GREY_LIGHT_A_COLOR,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        userInfoProvider
                                            .userInfoResponse!.data!.firstName
                                            .toString() +
                                            " " +
                                            userInfoProvider
                                                .userInfoResponse!.data!.lastName
                                                .toString(),
                                        style: TextStyle(
                                            color: CustomColors.BLACK_COLOR,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

              Expanded(
                flex: 1,
                child:  InkWell(
                            onTap: () async {
                              if (MyMaterial.app_langauge == 'ar') {
                                final newLang = 'en';
                                _changeLang(lang: newLang);
                                await getDeviceToken().then((value) {
                                  fbToken = value!;
                                  userRegisterationProvider.updateUser(
                                      requestBody: UserRegisterRequest(
                                        //  mobileNumber:userProvider.userLoginResponse.data.user.mobileNumber,
                                          firstName: userInfoProvider
                                              .userInfoResponse!.data!.firstName,
                                          email: userInfoProvider
                                              .userInfoResponse!.data!.email,
                                          lastName: userInfoProvider
                                              .userInfoResponse!.data!.lastName,
                                          mobileNumber: userInfoProvider
                                              .userInfoResponse!.data!.mobileNumber,
                                          cityId: userInfoProvider
                                              .userInfoResponse!.data!.cityId
                                              .toString(),
                                          lang: 'en',
                                          password: '',
                                          //      device_Token:value
                                          device_token: value));
                                });

                              }
                              else {
                                final newLang = 'ar';
                                _changeLang(lang: newLang);
                                await getDeviceToken().then((value) {
                                  fbToken = value!;
                                  userRegisterationProvider.updateUser(
                                      requestBody: UserRegisterRequest(
                                          firstName: userInfoProvider
                                              .userInfoResponse!.data!.firstName,
                                          email: userInfoProvider
                                              .userInfoResponse!.data!.email,
                                          lastName: userInfoProvider
                                              .userInfoResponse!.data!.lastName,
                                          mobileNumber: userInfoProvider
                                              .userInfoResponse!.data!.mobileNumber,
                                          cityId: userInfoProvider
                                              .userInfoResponse!.data!.cityId
                                              .toString(),
                                          lang: 'ar',
                                          password: '',
                                          device_token: value));
                                });

                              }
                              await citiesProvider.getAllCities();
                              await sectorsProvider.resetSector();
                              await catsProvider.getAllCategories();
                              await productsProvider.getAllProduct();
                              var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);
                              allEmployeesProvider.getEmployeeBranches().then((value) {
                                value!.branches!.forEach((element) {
                                  if (value.branches!.indexOf(element) == 0) {
                                    var businessBranchesProvider =
                                    Provider.of<BusinessBranchesProvider>(
                                        context,
                                        listen: false);
                                    businessBranchesProvider.changeBranch(element);
                                    userInfoProvider.getUserInfo();
                                    contractsProductsCartProvider
                                        .clearContractProductsResponse();
                                    contractProducts
                                        .getContractProducts(
                                        branch_id: element.id.toString())
                                        .then((value) {
                                      contractsProductsCartProvider
                                          .setContractsProductsResponse(value);
                                    });
                                  }
                                });
                              });
                              Provider.of<ContractPricingProvider>(context, listen: false).pricing_method = null;
                              await Provider.of<ContractPricingProvider>(context, listen: false).getContractPricingMethod();
                              Provider.of<ContractPricingProvider>(context, listen: false).pricing_type = null;
                              await Provider.of<ContractPricingProvider>(context, listen: false).getContractTypes();
                              await deliveryProvider.getDuration();
                              await deliveryProvider.getTime();
                              Shared.pages = await PagesProvider.getPages();

                            },
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color: CustomColors.WHITE_COLOR,
                                    child: Image.asset(
                                      ImageAssets.langIcon,
                                      width: 25,
                                      height: 25,
                                      // color: CustomColors.WHITE_COLOR,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "lang".tr(),
                                )
                              ],
                            ),
                          ),)
                        ]),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: CustomColors.WHITE_COLOR,
                        border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setWidth(5)),
                    child: Column(
                      children: [
                        ListTile(
                          leading:   Image.asset(
                            ImageAssets.profileInfo,
                            width: 30,
                            height: 30,
                            color: CustomColors.GREY_LIGHT_A_COLOR,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(profile_info.tr(),
                                style: TextStyle(color: Colors.black),
                              ),

                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_down,
                                  size: 30,color: CustomColors.GREY_LIGHT_A_COLOR,),
                                onPressed: () {
                                  setState(() {
                                    finance_status = !finance_status;
                                  });
                                },
                              ),

                            ],
                          ),
                          subtitle: (finance_status)? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subTextFunc(
                                  text: kEditProfile,
                                  icon: Icons.person_outline_outlined,
                                  function:  (){
                                    analytics.setUserProperties(userRole: "Update Profile Screen");
                                    CustomViews.navigateTo(context, UpdateProfile(), "Update Profile Screen");
                                  }),
                              Divider(
                                color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                                indent: 10.0,
                                endIndent: 10.0,
                                height: 30,
                              ),
                              subTextFunc(
                                  text: "update_email",
                                  icon: Icons.email,
                                  function: (){
                                    analytics.setUserProperties(userRole: "Update Email Screen");
                                    CustomViews.navigateTo(context, UpdateEmail(), "Update Email Screen");

                                  }),
                              Divider(
                                color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                                indent: 10.0,
                                endIndent: 10.0,
                                height: 30,
                              ),
                              subTextFunc(
                                  text: "update_mobile",
                                  icon: Icons.phone_android,
                                  function: (){
                                    analytics.setUserProperties(userRole: "Update Mobile Screen");
                                    CustomViews.navigateTo(context, UpdateMobile(), "Update Mobile Screen");
                                  }),
                              Divider(
                                color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                                indent: 10.0,
                                endIndent: 10.0,
                                height: 30,
                              ),
                            ],
                          ): null,
                          onTap: (){
                            setState(() {
                              finance_status = !finance_status;
                            });
                          },

                        ),
                        Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 30,
                        ),
                        SettingRow(
                          icon: ImageAssets.exit,
                          iconColor: CustomColors.ORANGE,
                          text: "sign_out",
                          actionRow: () async {
                            CustomViews.showLoadingDialog(context: context);
                            await Future.delayed(Duration(seconds: 1), () async {
                              CustomViews.dismissDialog(context: context);
                              PreferenceManager.instance!.remove("Token");
                              keepUserLoggedOut();
                              Get.offAll(LoginOnBoarding());
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: InkWell(
                          onTap: () async {
                            click_counter++;
                            if (click_counter == 5) {
                              String? version;
                              String? buildNumber;
                              PackageInfo packageInfo =
                              await PackageInfo.fromPlatform();
                              version = packageInfo.version;
                              buildNumber = packageInfo.buildNumber;
                              analytics.setUserProperties(
                                  userRole: "Version Details");
                              CustomViews.navigateTo(
                                  context,
                                  VersionDetails(
                                    buildNumber: buildNumber,
                                    version: version,
                                  ),
                                  "Version Details");
                              click_counter = 0;
                            }
                          },
                          child: Text(
                            translator
                                .translate("general_info"),
                            style: TextStyle(
                                color: CustomColors.GREY_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 100,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: CustomColors.WHITE_COLOR,
                        border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setWidth(5)),
                    child: Column(
                      children: [
                    SizedBox(
                          height: 10,
                        ),
                        /*   SettingRow(
                          icon: ImageAssets.chat,
                          iconColor: CustomColors.GREY_LIGHT_A_COLOR,
                          text: "chat_us".tr(),
                          actionRow: () {
                            analytics.setUserProperties(
                                userRole: "Chat Screen");
                            CustomViews.navigateTo(
                                context, Chat(
                              isContact: true,
                            ), "Chat Screen");

                          },
                        ),
                        Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 30,
                        ),*/
                        SettingRow(
                          icon: ImageAssets.privacy,
                          iconColor: CustomColors.GREY_LIGHT_A_COLOR,
                          text: kprivacy,
                          actionRow: () {
                            analytics.setUserProperties(userRole: "Privacy Screen");
                            CustomViews.navigateTo(
                                context, Privacy(), "Privacy Screen");
                          },
                        ),
                        Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 30,
                        ),
                        SettingRow(
                          icon: ImageAssets.terms,
                          iconColor: CustomColors.GREY_LIGHT_A_COLOR,
                          text: kterms,
                          actionRow: () {
                            analytics.setUserProperties(userRole: "Terms Screen");
                            CustomViews.navigateTo(
                                context, Terms(), "Terms Screen");
                          },
                        ),
                        Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 30,
                        ),
                        SettingRow(
                          icon: ImageAssets.suggestion,
                          iconColor: CustomColors.GREY_LIGHT_A_COLOR,
                          text: ksuggests,
                          actionRow: () {
                            analytics.setUserProperties(
                                userRole: "Suggestions Screen");
                            CustomViews.navigateTo(
                                context, Suggesstions(), "Suggestions Screen");

                            // analytics.setUserProperties(
                            //     userRole: "All Contracts Screen");
                            // CustomViews.navigateTo(
                            //     context, AllContracts(), "All Contracts Screen");
                          },
                        ),
                        Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR.withOpacity(.5),
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 30,
                        ),


                        SettingRow(
                          icon: ImageAssets.aboutus,
                          iconColor: CustomColors.GREY_LIGHT_A_COLOR,
                          text: kabout_app,
                          actionRow: () {
                            analytics.setUserProperties(
                                userRole: "About Application Screen");
                            CustomViews.navigateTo(
                                context, AboutApp(), "About Application Screen");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  void keepUserLoggedOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('KkeepMeLoggedIn', false);
  }


  Widget subTextFunc({var text , var function,var icon}){

    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5),
      child: InkWell(
        onTap: function,
        child: Row(
          children: [
            Icon(icon,color: CustomColors.GREY_LIGHT_A_COLOR,),
          SizedBox(width: 5,),
            Text('${text.toString().tr()}',
                style:  TextStyle(color: Colors.black,)),
          ],
        )

      ),
    );
  }


  void _changeLang({String? lang}) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: false,
      );
    });
    MyMaterial.setLocale(context, Locale('${lang}'));
    PreferenceManager.getInstance()!.saveString(Constants.languageCode, lang!);
  }

}

class SettingRow extends StatelessWidget {
  Function() actionRow;
  String icon;
  String text;
  Color iconColor;
  SettingRow({
    required this.actionRow,
    required this.icon,
    required this.text,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:InkWell(
      onTap: actionRow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  width: 30,
                  height: 30,
                  color: iconColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                 text.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.GREY_COLOR),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios
                  ,
              color: CustomColors.GREY_LIGHT_A_COLOR,
              size: 20,
            )

          ],
        ),
      ),
        ));
  }
}
