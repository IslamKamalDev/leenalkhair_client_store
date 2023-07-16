import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/extensions/connectivity/network_indicator.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/sector_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/Settings.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/context_extensions.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_profile.dart';
import 'package:leen_alkhier_store/views/index.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/welcome_dialog.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login.dart';

class LoginOnBoarding extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<LoginOnBoarding> {
  AnalyticsService analytics = AnalyticsService();
  var loginFormKey = GlobalKey<FormState>();

  var loginScaffoldKey = GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool? KeepMeLogedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    var productsProvider = Provider.of<ProductProvider>(context, listen: false);
    productsProvider.getAllProduct();
    return NetworkIndicator(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              onPressed: () async {
                if (MyMaterial.app_langauge == 'ar') {
                  final newLang = 'en';
                  _changeLang(lang: newLang);
                } else {
                  final newLang = 'ar';
                  _changeLang(lang: newLang);
                }

                var citiesProvider = Provider.of<CitiesProvider>(context, listen: false);
                var sectorsProvider = Provider.of<SectorProvider>(context, listen: false);
                await citiesProvider.getAllCities();
                await sectorsProvider.resetSector();
                var catsProvider = Provider.of<CategoryProvider>(context, listen: false);
                var productsProvider = Provider.of<ProductProvider>(context, listen: false);
                await catsProvider.getAllCategories();
                await productsProvider.getAllProduct();

              },
              icon: Image.asset(
                ImageAssets.langIcon,
              ),
            ),
            Text(
              translator.activeLanguageCode == "ar" ? "English" : "عربى",
              style: TextStyle(color: CustomColors.BLACK_COLOR, fontSize: 14),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: Directionality(
      textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
    child:Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(35)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageAssets.leenWithyou,
                  scale: 1.5,
                ),

                SizedBox(
                  height: 70,
                ),
                Container(
                  height: ScreenUtil().setHeight(35),
                  child: CustomRoundedButton(
                    fontSize: 15,
                    text: kLogin,
                    textColor: Colors.white,
                    backgroundColor: CustomColors.PRIMARY_GREEN,
                    borderColor: CustomColors.PRIMARY_GREEN,
                    pressed: () {
                      analytics.setUserProperties(userRole: "Login Screen");
                      CustomViews.navigateTo(context, Login(), "");

                    },
                  ),
                ),

              ],
            ),
          ),
        ),
    )     ),
        ) );
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
