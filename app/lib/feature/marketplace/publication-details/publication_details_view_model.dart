import 'package:app/api/marketplace/marketplace_repository.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class PublicationDetailsViewModel extends ChangeNotifier {
  bool isLoading = false;
  final _marketplaceRepository = DependencyInjection.getIt<MarketplaceRepository>();
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  Future<void> navigateToFullScreenImagePage(ImageProvider imageProvider) async {
    await _navigationService.navigateTo(
      RouteEnum.fullScreenImage.name,
      arguments: imageProvider,
    );
  }

  Future<void> deletePublication(String publicationId) async {
    final response = await _dialogService.showBaseConfirmationDialog(
      title: AppStrings.deletePublicationConfirmationTitle,
      description: AppStrings.deletePublicationConfirmationDescription,
      confirmationTitle: AppStrings.deletePublicationConfirmationButton,
    );

    if (response == null || !response.confirmed) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _marketplaceRepository.deletePublication(publicationId);
      _navigationService.back(result: true);
      return;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    isLoading = false;
    notifyListeners();
  }
}
