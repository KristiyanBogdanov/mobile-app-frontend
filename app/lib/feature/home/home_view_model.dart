import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int currentPageIndex;

  HomeViewModel({required this.currentPageIndex});

  void changePage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }
}