import 'package:app/api/marketplace/dto/publications_filters_dto.dart';
import 'package:app/api/marketplace/enum/index.dart';
import 'package:flutter/material.dart';

class PublicationFiltersViewModel extends ChangeNotifier {
  final filters = PublicationsFiltersDto();

  PublicationFiltersViewModel(PublicationsFiltersDto initialFilters) {
    filters.productCategories = [...initialFilters.productCategories];
    filters.serviceCategories = [...initialFilters.serviceCategories];
  }

  bool isProductCategorySelected(String category) =>
      filters.productCategories.contains(ProductCategory.fromString(category));
  bool isServiceCategorySelected(String category) =>
      filters.serviceCategories.contains(ServiceCategory.fromString(category));

  void updateProductCategory(String categoryString) {
    final category = ProductCategory.fromString(categoryString);

    if (filters.productCategories.contains(category)) {
      filters.productCategories.remove(category);
    } else {
      filters.productCategories.add(category);
    }

    notifyListeners();
  }

  void updateServiceCategory(String categoryString) {
    final category = ServiceCategory.fromString(categoryString);

    if (filters.serviceCategories.contains(category)) {
      filters.serviceCategories.remove(category);
    } else {
      filters.serviceCategories.add(category);
    }

    notifyListeners();
  }

  List<String> get serviceCategories => ServiceCategory.values.map((e) => e.name).toList();
  List<String> get productCategories => ProductCategory.values.map((e) => e.name).toList();
}
