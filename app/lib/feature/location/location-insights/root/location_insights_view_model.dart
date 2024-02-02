import 'package:app/api/location/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationInsightsViewModel extends ChangeNotifier {
  bool _isLoading = true;
  final LocationModel locationModel;
  LocationInsightsModel? _locationInsightsModel;
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  LocationInsightsViewModel(this.locationModel) {
    _fetchLocationInsights();
  }

  Future<void> _fetchLocationInsights() async {
    try {
      _locationInsightsModel = await _locationRepository.getLocationInsights(locationModel.id);
      _isLoading = false;
      notifyListeners();
    } on InvalidTokenApiException {
      handleUnauthorized();
    } on UnknownApiException {
      // await _dialogService.showUnknownErrorDialog();
    }
  }

  bool get isLoading => _isLoading;
  LocationInsightsModel get locationInsightsModel => _locationInsightsModel!;
}
