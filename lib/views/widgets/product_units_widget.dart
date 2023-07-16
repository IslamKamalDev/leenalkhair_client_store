import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/all_products_response.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:leen_alkhier_store/data/responses/Units/contract_product_unit_response.dart';

class ProductUnitsWidget extends StatefulWidget {
  BuildContext? ctx;
  var productModel;
  ProductUnitsWidget({this.ctx,this.productModel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductUnitsWidgetState();
  }
}

class ProductUnitsWidgetState extends State<ProductUnitsWidget> {
  var quantityFormKey = GlobalKey<FormState>();

  List<TextEditingController> _quantity_controllers = [];
  List<TextEditingController> _price_controllers = [];
  List<Data>? productUnitList = [];
  @override
  void initState() {
    var product_units_provider = Provider.of<ProductUnitsProvider>(context,listen: false);
    product_units_provider.contractProductUnitResponse!.data!.where(
            (element) => element.onContract == false).forEach((element) {
      productUnitList!.add(element);
    });

    if(contractProductsList.isNotEmpty){
      contractProductsList.forEach((product) {
        if(product.product_id == widget.productModel!.id)
        product.units!.forEach((unit) {
          print("unit.price : ${unit.price}");
          productUnitList!.firstWhere(
                  (element) => element.id == unit.unit_id).quantity = int.parse(unit.quantity_per_unit);
          productUnitList!.firstWhere(
                  (element) => element.id == unit.unit_id).price  = int.parse(unit.price);
       /*   productUnitList!.removeWhere(
                  (element) => element.id ==unit.unit_id);*/
        });
      });


    }

    super.initState();
  }

  @override
  void dispose() {
    productUnitList  =[];
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return StatefulBuilder(builder: (context, setState) {
      return  GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: productUnitList!.isEmpty ? Container(
          child: Text(kProduct_units_filled.tr()),
        )
            : Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),

          child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(widget.ctx!, {"accept": false});

                        },
                        child: Container(
                          child: Image.asset(ImageAssets.close),
                          width: ScreenUtil.defaultSize.width * 0.1,
                          height: ScreenUtil.defaultSize.width * 0.1,
                          // color: Colors.red,
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child:  Row(
                    children: [
                      Text(
                       kSelectQuatityPerUnit.tr(),
                        style: TextStyle(color: CustomColors.PRIMARY_GREEN,fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ],

              ),
        ),

              Form(
                key: quantityFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: ScreenUtil.defaultSize.width * 0.6, // 70% height
                      width: ScreenUtil.defaultSize.width ,
                      child: ListView.builder(
                          itemCount: productUnitList!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            _quantity_controllers.add(new TextEditingController(
                              text: productUnitList![index].quantity == 0 ? kquantity.tr() :productUnitList![index].quantity.toString(),
                            ));
                            _price_controllers.add(new TextEditingController(
                              text: productUnitList![index].price == 0 ? kprice.tr() :productUnitList![index].price.toString(),
                            ));
                            return Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                    alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              Text(
                                                  translator.activeLanguageCode == "en"
                                                      ? productUnitList![index].name.toString()
                                                      : productUnitList![index].nameAr.toString()
                                              ),
                                              productUnitList![index].weight ==1 ||  productUnitList![index].weight ==0 ? Container() :   Text(
                                                  "  ${productUnitList![index].weight.toString()}    "
                                              ),
                                            ],
                                          )
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          height:ScreenUtil.defaultSize.width * 0.1,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: _quantity_controllers[index],
                                            autofocus: false,

                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly ,
                                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),],
                                            decoration: InputDecoration(
                                              hintText: kquantity.tr(),
                                              hintStyle: TextStyle(fontSize: 10.0),
                                              border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                              ),
                                              contentPadding: EdgeInsets.all(5),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ))),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          height:ScreenUtil.defaultSize.width * 0.1,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: _price_controllers[index],
                                            autofocus: false,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly ,
                                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),],
                                            decoration: InputDecoration(
                                              hintText: kprice.tr(),
                                              hintStyle: TextStyle(fontSize: 10.0),
                                              border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                              ),
                                              contentPadding: EdgeInsets.all(5),
                                            ),

                                            keyboardType: TextInputType.number,
                                          ),
                                        )))
                              ],
                            );


                          }),
                    ),

                    SizedBox(
                      height: ScreenUtil.defaultSize.width * .1,
                    ),
                    CustomRoundedButton(
                      fontSize: 15,
                      backgroundColor: CustomColors.PRIMARY_GREEN,
                      borderColor: CustomColors.PRIMARY_GREEN,
                      textColor: Colors.white,
                      text: kSave,
                      pressed: () {

                        List<UintEntity> product_units_list = [];

                        for(int i=0 ; i < productUnitList!.length ;i++){
                          if((_quantity_controllers[i].text !=  kquantity.tr() && _quantity_controllers[i].text != "")
                          && (_price_controllers[i].text !=  kprice.tr() && _price_controllers[i].text != "")){
                            product_units_list.add(UintEntity(
                                unit_id: productUnitList![i].id,
                                quantity_per_unit: _quantity_controllers[i].text,
                              price: _price_controllers[i].text
                            ));
                          }

                        }
                        if(product_units_list.isEmpty){
                          CustomViews.showSnackBarView(
                              title_status: false,
                              message: kMustChosseUnit,
                              backgroundColor: CustomColors.RED_COLOR,
                              success_icon: false
                          );

                          return;
                        }else{
                          Navigator.pop(widget.ctx!, {
                            "accept": true,
                            "product_units_list": product_units_list,

                          });
                        }


                      },
                    ),
                  ],
                ),
              ),
            ],
          )


        ),
      )


