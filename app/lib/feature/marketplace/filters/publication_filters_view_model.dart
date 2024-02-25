import 'package:app/api/marketplace/dto/publications_filters_dto.dart';
import 'package:app/api/marketplace/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class PublicationFiltersViewModel extends ChangeNotifier {
  final filters = PublicationsFiltersDto();
  final _marketplaceRepository = DependencyInjection.getIt<MarketplaceRepository>();

  PublicationFiltersViewModel(PublicationsFiltersDto initialFilters) {
    filters.productCategories = [...initialFilters.productCategories];
    filters.serviceCategories = [...initialFilters.serviceCategories];
  }

  bool isProductCategorySelected(String category) => filters.productCategories.contains(category);
  bool isServiceCategorySelected(String category) => filters.serviceCategories.contains(category);

  void updateProductCategory(String category) {
    if (filters.productCategories.contains(category)) {
      filters.productCategories.remove(category);
    } else {
      filters.productCategories.add(category);
    }

    notifyListeners();
  }

  void updateServiceCategory(String category) {
    if (filters.serviceCategories.contains(category)) {
      filters.serviceCategories.remove(category);
    } else {
      filters.serviceCategories.add(category);
    }

    notifyListeners();
  }

  List<String> get productCategories => _marketplaceRepository.limits?.productCategories ?? [];
  List<String> get serviceCategories => _marketplaceRepository.limits?.serviceCategories ?? [];
}
