import 'package:flutter/material.dart';

class ScreenTitleProvider extends ChangeNotifier {
  String? title = 'الرئيسية';
  int currentIndex = 0;

  void setTitleFromIndex(int index) {
    currentIndex = index;
    title = mapIndexTitle(index);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setTitle(String? t) {
    title = t;
    notifyListeners();
  }

  String mapIndexTitle(int i) {
    switch (i) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'طلباتي';
      case 2:
        return 'الملف الشخصي';

      default:
        return 'المزيد';
    }
  }
}
