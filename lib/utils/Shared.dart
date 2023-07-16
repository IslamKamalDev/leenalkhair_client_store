import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_sliders_response.dart';
import 'package:leen_alkhier_store/data/responses/page.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/branch_checkbox_list.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Shared {

  static String? supplier_name;
  static String? warehouse_no;
  static String? financial_configuraion;
  static String? invoice_id;
  static String? stock_type;
  static List<Page>? pages;
  static List selected_branches = [];
  static List selected_permissions = [];
  static var from_day;
  static var to_day;
  static var business_info_id;
  static var check_pricing_method;
  static var min_app_version;
  static List<Asset> images_list = [];

  //Dashboard Anyalsis
  static String? contract_id;
  static List<String> branch_id_list = [];
  static List<SelectedBranch> chossed_branches = [];
  static List<FirstSlider> first_slider = [];
  static List<FirstSlider> last_Slider = [];
  static List<FirstSlider> single = [];

  static List<String>? categories_name;
  static String? contract_orders_selected_branch_id = 0.toString();
  static bool user_has_branches = false;
  static int? radio_button_index;
}

class Branch {
  var id;
  Branch({this.id});
  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return null;

    //return data;
  }
}

class Permission {
  var permission_id;
  Permission({this.permission_id});
  Permission.fromJson(Map<String, dynamic> json) {
    permission_id = json['permission_id'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permission_id'] = this.permission_id;
    return null;

    //return data;
  }
}
