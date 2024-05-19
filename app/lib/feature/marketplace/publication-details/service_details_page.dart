import 'package:app/api/marketplace/model/service_model.dart';
import 'package:app/feature/marketplace/index.dart';
import 'package:app/feature/marketplace/publication-details/publication_details_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceDetailsPage extends StatelessWidget {
  final ServiceModel service;
  final _viewModel = PublicationDetailsViewModel();

  ServiceDetailsPage({
    required this.service,
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
                    title: AppStrings.serviceDetailsPageTitle,
                    actions: [
                      if (service.amIPublisher)
                        PopupMenuButton(
                          onSelected: (value) async {
                            if (value == 0) {
                              await _viewModel.deletePublication(service.id);
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
                          images: service.images,
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
                                service.createdAt.parseWithDateFormat('dd MMMM yyyy'),
                                style: TextStyle(
                                  color: AppStyle.textColorWith07Opacity,
                                  fontSize: AppStyle.fontSize12,
                                ),
                              ),
                              Text(
                                service.title,
                                style: TextStyle(
                                  color: AppStyle.textColor,
                                  fontSize: AppStyle.fontSize18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: AppStyle.verticalPadding12),
                                child: Text(
                                  service.price != null ? '\$${service.price}' : AppStrings.nagotiablePrice,
                                  style: TextStyle(
                                    color: AppStyle.textColor,
                                    fontSize: AppStyle.fontSize18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const HorizontalDividerView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationDescriptionSectionTitle),
                              DescriptionView(description: service.description),
                              const HorizontalDividerView(),
                              const ColumnSectionTitleView(title: AppStrings.publicationUserDetailsSectionTitle),
                              UserDetailsCardView(
                                username: service.publisher.username,
                                email: service.publisher.email,
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
