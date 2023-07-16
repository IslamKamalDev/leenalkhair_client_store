import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class CheckBoxInListView extends StatefulWidget {
  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  late List<bool?> _isChecked;

  List<SelectedBranch> branch_list = [];
  List<String> branch_id_list = [];
  var businessBranchesProvider;
  @override
  void initState() {
    businessBranchesProvider =
        Provider.of<BusinessBranchesProvider>(context, listen: false);

    Shared.chossed_branches.isEmpty
        ? Provider.of<AllEmployeesProvider>(context, listen: false)
            .businessBranchesResponse!
            .branches!
            .forEach((element) {
            branch_list.add(SelectedBranch(branches: element, selected: false));
          })
        : branch_list = Shared.chossed_branches;
// sort branches list to gell all branches in top of list
    branch_list.sort((a, b) =>
        a.branches!.id.toString().compareTo(b.branches!.id.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dashboard_pages_provider =
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
                      kselect_branch.tr(),
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
                      itemCount: branch_list.length,
                      itemBuilder: (context, index) {
                        Shared.chossed_branches = branch_list;
                        return CheckboxListTile(
                          title: Text(branch_list[index].branches!.name),
                          value: branch_list[index].selected,
                          checkColor: Colors.white,
                          activeColor: CustomColors.PRIMARY_GREEN,
                          onChanged: (val) {
                            setState(
                              () {
                                branch_list[index].selected = val!;
                                Shared.chossed_branches[index] = SelectedBranch(
                                    branches: branch_list[index].branches,
                                    selected: branch_list[index].selected);
                              },
                            );
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
                              Shared.chossed_branches.forEach((element) {
                                if (element.selected!)
                                  Shared.branch_id_list
                                      .add(element.branches!.id.toString());
                              });
                              Shared.chossed_branches.forEach((element) {
                              });

                              if (Shared.branch_id_list[0] == "0") {
                                Shared.branch_id_list = [];
                                Provider.of<AllEmployeesProvider>(context,
                                        listen: false)
                                    .businessBranchesResponse!
                                    .branches!
                                    .forEach((element) {
                                  if (element.id.toString() != "0") {
                                    Shared.branch_id_list
                                        .add(element.id.toString());
                                  }
                                });
                              }

                              dashboard_pages_provider.getDashboardStatistics(
                                  contract_id: Shared.contract_id,
                                  branch_id: Shared.branch_id_list);
                              Shared.branch_id_list = [];
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
                              Shared.branch_id_list = [];
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

class SelectedBranch {
  Branches? branches;
  bool? selected;
  SelectedBranch({this.branches, this.selected});
}
