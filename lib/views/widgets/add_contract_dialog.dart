import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'custom_functions_views.dart';
import 'custom_rounded_btn.dart';
import 'custom_textfield.dart';

class AddToContractDialog extends StatelessWidget {
  String? unit;
  AddToContractDialog({this.unit});
  TextEditingController monthQuantityController = TextEditingController();
  TextEditingController orderQuantityController = TextEditingController();
  var quantityFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        'estimated_qty'.tr(),
        style: TextStyle(color: CustomColors.PRIMARY_GREEN),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: quantityFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                alignment: TextAlign.center,
                hasBorder: true,
                isMobile: true,
                errorMessage: 'enter_expected_qty',
                controller: monthQuantityController,
                //  lablel: '${locale.translate('expected_qty')} / $unit',
                lablel: 'expected_qty',
              ),
              SizedBox(
                height: 16,
              ),

              ////
              CustomTextField(
                alignment: TextAlign.center,
                hasBorder: true,
                isMobile: true,
                errorMessage: 'enter_expected_qty2',
                controller: orderQuantityController,
                // lablel: '${locale.translate('enter_order_qty')} / $unit',
                lablel: 'order_qty',
              ),
              SizedBox(
                height: 16,
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
                        if (quantityFormKey.currentState!.validate()) {
                          int mQ = int.parse(monthQuantityController.text);
                          int oQ = int.parse(orderQuantityController.text);
                          if (mQ < oQ) {
                            CustomViews.showSnackBarView(
                                title_status: false,
                                message: 'qty_validation_msg',
                                backgroundColor: CustomColors.RED_COLOR,
                                success_icon: false
                            );

                            return;
                          }
                          Navigator.pop(context, {
                            "accept": true,
                            "month_qty": monthQuantityController.text,
                            "order_qty": orderQuantityController.text
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
                        Navigator.pop(context, {"accept": false});
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
