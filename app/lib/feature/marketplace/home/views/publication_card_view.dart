import 'package:app/api/marketplace/model/publication_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class PublicationCardView extends StatelessWidget {
  final PublicationModel publication;
  final VoidCallback onTap;

  const PublicationCardView({
    required this.publication,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyle.secondaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppStyle.borderRadius12),
                  topRight: Radius.circular(AppStyle.borderRadius12),
                ),
                child: Image.network(
                  publication.images.first,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppStyle.horizontalPadding8,
                vertical: AppStyle.verticalPadding8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    publication.title,
                    maxLines: AppStyle.publicationCardTitleMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppStyle.verticalPadding8),
                  Text(
                    publication.price != null ? '\$${publication.price}' : AppStrings.nagotiablePrice,
                    style: TextStyle(
                      fontSize: AppStyle.fontSize16,
                      fontWeight: FontWeight.w500,
                      color: AppStyle.textColor,
                    ),
                  ),
                  SizedBox(height: AppStyle.verticalPadding8),
                  Text(
                    publication.createdAt.parseWithDateFormat('dd MMM yyyy'),
                    style: TextStyle(
                      color: AppStyle.textColorWith05Opacity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
