import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  int tabNumber = 0;

  void setIndex(int number) {
    tabNumber = number;
    notifyListeners();
  }
}
