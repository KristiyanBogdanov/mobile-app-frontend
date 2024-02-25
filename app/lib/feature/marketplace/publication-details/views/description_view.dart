import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionView extends StatelessWidget {
  final String description;

  const DescriptionView({
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      description,
      trimLines: AppStyle.publicationDetailsTrimLines,
      colorClickableText: AppStyle.contrastColor1,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppStrings.readMore,
      trimExpandedText: AppStrings.showLess,
      style: TextStyle(
        color: AppStyle.textColor,
        fontSize: AppStyle.fontSize16,
      ),
    );
  }
}
