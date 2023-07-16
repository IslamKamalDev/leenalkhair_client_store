import 'dart:convert';

import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';

class BranchListRadio extends StatefulWidget {
   List<Branches>? branches;
   BranchListRadio({ this.branches});

  @override
  State<BranchListRadio> createState() => _BranchListRadioState();
}

class _BranchListRadioState extends State<BranchListRadio> {
  List<Map<dynamic, dynamic>> sampleList = [];

  @override
  void initState() {
    super.initState();
    widget.branches!.forEach((element) {
      sampleList.add(SampleData(
              name: element.name,
              id: element.id).toJson()
      );
    });
    // sort branches list to gell all branches in top of list
    sampleList.sort((a, b) =>
        a.toString().compareTo(b.toString()));

  }

  @override
  Widget build(BuildContext context) {


    return      RadioGroup(
        radioListObject: sampleList,
        selectedItem: Shared.radio_button_index??0,
        textParameterName: 'name',
        onChanged: (value) {
          Map<String, dynamic> data =  Map<String, dynamic>.from(value);
          Shared.contract_orders_selected_branch_id = data['id'].toString();
          Shared.radio_button_index =   sampleList.indexOf(value);
        },
        disabled: false
    );
  }
}

class SampleData {
  var id;
  var name;

  SampleData({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
  bool operator ==(dynamic other) =>
      other != null && other is SampleData && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
}