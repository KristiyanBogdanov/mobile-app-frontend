import 'package:app/api/marketplace/dto/index.dart';
import 'package:app/api/marketplace/marketplace_repository.dart';
import 'package:app/api/marketplace/model/index.dart';
import 'package:app/feature/marketplace/filters/publication_filters_view_model.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked_services/stacked_services.dart';

class MarketplaceViewModel extends ChangeNotifier {
  static const _limit = 10;
  final pagingController = PagingController<int, ItemModel>(firstPageKey: 0);
  final filters = PublicationsFiltersDto();
  final _marketplaceRepository = DependencyInjection.getIt<MarketplaceRepository>();
  final _bottomSheetService = DependencyInjection.getIt<BottomSheetService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  MarketplaceViewModel() {
    _fetchLimits();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchLimits() async {
    if (!areLimitsFetched) {
      await _marketplaceRepository.fetchLimits();
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final data = await _marketplaceRepository.getPublications(pageKey, _limit, filters);

      if (data.totalItems < _limit) {
        pagingController.appendLastPage(data.items);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(data.items, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<bool> _checkPublicationLimits() async {
    if (_marketplaceRepository.limits != null) {
      return true;
    }

    try {
      await _fetchLimits();
      return true;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return false;
    } on UnknownApiException catch (e) {
      await showSnackbar(e.message);
      return false;
    }
  }

  Future<void> navigateToFilters() async {
    if (!await _checkPublicationLimits()) {
      return;
    }

    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.publicationFilters,
      isScrollControlled: true,
      data: PublicationFiltersViewModel(filters),
    );

    if (result != null && result.confirmed) {
      final newFilters = result.data as PublicationsFiltersDto;

      if (newFilters != filters) {
        filters.productCategories = [...newFilters.productCategories];
        filters.serviceCategories = [...newFilters.serviceCategories];

        pagingController.refresh();
      }
    }
  }

  void _refreshAfterNavigateBack(bool? result) {
    if (result != null && result == true) {
      pagingController.refresh();
    }
  }

  Future<void> navigateToAddPublication() async {
    if (!await _checkPublicationLimits()) {
      return;
    }

    final result = await _navigationService.navigateTo(RouteEnum.addPublication.name);
    _refreshAfterNavigateBack(result);
  }

  Future<void> navigateToServiceDetails(ServiceModel service) async {
    final result = await _navigationService.navigateTo(RouteEnum.serviceDetails.name, arguments: service);
    _refreshAfterNavigateBack(result);
  }

  Future<void> navigateToProductDetails(ProductModel product) async {
    final result = await _navigationService.navigateTo(RouteEnum.productDetails.name, arguments: product);
    _refreshAfterNavigateBack(result);
  }

  bool get areLimitsFetched => _marketplaceRepository.limits != null;
}
