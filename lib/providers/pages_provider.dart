import 'package:leen_alkhier_store/data/responses/page.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class PagesProvider {
  static Future<List<Page>> getPages() async {
    Map<String, dynamic>? map;
    await NetworkCall.makeCall(endPoint: "api/v3/pages", method: HttpMethod.GET)
        .then((_map) => {map = _map});

    List<Page> pages = <Page>[];
    if (map != null && map!["status"]) {
      for (int i = 0; i < map!["data"].length; i++) {
        dynamic v = map!["data"][i];
        pages.add(Page(
            id: v["id"],
            name: v["name"],
            content: v["content"],
            slug: v["slug"]));
      }
    }
    return pages;
  }
}
