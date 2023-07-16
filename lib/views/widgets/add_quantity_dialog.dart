import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'custom_functions_views.dart';
import 'custom_rounded_btn.dart';
import 'custom_textfield.dart';

class addQuntityDialog extends StatefulWidget {
  String? quantity;
  addQuntityDialog({this.quantity});

  @override
  _addQuntityDialogState createState() => _addQuntityDialogState();
}

class _addQuntityDialogState extends State<addQuntityDialog> {
  TextEditingController QuantityController = TextEditingController();

  var quantityFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    QuantityController.text = widget.quantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'select_quantity'.tr(),
          style: TextStyle(color: CustomColors.PRIMARY_GREEN),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: quantityFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                isQuantity: true,
                alignment: TextAlign.center,
                hasBorder: true,
                errorMessage: 'select_quantity',
                controller: QuantityController,
                isMobile: false,
                // lablel: '',
                lablel: 'expected_qty',
                filledColor: Colors.white,
                isEditable: true,
              ),
              SizedBox(
                height: 16,
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
                      text: update,
                      pressed: () {
                        if (quantityFormKey.currentState!.validate() &&
                            validateInputs(context, ctx: context)) {
                          Navigator.pop(context, {
                            "accept": true,
                            "Quantity": double.parse(QuantityController.text)
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
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

  bool validateInputs(BuildContext context, {var scaffoldKey, var ctx}) {
    try {
      if (QuantityController.text.contains('-') ||
          QuantityController.text.contains('.')) {
        CustomViews.showSnackBarView(
            title_status: false,
            message: 'enter_valid_number',
            backgroundColor: CustomColors.RED_COLOR,
            success_icon: false
        );

        return false;
      } else {
        double num = double.parse(QuantityController.text);
        return true;
      }
    } catch (e) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: 'enter_valid_number',
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
  }
}
