import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/Units/contract_product_unit_response.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class ContractProductUnitsWidget extends StatefulWidget {
  BuildContext? ctx;
  var product_id;
  var contract_id;
  List<int?>? product_units_chossed = [];
  ContractProductUnitsWidget({this.ctx,this.product_id,this.product_units_chossed,this.contract_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContractProductUnitsWidgetState();
  }
}

class ContractProductUnitsWidgetState extends State<ContractProductUnitsWidget> {
  var quantityFormKey = GlobalKey<FormState>();
  TextEditingController monthQuantityController = TextEditingController();
  TextEditingController orderQuantityController = TextEditingController();
  List<TextEditingController> _controllers = [];
  List<Data>? product_units;
  @override
  void initState() {
    var product_units_provider = Provider.of<ProductUnitsProvider>(context,listen: false);

    if(widget.product_units_chossed!.isNotEmpty){
      product_units_provider.contractProductUnitResponse!.data!.removeWhere(
              (element) => widget.product_units_chossed!.contains(element.id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var product_units_provider = Provider.of<ProductUnitsProvider>(context);

    return StatefulBuilder(builder: (context, setState) {
      product_units = product_units_provider.contractProductUnitResponse!.data!;
      return GestureDetector(
          onTap: (){
        FocusScope.of(context).unfocus();
      },
        child: Container(
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
                      onTap: (){
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
              child:   Row(
              children: [
                Text(
                  kSelectQuatityPerUnit.tr(),

                  style: TextStyle(color: CustomColors.PRIMARY_GREEN,fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ],
            )),
              Form(
                key: quantityFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child:  Container(
                               alignment: Alignment.center,
                                child: Text(
                                   kunit.tr()
                                ),
                              ),
                            ),
                        Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                   kprice.tr()
                                ),
                              ),
                            ),
                        Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                    kquantity.tr()
                                ),
                              ),
                            ),

                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.defaultSize.width * .05,
                    ),
                    SizedBox(
                      height: ScreenUtil.defaultSize.width * .5, // 70% height
                      width: ScreenUtil.defaultSize.width ,
                      child: ListView.builder(
                          itemCount: product_units!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            _controllers.add(new TextEditingController(
                                text: product_units![index].quantity.toString())
                            );

                            return Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${translator.activeLanguageCode == "en"
                                                ? product_units![index].name.toString()
                                                : product_units![index].nameAr.toString()} "
                                                " ${product_units![index].weight==1 || product_units![index].weight==0? "" :
                                            product_units![index].weight.toString()}  ",
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),

                                          )

                                      ),
                                    ),
                                Expanded(
                                    flex:2,
                                    child: Container(
                                alignment: Alignment.center,
                                child: product_units![index].price == null ?
                                        Text(kUnder_review.tr(),
                                          style: TextStyle(fontSize: 13),)
                                            : product_units![index].offerPrice == 0 ?
                                        Center(
                                            child: Text(
                                              product_units![index].price.toString(),

                                            )
                                        )
                                            :Row(
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child:  Center(
                                                  child: Text(
                                                    product_units![index].price.toString(),
                                                    style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.red),
                                                  )),
                                            ),
                                            Expanded(
                                                flex:1,
                                                child:Center(
                                                  child:  Text(
                                                      product_units![index].offerPrice.toString()
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),

                                ),
                                Expanded(
                                    flex:2,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          height:ScreenUtil.defaultSize.width * 0.1,
                                          child: TextField(
                                            enabled: product_units![index].price == null ? false : true,
                                            textAlign: TextAlign.center,
                                            controller: _controllers[index],
                                            autofocus: false,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly ,],
                                            decoration: InputDecoration(
                                              hintText: kSelectQuantity.tr(),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color:  Colors.grey),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              contentPadding: EdgeInsets.all(1),

                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                          decoration: BoxDecoration(
                                              color: product_units![index].price == null
                                                  ? Colors.grey.shade400 :  Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                        )
                                    )
                                ),

                              ],
                            );
                          }),
                    ),

                    SizedBox(
                      height: ScreenUtil.defaultSize.width * .03,
                    ),

                    CustomRoundedButton(
                      fontSize: 15,
                      backgroundColor: CustomColors.PRIMARY_GREEN,
                      borderColor: CustomColors.PRIMARY_GREEN,
                      textColor: Colors.white,
                      text: kSave,
                      pressed: () {
                        List<UintEntity> contract_product_units_list = [];
                        for(int i=0 ; i < product_units_provider.contractProductUnitResponse!.data!.length ;i++){

                          contract_product_units_list.add(UintEntity(
                              product_id:  widget.product_id.toString(),
                              unit_id: product_units_provider.contractProductUnitResponse!.data![i].id,
                              quantity_per_unit: _controllers[i].text
                          ));


                        }
                        if(!contract_product_units_list.any((element) => element.quantity_per_unit != "" )){
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
                            "contract_product_units_list": contract_product_units_list,
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )


        )
        ),

      );
    });
  }
}
