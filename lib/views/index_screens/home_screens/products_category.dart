import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/add_product_contract_provider.dart';

import 'package:leen_alkhier_store/providers/all_products_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/contract_product_Local.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/package_receive_confirmation_screen.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/home_product_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCategoryWidget extends StatefulWidget{
   int? categoryId;
  final ScrollController? scrollController;
  // bool? show_products;
  ProductsCategoryWidget({
    this.categoryId,
    this.scrollController,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsCategoryWidgetState();
  }

}
class ProductsCategoryWidgetState extends State<ProductsCategoryWidget> {
  String? selected_branch_id;
  String? selected_branch_name;
  AnalyticsService analytics = AnalyticsService();
  @override
  void initState() {
    get_business_info_id();
    getData();
    super.initState();
  }

  void get_business_info_id() async {
    await SharedPreferences.getInstance().then((value) {
      Shared.business_info_id = value.getInt("business_info_id");
    });
  }

  getData() {
    var contractProducts =
    Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider =
    Provider.of<ContractProductCartProductItemProvider>(context,
        listen: false);
    var userInfoProvider =
    Provider.of<UserInfoProvider>(context, listen: false);
    var allEmployeesProvider =
    Provider.of<AllEmployeesProvider>(context, listen: false);
    setStateIfMounted(() {
      Future.delayed(Duration(seconds: 1), () {
        userInfoProvider.getUserInfo();
      }).whenComplete(() {
        if (userInfoProvider.userInfoResponse!.contractStatus == "Approved") {
          allEmployeesProvider.getEmployeeBranches().then((value) {
            value!.branches!.forEach((element) async {
              if (value.branches!.indexOf(element) == 0) {
                var businessBranchesProvider;
                if (mounted)
                  businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context, listen: false);
                businessBranchesProvider.changeBranch(element);
                contractsProductsCartProvider.clearContractProductsResponse();
                selected_branch_id =  element.id.toString();
                selected_branch_name =  element.name.toString();
                allEmployeesProvider.selected_employee_branch_id = element.id.toString();
                await contractProducts
                    .getContractProducts(branch_id: element.id.toString())
                    .then((value) {
                  contractsProductsCartProvider
                      .setContractsProductsResponse(value);
                });
              }
            });
          });
        }
      });
    });

    var contractPricingProvider =
    Provider.of<ContractPricingProvider>(context, listen: false);
    contractPricingProvider.getContractTypes();
    contractPricingProvider.getContractPricingMethod();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
  @override
  Widget build(BuildContext context) {
    var homeTabsProvider = Provider.of<HomeTabsProvider>(context);
   var productsProvider = Provider.of<ProductProvider>(context);
    var addProductContractProvider = Provider.of<AddProductContractProvider>(context);
    var contractProducts = Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider = Provider.of<ContractProductCartProductItemProvider>(context);

    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context,listen: true);
    allEmployeesProvider.businessBranchesResponse!.branches!
        .removeWhere((element) => element.id == "0");
    //get user contracts
    var contractInfoProvider = Provider.of<ContractInfoProvider>(context, listen: false);
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          productsProvider.getAllProduct();
          contractsProductsCartProvider.clearContractProductsResponse();

