import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:leen_alkhier_store/data/responses/active_timing_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class SelectAppointmentDialog extends StatefulWidget {
  @override
  _SelectAppointmentDialogState createState() => _SelectAppointmentDialogState();
}

class _SelectAppointmentDialogState extends State<SelectAppointmentDialog> {
  DateTime? selectedDateTime;
  ActiveTimeModel? activeTimeModel;
  @override
  Widget build(BuildContext context) {
    var contractProducts =
        Provider.of<ContractProductsProvider>(context, listen: false);
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child:Directionality(
          textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
          child: Column(
            children: [
              (selectedDateTime != null)
                  ? Row(
                      children: [
                        Text("deliver_date".tr()),
                      ],
                    )
                  : Container(),


              Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
                child: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        minTime: DateTime.parse(contractProducts.activeTimingResponse.data![0].currentDate!),
                        maxTime: DateTime.parse(contractProducts.activeTimingResponse.data![0].currentDate!).add(Duration(days: 2)),
                        locale: translator.activeLanguageCode == "ar" ? LocaleType.ar : LocaleType.en,
                        onConfirm: (dt) {
                      selectedDateTime = dt;
                      activeTimeModel = null;
                      setState(() {});
                    },

                    );
                  },
                  child: Text((selectedDateTime == null)
                      ? "deliver_date".tr()
                      : selectedDateTime.toString().split(" ")[0]),
                ),
              ),
              // ),
              SizedBox(
                height: 10,
              ),
              (selectedDateTime == null)
                  ? Container()
                  : Column(
                      children: [
                        (activeTimeModel != null)
                            ? Row(
                                children: [
                                  Text('deliver_time'.tr()),
                                ],
                              )
                            : Container(),

                        (contractProducts.activeTimingResponse.data!.any((element) => element.currentDate ==
                                    selectedDateTime.toString().split(" ")[0]))
                            ? Container(
                                width: double.infinity,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: CustomColors.GREY_LIGHT_B_COLOR)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      hint: Text('deliver_time'.tr()),
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      items: [
                                        ...contractProducts
                                            .activeTimingResponse.data!
                                            .where(
                                                (element) => element.active == 1)
                                            .map((e) =>
                                            DropdownMenuItem(
                                                  child: Text(e.name!),
                                                  value: e,
                                                )
                                        )
                                      ],
                                      value: activeTimeModel,
                                      onChanged: (dynamic v) {
                                        activeTimeModel = v;
                                        setState(() {});
                                      }),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: CustomColors.GREY_LIGHT_B_COLOR)),
                                child: DropdownButton(
                                    hint:
                                        Text('deliver_time'.tr()),
                                    isExpanded: true,
                                    items: [
                                      ...contractProducts.activeTimingResponse.data!
                                          .map((e) => DropdownMenuItem(
                                                child: Text(e.name!),
                                                value: e,

                                              ))
                                    ],
                                    value: activeTimeModel,
                                    onChanged: (dynamic v) {
                                      activeTimeModel = v;
                                      setState(() {});
                                    }),
                              )
                      ],
                    ),

              SizedBox(
                height: 20,
              ),
              CustomRoundedButton(
                width: MediaQuery.of(context).size.width * 0.8,
                backgroundColor: CustomColors.PRIMARY_GREEN,
                fontSize: 12,
                height: 50,
                borderColor: Colors.transparent,
                text: 'confirm',
                textColor: CustomColors.WHITE_COLOR,
                pressed: (selectedDateTime == null || activeTimeModel == null)
                    ? null
                    : () {
                        Navigator.pop(context, {
                          "date": selectedDateTime.toString().split(" ")[0],
                          "time_id": activeTimeModel!.id,
                          "time_name": activeTimeModel!.name,
                        });
                      },
              ),
            ],
          ),
        ),
      ),)

    );
  }
}
