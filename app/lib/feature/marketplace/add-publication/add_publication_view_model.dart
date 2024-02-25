import 'dart:io';

import 'package:app/api/marketplace/dto/index.dart';
import 'package:app/api/marketplace/enum/pricing_option.dart';
import 'package:app/api/marketplace/enum/publication_type.dart';
import 'package:app/api/marketplace/index.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

class AddPublicationViewModel extends ChangeNotifier {
  final isButtonEnabled = false;
  bool _isLoading = false;
  PublicationType publicationType = PublicationType.product;
  String _title = '';
  String _description = '';
  late String category;
  PricingOption pricingOption = PricingOption.fixed;
  double? _price;
  late String condition;
  final List<File> images = [];
  String? titleError;
  final imagePicker = ImagePicker();
  final _marketplaceRepository = DependencyInjection.getIt<MarketplaceRepository>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  AddPublicationViewModel() {
    category = _marketplaceRepository.limits!.productCategories.first;
    condition = _marketplaceRepository.limits!.productConditionOptions.first;
  }

  Future<void> addPublication() async {
    _clearErrors();

    titleError = validateTitle();

    if (titleError != null) {
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      publicationType == PublicationType.product
          ? await _marketplaceRepository.postProduct(
              PostProductDto(
                _title,
                _description,
                pricingOption,
                _price,
                condition,
                category,
              ),
              images,
            )
          : await _marketplaceRepository.postService(
              PostServiceDto(
                _title,
                _description,
                pricingOption,
                _price,
                category,
              ),
              images,
            );

      _navigationService.back(result: true);
      return;
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on BadRequestApiException catch (e) {
      showSnackbar(e.message);
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    _isLoading = false;
    notifyListeners();
  }

  String? validateTitle() {
    if (_title.length < _marketplaceRepository.limits!.tileMinLength ||
        _title.length > _marketplaceRepository.limits!.titleMaxLength) {
      return AppStrings.invalidPublicationTitleLength(
        _marketplaceRepository.limits!.tileMinLength,
        _marketplaceRepository.limits!.titleMaxLength,
      );
    }

    return null;
  }

  void _clearErrors() {
    titleError = null;
  }

  void setPublicationType(int index) {
    final newType = PublicationType.values[index];

    if (publicationType != newType) {
      publicationType = newType;
      category = publicationType == PublicationType.product
          ? _marketplaceRepository.limits!.productCategories.first
          : _marketplaceRepository.limits!.serviceCategories.first;

      notifyListeners();
    }
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setCategory(int index) {
    category = publicationType == PublicationType.product
        ? _marketplaceRepository.limits!.productCategories[index]
        : _marketplaceRepository.limits!.serviceCategories[index];

    notifyListeners();
  }

  void setProductCondition(int index) {
    condition = _marketplaceRepository.limits!.productConditionOptions[index];
    notifyListeners();
  }

  void setPriceOption(int index) {
    pricingOption = PricingOption.values[index];
    notifyListeners();
  }

  void setPrice(String price) {
    _price = double.tryParse(price);
    notifyListeners();
  }

  Future<void> addImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      images.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  void removeImage(File image) {
    images.remove(image);
    notifyListeners();
  }

  bool get isAddButtonEnabled =>
      _title.isNotEmpty &&
      _description.isNotEmpty &&
      images.isNotEmpty &&
      !_isLoading &&
      (pricingOption == PricingOption.fixed ? _price != null : true);

  List<String> get categories => publicationType == PublicationType.product
      ? _marketplaceRepository.limits!.productCategories
      : _marketplaceRepository.limits!.serviceCategories;

  List<String> get productConditions => _marketplaceRepository.limits!.productConditionOptions;
}
