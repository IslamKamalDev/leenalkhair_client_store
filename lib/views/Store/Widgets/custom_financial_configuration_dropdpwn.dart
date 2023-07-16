
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class CustomFinancialConfigurationDropDown extends StatefulWidget {
  String? hint;
  bool? select_city_status;
  bool? cities_depend_region_status;
  String? city_name;
  CustomFinancialConfigurationDropDown({this.hint,this.select_city_status = false,this.city_name});
  @override
  _CustomFinancialConfigurationDropDownState createState() => _CustomFinancialConfigurationDropDownState();
}

class _CustomFinancialConfigurationDropDownState extends State<CustomFinancialConfigurationDropDown> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return   Container(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: DropdownSearch<UserModel>(
              mode: Mode.MENU,

              onFind: (String? filter) async {

              var response = await Dio().get(
                  "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
                  queryParameters: {"filter": filter},
                );
                var models = UserModel.fromJsonList(response?.data);
                return models;
              },

              itemAsString: (UserModel? u) => u!.userAsString(),

              compareFn: (i, s) => i!.isEqual(s!),
              onChanged: (user){
                Shared.financial_configuraion = user!.name!.substring(3,9);
              },

              enabled: true,

                dropdownSearchDecoration: InputDecoration(
                 hintText: widget.hint!,
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GREY_COLOR),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GREY_COLOR),
                    borderRadius: BorderRadius.circular(5),
                  ),

                ),
              showSearchBox: true,

            ),
          ),
        );
  }


}


class UserModel {
  final String? id;
  final DateTime? createdAt;
  final String? name;
  final String? avatar;

  UserModel({this.id, this.createdAt, this.name, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null!;
    return UserModel(
      id: json["id"],
      createdAt:
      json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    if (list == null) return null!;
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '${this.id}00';
  }

  ///this method will prevent the override of toString
  bool? userFilterByCreationDate(String filter) {
    return this?.createdAt?.toString()?.contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => name!;
}


