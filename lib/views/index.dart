import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/providers/delivery_timing_duration_provider.dart';
import 'package:leen_alkhier_store/providers/notification_bloc.dart';
import 'package:leen_alkhier_store/providers/screen_title_provider.dart';
import 'package:leen_alkhier_store/providers/tab_controller_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/Store/Orders/orders_screen.dart';
import 'package:leen_alkhier_store/views/dashboard/dashboard_screen.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  late Stream<OrderNotification> _orderNotificationsStream;
  int currentIndex = 0;

  @override
  void initState() {
    var screenTitleProvider =
        Provider.of<ScreenTitleProvider>(context, listen: false);
    var dashboardPageProvider =
        Provider.of<DashboardPageProvider>(context, listen: false);

    setState(() {
      screenTitleProvider.setTitleFromIndex(0);
      dashboardPageProvider.setIndex("dashboard");
    });
    _orderNotificationsStream =
        NotificationsBloc.instance.orderNotificationsStream;

    _orderNotificationsStream.listen((event) {
      setState(() {});
    });
    var deliveryProvider =
        Provider.of<DeliveryTimingDurationProvider>(context, listen: false);
    var userRegister =
        Provider.of<UserRegisterationProvider>(context, listen: false);

    deliveryProvider.getDuration();
    deliveryProvider.getTime();

    var productsProvider = Provider.of<ProductProvider>(context, listen: false);

    productsProvider.getAllProduct();

    //get user contracts
    var contractInfoProvider = Provider.of<ContractInfoProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () {
      contractInfoProvider.getContract();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenTitleProvider = Provider.of<ScreenTitleProvider>(context);
    var tabeControllerProvider = Provider.of<TabControllerProvider>(context);
    var dashboardPageProvider = Provider.of<DashboardPageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:PersistentTabView(
        context,
        navBarHeight: 65,
        onItemSelected: (index) {
          screenTitleProvider.setTitleFromIndex(index);
          if (index == 0) dashboardPageProvider.setIndex("dashboard");
        },
        controller: tabeControllerProvider.controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: CustomColors.PRIMARY_GREEN, // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          //animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    ));
  }

  List<Widget> _buildScreens() {
    return [DashboardScreen(), Orders(), More()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(

        icon: Icon(CupertinoIcons.home),
        iconSize: 20,
        title: "bottom_home".tr(),
        // title: Text(
        //   "${translator.translate("bottom_home")}",
        //   style: TextStyle(fontSize: 12, color: CustomColors.WHITE_COLOR),
        // ),
        activeColorPrimary: CustomColors.WHITE_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        // icon: Image.asset(
        //   ImageAssets.orders,
        //   width: MediaQuery.of(context).size.width * 0.04,
        //   height: MediaQuery.of(context).size.width * 0.04,
        // ),
        icon: Icon(Icons.ballot),
        iconSize: 20,
        title: "bottom_orders".tr(),
        // title: Text(
        //   "${translator.translate("bottom_orders")}",
        //   style: TextStyle(fontSize: 12, color: CustomColors.WHITE_COLOR),
        // ),
        activeColorPrimary: CustomColors.WHITE_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        // icon: Image.asset(
        //   ImageAssets.setting,
        //   width: MediaQuery.of(context).size.width * 0.04,
        //   height: MediaQuery.of(context).size.width * 0.04,
        // ),

        icon: Icon(Icons.settings),
        iconSize: 20,
        title: "setting".tr(),
        // title: Text(
        //   "${translator.translate("setting")}",
        //   style: TextStyle(fontSize: 12, color: CustomColors.WHITE_COLOR),
        // ),
        activeColorPrimary: CustomColors.WHITE_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
