import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_sliders_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/delivery_timing_duration_provider.dart';
import 'package:leen_alkhier_store/providers/pages_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'index.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AnalyticsService analytics = AnalyticsService();
  @override
  void initState() {
  var dashboardSlidersProvider = Provider.of<DashboardSlidersProvider>(context, listen: false);
    var deliveryProvider = Provider.of<DeliveryTimingDurationProvider>(context, listen: false);
    var contractPricingProvider = Provider.of<ContractPricingProvider>(context, listen: false);
    var categoriesProvider = Provider.of<CategoryProvider>(context, listen: false);

    deliveryProvider.getDuration();
    deliveryProvider.getTime();

    contractPricingProvider.getContractTypes();
    contractPricingProvider.getContractPricingMethod();

    categoriesProvider.getAllCategories();
    var citiesProvider = Provider.of<CitiesProvider>(context,listen: false);

    citiesProvider.getAllCities();
    dashboardSlidersProvider.getDashboardSliders().then((value) async {
      Shared.first_slider = [];
      Shared.last_Slider = [];
      Shared.single = [];
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("remove_account", value!.deleteAccount!);
      value.firstSlider!.forEach((element) {
        Shared.first_slider.add(element);
      });
      value.lastSlider!.forEach((element) {
        Shared.last_Slider.add(element);
      });
      value.single!.forEach((element) {
        Shared.single.add(element);
      });
    });

    super.initState();
    _showVersionChecker(context);
  }

  @override
  Widget build(BuildContext context) {
    var productsProvider = Provider.of<ProductProvider>(context, listen: false);

    productsProvider.getAllProduct();

    return Scaffold(
          backgroundColor: CustomColors.PRIMARY_GREEN,
          body:  SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [ Image.asset(
                  ImageAssets.splash,
                  height: ScreenUtil.defaultSize.height,
                  width: ScreenUtil.defaultSize.width,
                  fit: BoxFit.fill,
                  // scale: 1.5,
                ),],
              ),
            )
          )
    );
  }

  _showVersionChecker(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String urlAndroid =
        "https://play.google.com/store/apps/details?id=com.leenalkhair.store";
    String urlIos = "https://apps.apple.com/sa/app/leenalkhair/id1585888145";

    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    await userInfoProvider.getAppVersion().whenComplete(() async {
      if (userInfoProvider.appVersionResponse!.status!) {
        Shared.min_app_version = userInfoProvider.appVersionResponse!.data;
        if (Shared.min_app_version != "") {
          print("buildNumber : ${buildNumber}");
          if (int.parse(buildNumber) <=  int.parse(Shared.min_app_version)) {
            getData(context);
          } else {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "update_app".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                content: Text("update_avilable_content".tr()),
                actions: [
                  TextButton(
                    child: Text("cancel".tr()),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                        "update_now".tr()),
                    onPressed: () {
                      Platform.isAndroid
                          ? _launchURL(urlAndroid)
                          : _launchURL(urlIos);
                    },
                  )
                ],
              ),
            );
          }
        } else {
          getData(context);
        }
      }
    });
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

final PreferenceManager _appPreferences = PreferenceManager();

void getData(BuildContext context) async {
  AnalyticsService analytics = AnalyticsService();
  Future.delayed(Duration(seconds: 2), () async {
    String? Token = TokenUtil.getTokenFromMemory();
    if (Token != null && Token.isNotEmpty) {
      var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);
      allEmployeesProvider.getEmployeeBranches()
          .then((value) {
        if (value!.branches!.isEmpty) {
          Shared.user_has_branches = false;
        } else {
          Shared.user_has_branches = true;
        }
      });
      Shared.pages = await PagesProvider.getPages();
    }
    //   String userName = await PreferenceManager.getInstance().getString("username");
    //  String password = await PreferenceManager.getInstance().getString("password");
    String? Tokenn = await PreferenceManager.getInstance()!.getString("Token");
    bool? isLogged =
        await PreferenceManager.getInstance()!.getBoolean("KkeepMeLoggedIn");
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    var productsProvider = Provider.of<ProductProvider>(context, listen: false);

    if ((Tokenn == null || Tokenn.isEmpty || Tokenn.length == 0) ||
        isLogged == null ||
        isLogged == false) {
      analytics.setUserProperties(userRole: "Login OnBoarding Screen");

      CustomViews.navigateToRepalcement(
          context, LoginOnBoarding(), "Login OnBoarding Screen");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => LoginOnBoarding()));
    } else {
      await TokenUtil.saveToken(Tokenn);
      await userInfoProvider.getUserInfo();

      //get and save user permissions
      var allEmployeesProvider =
          Provider.of<AllEmployeesProvider>(context, listen: false);
      allEmployeesProvider.setUserPermissons(token: Tokenn);

      allEmployeesProvider.getEmployeeBranches()
          .then((value) {
        if (value!.branches!.isEmpty) {
          Shared.user_has_branches = false;
        } else {
          Shared.user_has_branches = true;
        }
      });

      if (userInfoProvider.userInfoResponse != null) {
        Shared.pages = await PagesProvider.getPages();
        await productsProvider.getAllProduct();
        Shared.business_info_id =
            userInfoProvider.userInfoResponse!.data!.businessInfoId;

        var dashboardSlidersProvider =
            Provider.of<DashboardSlidersProvider>(context, listen: false);
        dashboardSlidersProvider.getDashboardSliders().then((value) {
          Shared.first_slider = [];
          value!.firstSlider!.forEach((element) {
            Shared.first_slider.add(element);
          });
          value.lastSlider!.forEach((element) {
            Shared.last_Slider.add(element);
          });
          value.single!.forEach((element) {
            Shared.single.add(element);
          });
        }).whenComplete(() {
          _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
                if (isUserLoggedIn)
                  {
                    analytics.setUserProperties(userRole: "Index Screen"),
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => Index()))
                  }
                else
                  {
                    analytics.setUserProperties(userRole: "Index Screen"),
                    CustomViews.navigateToRepalcement(
                        context, LoginOnBoarding(), "Index Screen"),
                  }
              });
        });
      }
      else {
        analytics.setUserProperties(userRole: "Login OnBoarding Screen");
        CustomViews.navigateToRepalcement(
            context, LoginOnBoarding(), "Login OnBoarding Screen");

      }
    }
  });
}
