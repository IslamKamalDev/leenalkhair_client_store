import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/contract_info_response.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class ContractRadioList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContractRadioListState();
  }
}

class ContractRadioListState extends State<ContractRadioList> {
  var contract_number;
  List<ContractModel> contract_list = [];
  @override
  void initState() {
    var contractInfoProvider =
        Provider.of<ContractInfoProvider>(context, listen: false);
    contractInfoProvider.contractInfoResponse!.data!.forEach((element) {
      contract_list.add(element);
    });
    contract_number = Shared.contract_id;
    Shared.contract_id = contract_list[0].id.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dashboardPagesProvider =
        Provider.of<DashboardPageProvider>(context, listen: false);

    return Container(
        height: MediaQuery.of(context).size.width * 0.7,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: CustomColors.WHITE_COLOR,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: CustomColors.WHITE_COLOR,
                    child: Text(
                      translator
                          .translate(kselect_contract),
                      style: TextStyle(
                          color: CustomColors.BLACK_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Scrollbar(
                    thickness: 5,
                    isAlwaysShown: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: contract_list.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String?>(
                          groupValue: contract_number,
                          title: Text(
                            translator
                                    .translate(kcontract_number)! +
                                '  ' +
                                contract_list[index].id!,
                          ),
                          value: contract_list[index].id,
                          onChanged: (val) {
                            contract_number = val;
                            Shared.contract_id = contract_number;
                            setState(() {});
                          },
                        );
                      },
                    ))),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CustomRoundedButton(
                            backgroundColor: CustomColors.PRIMARY_GREEN,
                            borderColor: CustomColors.PRIMARY_GREEN,
                            text: "accept",
                            textColor: CustomColors.WHITE_COLOR,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 12,
                            pressed: () async {
                              dashboardPagesProvider.getDashboardStatistics(
                                  contract_id: Shared.contract_id,
                                  branch_id: Shared.branch_id_list);
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: CustomRoundedButton(
                            text: "cancel",
                            textColor: CustomColors.WHITE_COLOR,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 12,
                            backgroundColor: CustomColors.RED_COLOR,
                            borderColor: CustomColors.RED_COLOR,
                            pressed: () async {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
