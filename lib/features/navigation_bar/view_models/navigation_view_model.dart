import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentPageIndex = 0;

  // Getter
  int get currentPageIndex => _currentPageIndex;

  void onPageChanged(int index) {
    _currentPageIndex = index;

    notifyListeners();
  }
}
