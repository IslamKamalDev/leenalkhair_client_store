import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_sliders_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_sliders_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/offers/offers_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Orders/orders_screen.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/dashboard_sections.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  List<FirstSlider> products_images = [];
  bool Confirme_Orders_status = false;

  @override
  void initState() {
    var contract_pricing_provider =
        Provider.of<ContractPricingProvider>(context, listen: false);
    contract_pricing_provider.getContractTypes();
    contract_pricing_provider.getContractPricingMethod();

    var offers_provider = Provider.of<OffersProvider>(context, listen: false);
    offers_provider.get_offers();
    var allEmployeesProvider =
        Provider.of<AllEmployeesProvider>(context, listen: false);
    allEmployeesProvider.tokenPermissionsRespnse.permissions!
        .forEach((element) {
      if (element.name == "Confirme Orders") {
        Confirme_Orders_status = true;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dashboardPageProvider = Provider.of<DashboardPageProvider>(context);
    var userInfoProvider = Provider.of<UserInfoProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        bottom: false,
        child: Directionality(
            textDirection: MyMaterial.app_langauge == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child:Scaffold(
            backgroundColor: CustomColors.GREY_COLOR_A,
            body:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              CustomColors.GREY_LIGHT_B_COLOR),
                                      borderRadius: BorderRadius.circular(30),
                                      color: CustomColors.PRIMARY_GREEN),
                                  padding: EdgeInsets.all(5),
                                  child: ClipOval(
                                    child: Image.asset(
                                      ImageAssets.profileInfo,
                                      color: CustomColors.WHITE_COLOR,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kwelcome.tr(),
                                      style: TextStyle(
                                          color:
                                              CustomColors.GREY_LIGHT_A_COLOR,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: screens(
                                  page_name: dashboardPageProvider.page_name) ??
                              SizedBox(),
                        )
                      ],
                    )),
              ),
            )),
      ),
    );
  }

  Widget dashboard_products({required List<FirstSlider> last_Slider}) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 12 / 10,
        ),
        itemCount: last_Slider.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    image: "${last_Slider[index].imageUrl}",
                    fit: BoxFit.fill,
                    placeholder: "assets/placeholder.png",
                  )),
            ),
          );
        });
  }

  Widget? screens({String? page_name}) {
    var tabedProvider = Provider.of<OrderProvider>(context, listen: true);

    switch (page_name) {
      case 'dashboard':
        print("dashboard");
        return SingleChildScrollView(
          child: Column(
            children: [
      /*        SizedBox(
                height: 5,
              ),
              DashboardSlider(
                first_slider: Shared.first_slider,
              ),*/
              SizedBox(
                height: ScreenUtil.defaultSize.width * 0.2,
              ),
        /*      Confirme_Orders_status
                  ? userInfoProvider.userInfoResponse!.draftOrders == 0
                      ? SizedBox()
                      : */InkWell(
                          onTap: () {
                            tabedProvider.setIndex(1);
                            CustomViews.navigateTo(
                                context, Orders(tabNum: 1), "");
                          },
                          child: OrdersDraftsNote())
               //   : Container()
              ,
              SizedBox(
                height: ScreenUtil.defaultSize.width  * 0.05,
              ),
              DashbordSections(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
        break;
  /*    case 'Home':
        print("Home");
        return Home();
        break;
      case 'DashboardAnalysisScreen':
        print("DashboardAnalysisScreen");
        return DashboardAnalysisScreen();
        break;
      case 'Orders':
        print("Orders");
        return Orders(
          type: "from_dashboard",
        );
        break;
      case '':
        break;*/
    }
    return null;
  }
}

class OrdersDraftsNote extends StatelessWidget {
  const OrdersDraftsNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfoProvider = Provider.of<UserInfoProvider>(context);
    return Container(
      // color: CustomColors.ORANGE,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.YELLOW),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipOval(
              child: Image.asset(
                ImageAssets.alert,
                width: 35,
                height: 35,
                color: CustomColors.GREY_COLOR,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              "${kyou_have.tr()} ( ${userInfoProvider.userInfoResponse!.draftOrders!} ) ${korder_not_ended.tr()} ... ",
              style: TextStyle(
                  color: CustomColors.GREY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