          var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);
          allEmployeesProvider.getEmployeeBranches().then((value) {
            value!.branches!.forEach((element) {
              if (value.branches!.indexOf(element) == 0) {
                var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context, listen: false);
                businessBranchesProvider.changeBranch(element);
                contractsProductsCartProvider.clearContractProductsResponse();
                contractProducts.getContractProducts(branch_id: element.id.toString()).then((value) {
                  contractsProductsCartProvider.setContractsProductsResponse(value);
                });
              }
            });
          });

          // return true;
        },
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        edgeOffset: 0.0,
        displacement: 0.0,
        strokeWidth: 0.0,
        child: (productsProvider.allProductsResponse.data == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !productsProvider.allProductsResponse.data!.any(
                (element) => element.categoryId == widget.categoryId,
              ) ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                                '${translator.activeLanguageCode == 'ar' ?  "لا يوجد منتجات حاليا " : "No Products Found"}'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [

          /*            contractInfoProvider.contractInfoResponse!.data!.where((element) =>
                      element.status == "Approved" && element.pricingType!.name
                          == "Daily price lists").length >= 1 ?
                      allEmployeesProvider.businessBranchesResponse!.branches!.length > 1
                          ? branch_selector()
                          : Container()
                      : Container(),*/
                      
                      
                      
                      Expanded(
                        child:
                            OrientationBuilder(builder: (context, orientation) {
                          return GetBuilder<ContractProductLocal>(
                              init: ContractProductLocal(),
                              builder: (controller) {
                                if (homeTabsProvider.index == -1) {
                                  return GridView.count(
                                    controller: widget.scrollController,
                                    crossAxisCount: orientation == Orientation.portrait ? 3 : 4,
                                    childAspectRatio: ScreenUtil.defaultSize.aspectRatio * 1.1,
                                    crossAxisSpacing: ScreenUtil().setWidth(8),
                                    children: [
                                      ...productsProvider.allProductsResponse.data!
                                          .map((e) => HomeProductItem(
                                                productModel: e,)).toList(),
                                    ],
                                  );
                                } else {
                                  return GridView.count(
                                    controller: widget.scrollController,
                                    crossAxisCount:
                                        orientation == Orientation.portrait ? 3 : 4,
                                    childAspectRatio: ScreenUtil.defaultSize.aspectRatio * 1.1,
                                    crossAxisSpacing: ScreenUtil().setWidth(8),
                                    children: [
                                      ...productsProvider
                                          .allProductsResponse.data!
                                          .where((element) =>
                                              element.categoryId == widget.categoryId)
                                          .map((e) => HomeProductItem(
                                                productModel: e,
                                              ))
                                          .toList(),
                                    ],
                                  );
                                }
                              });
                        }),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: OrientationBuilder(
                              builder: (context, orientation) => Container(
                                child: GetBuilder<ContractProductLocal>(
                                  init: ContractProductLocal(),
                                  builder: (controller) => Wrap(
                                    children: [
                                      CustomRoundedButton(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          backgroundColor: addProductContractProvider.selected ? CustomColors.RED_COLOR :
                                          CustomColors.GREY_LIGHT_A_COLOR ,
                                          fontSize: 12,
                                          borderColor: addProductContractProvider.selected ? CustomColors.RED_COLOR :
                                          CustomColors.GREY_LIGHT_A_COLOR  ,
                                          text: knext,
                                          textColor: CustomColors.WHITE_COLOR,
                                          pressed: () {
                                              addProductContractProvider.addProductContract(
                                                branch_id: selected_branch_id
                                              ).then((value) async {
                                                print("aa : ${addProductContractProvider.addProductToContractResponse.toJson()}");
                                                if (addProductContractProvider.addProductToContractResponse.status!) {
                                                  addProductContractProvider.addProductToContractResponse.data!.forEach((e) {
                                                    controller.addToContractLocal(e.id);
                                                    productsProvider.allProductsResponse.data!.forEach((element) {
                                                      if (element.id == e.id) {
                                                        element.productStatus = true;
                                                        element.contractStatus = true;

                                                      }
                                                    });
                                                  });
                                                //  contractProductsList = [];
                                                  CustomViews.showSnackBarView(
                                                      title_status: true,
                                                      backend_message: addProductContractProvider.addProductToContractResponse.message,
                                                      backgroundColor: CustomColors.PRIMARY_GREEN,
                                                      success_icon: true
                                                  );
                                                  addProductContractProvider.productRemoved();
                                                  analytics.setUserProperties(
                                                      userRole: "PackageRecieveConfirmation");
                                                  CustomViews.navigateTo(
                                                      context,
                                                      PackageRecieveConfirmation(),
                                                      "PackageRecieveConfirmation");
                                                }
                                                else {
                                                  CustomViews.showSnackBarView(
                                                      title_status: false,
                                                      backend_message: addProductContractProvider.addProductToContractResponse.message,
                                                      backgroundColor: CustomColors.RED_COLOR,
                                                      success_icon: false
                                                  );

                                                }

                                              });


                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
      ),
    );
  }

  Widget branch_selector() {
    List<Branches> branchList = [];
    var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context);
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context);

    Provider.of<AllEmployeesProvider>(context, listen: false)
        .businessBranchesResponse!
        .branches!
        .forEach((element) {
      branchList.add(element);
    });
    allEmployeesProvider.businessBranchesResponse!.branches!
        .removeWhere((element) => element.id == "0");
    // setState(() {});
// sort branches list to gell all branches in top of list

    branchList.sort((a, b) => a.id.toString().compareTo(b.id.toString()));

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          height: ScreenUtil().setHeight(35),
          //   width: MediaQuery.of(context).size.width * 0.75,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: CustomColors.WHITE_COLOR,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      child: DropdownButton(
                          value: businessBranchesProvider.selectedBranch,
                          //      menuMaxHeight:  MediaQuery.of(context).size.width * 0.5,
                          hint: Text(businessBranchesProvider.selectedBranch ==
                              null
                              ? allEmployeesProvider
                              .businessBranchesResponse!.branches![allEmployeesProvider.businessBranchesResponse!.branches!.length - 1]
                              .name
                              : businessBranchesProvider.selectedBranch!.name ??
                              ""),
                          underline: Container(),
                          isExpanded: true,
                          items: branchList.map((e) {
                            return DropdownMenuItem(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                          //   menuMaxHeight: MediaQuery.of(context).size.width * 0.7,

                          onChanged: (dynamic v) {
                            businessBranchesProvider.changeBranch(v);
                            selected_branch_id = v.id.toString();
                            selected_branch_name = v.name.toString();
                            allEmployeesProvider.changeSelected_employee_branch(
                                branch_id: v.id.toString(),
                                branch_name: v.name
                            ) ;

                            var contractProducts = Provider.of<ContractProductsProvider>(context, listen: false);
                            var contractsProductsCartProvider = Provider.of<ContractProductCartProductItemProvider>(context, listen: false);
                            contractsProductsCartProvider.clearContractProductsResponse();
                            contractProducts.getContractProducts(branch_id: v.id.toString()).then((value) {
                              contractsProductsCartProvider
                                  .setContractsProductsResponse(value);
                            });
                          })))
            ],
          ),
        ));
  }
}
