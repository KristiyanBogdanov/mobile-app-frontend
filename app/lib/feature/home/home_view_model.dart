import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentPageIndex = 0;
  final _globalState = DependencyInjection.getIt<GlobalState>();

  int get currentPageIndex => _currentPageIndex;

  void changePage(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}

// TODO: wait location page to fetch user data and redirect meanwhile