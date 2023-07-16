import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TabControllerProvider extends ChangeNotifier {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  changeTab(int index) {
    controller.jumpToTab(index);
    notifyListeners();
  }
}
