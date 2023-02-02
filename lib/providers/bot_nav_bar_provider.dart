import 'package:flutter/material.dart';

class BotNavBarProvider with ChangeNotifier {
  int currentIndex = 0;

  void change(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