/*        child: AlertDialog(
        title: Text(
           translator.translate(kSelectQuatityPerUnit)!,

          style: TextStyle(color: CustomColors.PRIMARY_GREEN),
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),

          ),
        content: productUnitList!.isEmpty ? Container(
          child: Text(locale.translate(kProduct_units_filled)!),
        )
            : SingleChildScrollView(
            child:Form(
              key: quantityFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(
                    height: ScreenUtil.defaultSize.width * .7, // 70% height
                    width: ScreenUtil.defaultSize.width * .9,
                    child: ListView.builder(
                        itemCount: productUnitList!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                            _controllers.add(new TextEditingController());
                            return Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey.shade400)),
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Text(
                                                  translator.activeLanguageCode == "en"
                                                      ? productUnitList![index].name.toString()
                                                      : productUnitList![index].nameAr.toString()
                                              ),
                                              Text(
                                                  "  ${productUnitList![index].weight.toString()}    "
                                              ),
                                            ],
                                          )
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          child: TextField(
                                            textAlign: TextAlign.start,
                                            controller: _controllers[index],
                                            autofocus: true,

                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly ,
                                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),],
                                            decoration: InputDecoration(
                                              hintText: locale.translate(kSelectQuantity),
                                              border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.grey),
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                              ),
                                              contentPadding: EdgeInsets.all(5),
                                            ),
                                            keyboardType: TextInputType.text,
                                          ),
                                        )))
                              ],
                            );


                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomRoundedButton(
                          fontSize: 15,
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                          borderColor: CustomColors.PRIMARY_GREEN,
                          textColor: Colors.white,
                          text: accept,
                          pressed: () {

                            List<UintEntity> product_units_list = [];

                            for(int i=0 ; i < productUnitList!.length ;i++){
                            if(_controllers[i].text.isNotEmpty ){
                                product_units_list.add(UintEntity(
                                    unit_id: productUnitList![i].id,
                                    quantity_per_unit: _controllers[i].text
                                ));
                              }

                            }
                            if(product_units_list.isEmpty){
                              CustomViews.showSnackBarView(
                                  title_status: false,
                                  message: kMustChosseUnit,
                                  backgroundColor: CustomColors.RED_COLOR,
                                  success_icon: false
                              );

                              return;
                            }else{
                              Navigator.pop(widget.ctx!, {
                                "accept": true,
                                "product_units_list": product_units_list,

                              });
                            }


                          },
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      Expanded(
                        child: CustomRoundedButton(
                          fontSize: 15,
                          backgroundColor: CustomColors.ORANGE,
                          borderColor: CustomColors.ORANGE,
                          textColor: Colors.white,
                          text: cancel,
                          pressed: () {
                            Navigator.pop(widget.ctx!, {"accept": false});
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),*/
      );
    });
  }
}
