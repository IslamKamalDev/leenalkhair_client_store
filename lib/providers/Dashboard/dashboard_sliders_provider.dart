import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_sliders_response.dart';
import 'package:leen_alkhier_store/repos/dashboard_repo.dart';

class DashboardSlidersProvider extends ChangeNotifier{
  DashboardSlidersResponse? dashboardSlidersResponse;


  Future<DashboardSlidersResponse?> getDashboardSliders() async {
    return await DashboardRepository.getDashboardSliders()
        .then((value) {
      dashboardSlidersResponse = value;
      notifyListeners();
      return dashboardSlidersResponse;
    });
  }

}