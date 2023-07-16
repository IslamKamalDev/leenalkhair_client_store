import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/providers/Branch/add_branch_provider.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_sliders_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/add_employee_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/employee_orders_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/employee_permissions_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/employee_profile_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/Sales_Returns/sales_returns_provider.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/providers/add_product_contract_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/business_info_provider.dart';
import 'package:leen_alkhier_store/providers/business_register_provider.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/cities_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/create_contract_provider.dart';
import 'package:leen_alkhier_store/providers/delivery_timing_duration_provider.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/providers/msg_provider.dart';
import 'package:leen_alkhier_store/providers/notes_provider.dart';
import 'package:leen_alkhier_store/providers/notification_bloc.dart';
import 'package:leen_alkhier_store/providers/offers/offers_provider.dart';
import 'package:leen_alkhier_store/providers/phoneCode_provider.dart';
import 'package:leen_alkhier_store/providers/reset_password_provider.dart';
import 'package:leen_alkhier_store/providers/screen_title_provider.dart';
import 'package:leen_alkhier_store/providers/sector_provider.dart';
import 'package:leen_alkhier_store/providers/tab_controller_provider.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/providers/user_verfiy_otp_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/PreferenceManger.dart';
import 'package:leen_alkhier_store/utils/Settings.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/fonts.dart';
import 'package:leen_alkhier_store/utils/local_notifications.dart';
import 'package:leen_alkhier_store/views/splash.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';


main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'i18n',
  );

  await Firebase.initializeApp();
  LocalNotifications.init();
  String? token = await FirebaseMessaging.instance.getToken();
  print("device token : ${token}");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //log("Message:${message.notification.toString()}");
    RemoteNotification? notification = message.notification;

    log("NotificationBody:${message.notification!.body}");
    log("NotificationTitle:${message.notification!.title}");

    var body = message.notification!.body;
    var title = message.notification!.title;

    String bodyM = "";
    String titleM = "";

    AndroidNotification? android = message.notification?.android;
    LocalNotification localNotification;
    OrderNotification orderNotification;

    if (notification != null && android != null && !kIsWeb) {
      if (MyMaterial.app_langauge == "ar") {
        titleM = title.toString();
        if (titleM.contains("رساله")) {
          bodyM = body.toString().replaceAll("لديك رساله جديده\n", "");
          localNotification = LocalNotification("admin", bodyM);
          NotificationsBloc.instance.newNotification(localNotification);
        } else if (titleM.contains('الطلب')) {
          bodyM = body.toString();
          orderNotification = OrderNotification(true);
          NotificationsBloc.instance.newOrderNotification(orderNotification);
        } else {
          bodyM = body.toString();
        }
      } else {
        titleM = title.toString();
        if (titleM.contains("message")) {
          bodyM = body.toString().replaceAll("You have a new message\n", "");
        } else if (titleM.contains("Order")) {
          bodyM = body.toString();

          orderNotification = OrderNotification(true);
          NotificationsBloc.instance.newOrderNotification(orderNotification);
        } else {
          bodyM = body.toString();
        }
      }

      LocalNotifications.showNotification(titleM, bodyM);
    }
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: TabControllerProvider()),
      ChangeNotifierProvider.value(value: ContractProductsProvider()),
      ChangeNotifierProvider.value(value: AddProductContractProvider()),
      ChangeNotifierProvider.value(value: HomeTabsProvider()),
      ChangeNotifierProvider.value(value: ProductProvider()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(
          value: ContractProductCartProductItemProvider()),
      ChangeNotifierProvider.value(
          value: OrderDetailsCartProductItemProvider()),
      ChangeNotifierProvider.value(value: UserOrderProvider()),
      ChangeNotifierProvider.value(value: UserAllContractOrderProvider()),
      ChangeNotifierProvider.value(value: ContractInfoProvider()),
      ChangeNotifierProvider.value(value: CreateContractProvider()),
      ChangeNotifierProvider.value(value: DeliveryTimingDurationProvider()),
      ChangeNotifierProvider.value(value: BusinessInfoProvider()),
      ChangeNotifierProvider.value(value: NoteProvider()),
      ChangeNotifierProvider.value(value: UserInfoProvider()),
      ChangeNotifierProvider.value(value: ResetPasswordProvider()),
      ChangeNotifierProvider.value(value: UserRegisterationProvider()),
      ChangeNotifierProvider.value(value: ScreenTitleProvider()),
      ChangeNotifierProvider.value(value: BusinessRegisterationProvider()),
      ChangeNotifierProvider.value(value: CitiesProvider()),
      ChangeNotifierProvider.value(value: UserProvider()),
      ChangeNotifierProvider.value(value: MsgProvider()),
      ChangeNotifierProvider.value(value: PhoneCodeProvider()),
      ChangeNotifierProvider.value(value: verfiyOtpProvider()),
      ChangeNotifierProvider.value(value: AllEmployeesProvider()),
      ChangeNotifierProvider.value(value: BusinessBranchesProvider()),
      ChangeNotifierProvider.value(value: EmployeePermissionsProvider()),
      ChangeNotifierProvider.value(value: AddEmployeeProvider()),
      ChangeNotifierProvider.value(value: EmployeeProfileProvider()),
      ChangeNotifierProvider.value(value: AddBranchProvider()),
      ChangeNotifierProvider.value(value: EmployeeOrdersProvider()),
      ChangeNotifierProvider.value(value: ContractPricingProvider()),
      ChangeNotifierProvider.value(value: SalesReturnsProvider()),
      ChangeNotifierProvider.value(value: SectorProvider()),
      ChangeNotifierProvider.value(value: DashboardPageProvider()),
      ChangeNotifierProvider.value(value: OffersProvider()),
      ChangeNotifierProvider.value(value: DashboardSlidersProvider()),
      ChangeNotifierProvider.value(value: OrderProvider()),
      ChangeNotifierProvider.value(value: ProductUnitsProvider()),
    ],
    child: LocalizedApp(
      child:MyMaterial()
    ),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
var navigatorKey = GlobalKey<NavigatorState>();

class MyMaterial extends StatefulWidget{
  static var app_langauge;

  @override
  MyMaterialState createState() => MyMaterialState();

  static void setLocale(BuildContext context, Locale newLocale) {
    MyMaterialState? state = context.findAncestorStateOfType();

    app_langauge = newLocale.languageCode;
    state?.setState(() => state.local = newLocale);
  }

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyMaterialState>()?.restartApp();
  }
}
class MyMaterialState extends State<MyMaterial> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Locale? local;
  Key? key = UniqueKey();
  void restartApp() {
    setState(() {
      get_Static_data();
      key = UniqueKey();
    });
  }

  void get_Static_data() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    await PreferenceManager.getInstance()!
        .getString(Constants.languageCode).then((value) {
          print("Constants.languageCode : ${value}");
      if (value == '') {
        MyMaterial.app_langauge = translator.activeLanguageCode;
      } else {
        MyMaterial.app_langauge = value;
      }
    });
    print("MyMaterial.app_langauge : ${MyMaterial.app_langauge}");
  }

  @override
  void initState() {
    get_Static_data();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        return ScreenUtilInit(
          designSize: Size(360, 690),
          builder: (_, child) => GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: CustomColors.PRIMARY_GREEN,
                fontFamily: (MyMaterial.app_langauge == "en")
                    ? CustomFonts.EN_FONT
                    : CustomFonts.AR_FONT),
            locale: local,
           supportedLocales: translator.locals(),

            navigatorObservers: <NavigatorObserver>[observer],
            localizationsDelegates: [/*
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,*/
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],

            home: Splash(),
          ),
        );
      },
    );
  }
}
