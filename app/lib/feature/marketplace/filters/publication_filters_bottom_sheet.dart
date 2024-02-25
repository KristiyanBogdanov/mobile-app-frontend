import 'package:app/feature/marketplace/filters/publication_filters_view_model.dart';
import 'package:app/feature/marketplace/filters/views/select_category_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class PublicationFiltersBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  final PublicationFiltersViewModel _viewModel;

  PublicationFiltersBottomSheet({
    required this.request,
    required this.completer,
    super.key,
  }) : _viewModel = request.data as PublicationFiltersViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Container(
        width: double.infinity,
        height: AppStyle.addDeviceBottomSheetHeight,
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding16,
          vertical: AppStyle.verticalPadding16,
        ),
        decoration: BoxDecoration(
          color: AppStyle.secondaryColor1,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppStyle.borderRadius18),
          ),
        ),
        child: Consumer<PublicationFiltersViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SelectCategoryView(
                      title: AppStrings.productCategories,
                      categories: _viewModel.productCategories,
                      isCategorySelected: _viewModel.isProductCategorySelected,
                      onCategorySelected: _viewModel.updateProductCategory,
                    ),
                    SizedBox(height: AppStyle.verticalPadding16),
                    SelectCategoryView(
                      title: AppStrings.serviceCategories,
                      categories: _viewModel.serviceCategories,
                      isCategorySelected: _viewModel.isServiceCategorySelected,
                      onCategorySelected: _viewModel.updateServiceCategory,
                    ),
                  ],
                ),
                PrimaryButton(
                  text: AppStrings.applyFiltersButton,
                  onPressed: () {
                    completer(SheetResponse(confirmed: true, data: _viewModel.filters));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
