import 'package:app/api/marketplace/enum/pricing_option.dart';
import 'package:app/api/marketplace/enum/publication_type.dart';
import 'package:app/feature/marketplace/add-publication/add_publication_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPublicationPage extends StatelessWidget {
  const AddPublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPublicationViewModel(),
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        appBar: const AppBarView(
          title: AppStrings.addPublicationPageTitle,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyle.horizontalPadding16,
            vertical: AppStyle.verticalPadding16,
          ),
          child: Consumer<AddPublicationViewModel>(
            builder: (context, viewModel, child) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const ColumnSectionTitleView(
                                    title: AppStrings.publicationTypeSectionTitle,
                                    padding: false,
                                  ),
                                  DropdownButtonView(
                                    currentValue: viewModel.publicationType.index,
                                    onChanged: (index) => index != null ? viewModel.setPublicationType(index) : null,
                                    alignment: AlignmentDirectional.centerEnd,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 0,
                                        child: Text(AppStrings.publicationTypeProduct),
                                      ),
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text(AppStrings.publicationTypeService),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const ColumnSpacingView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationTitleSectionTitle),
                              TextFieldView(
                                onChanged: (value) => viewModel.setTitle(value),
                                errorText: viewModel.titleError,
                              ),
                              const ColumnSpacingView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationDescriptionSectionTitle),
                              TextFieldView(
                                onChanged: (value) => viewModel.setDescription(value),
                                maxLines: 5,
                              ),
                              const ColumnSpacingView(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const ColumnSectionTitleView(
                                    title: AppStrings.publicationCategorySectionTitle,
                                    padding: false,
                                  ),
                                  DropdownButtonView(
                                    currentValue: viewModel.categories.indexOf(viewModel.category),
                                    onChanged: (index) => index != null ? viewModel.setCategory(index) : null,
                                    alignment: AlignmentDirectional.centerEnd,
                                    items: viewModel.categories.map((category) {
                                      return DropdownMenuItem(
                                        value: viewModel.categories.indexOf(category),
                                        child: Text(category),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              const ColumnSpacingView(),
                              if (viewModel.publicationType == PublicationType.product) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ColumnSectionTitleView(
                                      title: AppStrings.publicationProductConditionSectionTitle,
                                      padding: false,
                                    ),
                                    DropdownButtonView(
                                      currentValue: viewModel.productConditions.indexOf(viewModel.condition),
                                      onChanged: (index) => index != null ? viewModel.setProductCondition(index) : null,
                                      items: viewModel.productConditions.map((condition) {
                                        return DropdownMenuItem(
                                          value: viewModel.productConditions.indexOf(condition),
                                          child: Text(condition),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                const ColumnSpacingView(),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const ColumnSectionTitleView(
                                    title: AppStrings.publicationPriceSectionTitle,
                                    padding: false,
                                  ),
                                  DropdownButtonView(
                                    currentValue: viewModel.pricingOption.index,
                                    onChanged: (index) => index != null ? viewModel.setPriceOption(index) : null,
                                    alignment: AlignmentDirectional.centerEnd,
                                    items: PricingOption.values.map((option) {
                                      return DropdownMenuItem(
                                        value: PricingOption.values.indexOf(option),
                                        child: Text(option.name),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              if (viewModel.pricingOption == PricingOption.fixed) ...[
                                SizedBox(height: AppStyle.verticalPadding12),
                                TextFieldView(
                                  onChanged: (value) => viewModel.setPrice(value),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                              const ColumnSpacingView(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const ColumnSectionTitleView(
                                    title: AppStrings.publicationImagesSectionTitle,
                                    padding: false,
                                  ),
                                  AddNewButtonView(
                                    text: AppStrings.add,
                                    icon: Icons.add_rounded,
                                    onPressed: () async => await viewModel.addImage(),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppStyle.verticalPadding12),
                              Wrap(
                                spacing: AppStyle.horizontalPadding8,
                                runSpacing: AppStyle.verticalPadding8,
                                children: [
                                  ...viewModel.images.map((image) {
                                    return Stack(
                                      children: [
                                        Image.file(
                                          image,
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () => viewModel.removeImage(image),
                                            icon: Icon(
                                              Icons.close_rounded,
                                              color: AppStyle.iconColor,
                                            ),
                                            style: IconButton.styleFrom(
                                              backgroundColor: AppStyle.bgColor.withOpacity(0.6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(AppStyle.borderRadius24),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                              const ColumnSpacingView(),
                            ],
                          ),
                          PrimaryButton(
                            text: AppStrings.addPublicationButton,
                            isDisabled: !viewModel.isAddButtonEnabled,
                            onPressed: () async => await viewModel.addPublication(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
