import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/all_cats_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/home_screens/products_category.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/title_text.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class CreateProducts extends StatefulWidget {
  bool islogin;
  String title;
  CreateProducts({required this.islogin, required this.title});
  @override
  _CreateProductsState createState() => _CreateProductsState();
}

class _CreateProductsState extends State<CreateProducts> {
  final GlobalKey<ScaffoldState> signupProductsScaffoldKey =
      GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    var categoriesProvider = Provider.of<CategoryProvider>(context);
    var homeTabsProvider = Provider.of<HomeTabsProvider>(context);
    final _scrollController = ScrollController();
    return Scaffold(
      key: signupProductsScaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomViews.appBarWidget(
      context: context,
      title: widget.title,
        draft_icon: true
    ) ,
      body:Directionality(
      textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        // color: Colors.white,
        child: Column(
          children: [
            widget.islogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleWithImage(
                        icon: ImageAssets.contractAdd,
                        text: translator
                            .translate(kcontract_info),
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
                        icon: ImageAssets.productsinfo,
                        text: translator
                            .translate(kproduct_info)!,
                        iconcolor: CustomColors.WHITE_COLOR,
                        backgroundcolor2: CustomColors.PRIMARY_GREEN,
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getData();
                  // return true;
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(5)),
                  color: CustomColors.GREY_COLOR_A,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  homeTabsProvider.setIndex(-1);

                                },
                                child: Text('all_products'.tr(),),
                                color: (homeTabsProvider.index == -1)
                                    ? CustomColors.PRIMARY_GREEN
                                    : CustomColors.WHITE_COLOR,
                                textColor: (homeTabsProvider.index == -1)
                                    ? CustomColors.WHITE_COLOR
                                    : CustomColors.PRIMARY_GREEN,
                              ),
                            ),
                            categoriesProvider.allCategoriesResponse == null
                                ? Container()
                                : Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      ...categoriesProvider
                                          .allCategoriesResponse!.data!
                                          .map((e) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      side: BorderSide(
                                                          color: (homeTabsProvider
                                                                      .index) ==
                                                                  categoriesProvider
                                                                      .allCategoriesResponse!
                                                                      .data!
                                                                      .indexOf(
                                                                          e)
                                                              ? CustomColors
                                                                  .PRIMARY_GREEN
                                                              : CustomColors
                                                                  .WHITE_COLOR)),

                                                  onPressed: () {
                                                    // setState(() {
                                                    //   show_all_products = false;
                                                    // });
                                                    homeTabsProvider.setIndex(
                                                        categoriesProvider
                                                            .allCategoriesResponse!
                                                            .data!
                                                            .indexOf(e));
                                                    homeTabsProvider
                                                        .setCategory(e);
                                                    if (_scrollController
                                                        .hasClients)
                                                      _scrollController
                                                          .animateTo(0,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      100),
                                                              curve: Curves
                                                                  .bounceInOut);
                                                  },
                                                  child: Text(e.name!),
                                                  //   color: CustomColors.WHITE_COLOR,
                                                  color: (homeTabsProvider
                                                              .index) ==
                                                          categoriesProvider
                                                              .allCategoriesResponse!
                                                              .data!
                                                              .indexOf(e)
                                                      ? CustomColors
                                                          .PRIMARY_GREEN
                                                      : CustomColors
                                                          .WHITE_COLOR,
                                                  textColor: (homeTabsProvider
                                                              .index) ==
                                                          categoriesProvider
                                                              .allCategoriesResponse!
                                                              .data!
                                                              .indexOf(e)
                                                      ? CustomColors.WHITE_COLOR
                                                      : CustomColors
                                                          .PRIMARY_GREEN,
                                                ),
                                              ))
                                    ],
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ProductsCategoryWidget(
                        categoryId: homeTabsProvider.categoryModel!.id!,
                        scrollController: _scrollController,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )  ),
    );
  }

  getData() {
    var contractProducts =
        Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context,
            listen: false);
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    Future.delayed(Duration(seconds: 1), () async {
      userInfoProvider.getUserInfo();
      contractsProductsCartProvider.clearContractProductsResponse();
      var allEmployeesProvider =
          Provider.of<AllEmployeesProvider>(context, listen: false);
      await allEmployeesProvider.getEmployeeBranches().then((value) {
        value!.branches!.removeWhere((element) => element.id == '0');
        value.branches!.forEach((element) async {
          if (value.branches!.indexOf(element) == 0) {
            var businessBranchesProvider =
                Provider.of<BusinessBranchesProvider>(context, listen: false);
            businessBranchesProvider.changeBranch(element);
            userInfoProvider.getUserInfo();
            contractsProductsCartProvider.clearContractProductsResponse();

            await contractProducts
                .getContractProducts(branch_id: element.id.toString())
                .then((value) {
              contractsProductsCartProvider.setContractsProductsResponse(value);
            });
          }
        });
      });
    });
  }


}
