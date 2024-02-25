import 'package:app/api/marketplace/enum/index.dart';
import 'package:app/api/marketplace/model/index.dart';
import 'package:app/feature/marketplace/home/marketplace_view_model.dart';
import 'package:app/feature/marketplace/home/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final _viewModel = MarketplaceViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: AppStyle.verticalPadding16,
                    bottom: AppStyle.verticalPadding8,
                  ),
                  child: SizedBox(
                    height: AppStyle.customAppBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.marketplacePageTitle,
                          style: TextStyle(
                            color: AppStyle.textColor,
                            fontSize: AppStyle.fontSize28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _viewModel.navigateToFilters(),
                              icon: const Icon(
                                Icons.tune_rounded,
                                color: AppStyle.iconColor,
                              ),
                            ),
                            AddNewButtonView(
                              text: AppStrings.addNewLocationButton,
                              icon: Icons.add,
                              onPressed: () => _viewModel.navigateToAddPublication(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<MarketplaceViewModel>(
                  builder: (context, viewModel, child) {
                    return Expanded(
                      child: RefreshIndicator(
                        color: AppStyle.contrastColor1,
                        onRefresh: () async => viewModel.pagingController.refresh(),
                        child: PagedGridView<int, ItemModel>(
                          pagingController: viewModel.pagingController,
                          padding: EdgeInsets.symmetric(
                            vertical: AppStyle.verticalPadding12,
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: AppStyle.marketplaceGridCrossAxisCount,
                            crossAxisSpacing: AppStyle.marketplaceGridCrossAxisSpacing,
                            mainAxisSpacing: AppStyle.marketplaceGridMainAxisSpacing,
                            childAspectRatio: AppStyle.marketplaceGridChildAspectRatio,
                          ),
                          builderDelegate: PagedChildBuilderDelegate<ItemModel>(
                            itemBuilder: (context, publication, index) {
                              if (publication.type == PublicationType.product) {
                                return PublicationCardView(
                                  publication: publication.data as ProductModel,
                                  onTap: () => viewModel.navigateToProductDetails(publication.data as ProductModel),
                                );
                              } else {
                                return PublicationCardView(
                                  publication: publication.data as ServiceModel,
                                  onTap: () => viewModel.navigateToServiceDetails(publication.data as ServiceModel),
                                );
                              }
                            },
                            newPageProgressIndicatorBuilder: (_) => const LoadingView(),
                            firstPageProgressIndicatorBuilder: (_) => const LoadingView(),
                            firstPageErrorIndicatorBuilder: (context) {
                              return const NoContentView(
                                svgAsset: AppImages.serverDown,
                                title: AppStrings.errorFetchingPublicationsTitle,
                                description: AppStrings.errorFetchingPublicationsDescription,
                              );
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return const NoContentView(
                                svgAsset: AppImages.noPublications,
                                title: AppStrings.noPublicationsTitle,
                                description: AppStrings.noPublicationsDescription,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
