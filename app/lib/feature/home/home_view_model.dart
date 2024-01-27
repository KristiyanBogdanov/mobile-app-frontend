import 'package:app/api/user/index.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:app/util/http/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = true;
  int currentPageIndex;
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _userRepotitory = DependencyInjection.getIt<UserRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();

  HomeViewModel({required this.currentPageIndex}) {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userModel = await _userRepotitory.fetchData();
      _globalState.setUser(userModel);
      _isLoading = false;
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorizedApiException();
    } on UnknownApiException {
      await _dialogService.showUnknownErrorDialog();
    }
  }

  void changePage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  
}

// TODO: wait location page to fetch user data and redirect meanwhile