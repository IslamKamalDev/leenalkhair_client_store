import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_analysis_response.dart';
import 'package:leen_alkhier_store/repos/dashboard_repo.dart';

class DashboardPageProvider extends ChangeNotifier {
  String page_name = "dashboard";
  DashboardAnalysisResponse? dashboardAnalysisResponse;

  void setIndex(String name) {
    page_name = name;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<DashboardAnalysisResponse?> getDashboardStatistics(
      {List<String>? branch_id, String? contract_id}) async {

    return await DashboardRepository.get_dashboard_statistics(
            branch_id: branch_id, contract_id: contract_id)
        .then((value) {
      dashboardAnalysisResponse = value;
      notifyListeners();
      return dashboardAnalysisResponse;
    });
  }
}
