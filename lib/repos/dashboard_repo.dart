import 'dart:async';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_analysis_response.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_sliders_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class DashboardRepository {
  static Future<DashboardAnalysisResponse> get_dashboard_statistics(
      {List<String>? branch_id, String? contract_id}) async {
    return DashboardAnalysisResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_dashboard_statistics",
      queryParams: {
        "branch_id": branch_id
                .toString()
                .substring(1, branch_id.toString().length - 1)
                .isEmpty
            ? "0"
            : branch_id
                .toString()
                .substring(1, branch_id.toString().length - 1),
        "contract_id": contract_id
      },
      method: HttpMethod.GET,
    )));
  }

  static Future<DashboardSlidersResponse?> getDashboardSliders() async {
    Map<String, dynamic>? result = await (NetworkCall.makeCall(
      endPoint: "api/v3/get_images",
      method: HttpMethod.GET,
    ));
    return DashboardSlidersResponse.fromJson(result!);
  }
}
