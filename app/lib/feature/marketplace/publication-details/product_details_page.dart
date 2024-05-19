import 'package:app/api/marketplace/model/product_model.dart';
import 'package:app/feature/marketplace/index.dart';
import 'package:app/feature/marketplace/publication-details/publication_details_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;
  final _viewModel = PublicationDetailsViewModel();

  ProductDetailsPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<PublicationDetailsViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.isLoading
              ? const LoadingView()
              : Scaffold(
                  backgroundColor: AppStyle.bgColor,
                  appBar: AppBarView(
                    title: AppStrings.productDetailsPageTitle,
                    actions: [
                      if (product.amIPublisher)
                        PopupMenuButton(
                          onSelected: (value) async {
                            if (value == 0) {
                              await _viewModel.deletePublication(product.id);
                            }
                          },
                          color: AppStyle.secondaryColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItemView(
                              value: 0,
                              text: AppStrings.delete,
                            ),
                          ],
                        )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarouselSliderView(
                          images: product.images,
                          onImageTap: _viewModel.navigateToFullScreenImagePage,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppStyle.horizontalPadding16,
                            vertical: AppStyle.verticalPadding12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.createdAt.parseWithDateFormat('dd MMMM yyyy'),
                                style: TextStyle(
                                  color: AppStyle.textColorWith07Opacity,
                                  fontSize: AppStyle.fontSize12,
                                ),
                              ),
                              Text(
                                product.title,
                                style: TextStyle(
                                  color: AppStyle.textColor,
                                  fontSize: AppStyle.fontSize18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: AppStyle.verticalPadding12),
                                child: Row(
                                  children: [
                                    Text(
                                      product.price != null ? '\$${product.price}' : AppStrings.nagotiablePrice,
                                      style: TextStyle(
                                        color: AppStyle.textColor,
                                        fontSize: AppStyle.fontSize18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: AppStyle.horizontalPadding8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppStyle.horizontalPadding8,
                                        vertical: AppStyle.verticalPadding4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppStyle.contrastColor1,
                                        borderRadius: BorderRadius.circular(AppStyle.borderRadius8),
                                      ),
                                      child: Text(
                                        AppStrings.productCondition(product.condition.name),
                                        style: TextStyle(
                                          color: AppStyle.textColor,
                                          fontSize: AppStyle.fontSize12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const HorizontalDividerView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationDescriptionSectionTitle),
                              DescriptionView(description: product.description),
                              const HorizontalDividerView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationUserDetailsSectionTitle),
                              UserDetailsCardView(
                                username: product.publisher.username,
                                email: product.publisher.email,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
