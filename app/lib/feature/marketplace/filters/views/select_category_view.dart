import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class SelectCategoryView extends StatelessWidget {
  final String title;
  final List<String> categories;
  final Function isCategorySelected;
  final Function onCategorySelected;

  const SelectCategoryView({
    required this.title,
    required this.categories,
    required this.isCategorySelected,
    required this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: AppStyle.verticalPadding8,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppStyle.textColor,
                fontSize: AppStyle.fontSize20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Wrap(
            spacing: AppStyle.horizontalPadding8,
            children: [
              for (final category in categories)
                ChoiceChip(
                  label: Text(category),
                  selectedColor: AppStyle.secondaryColor2,
                  backgroundColor: AppStyle.secondaryColor1,
                  checkmarkColor: AppStyle.contrastColor1,
                  side: BorderSide(
                    color:
                        isCategorySelected(category) ? AppStyle.secondaryColor1 : AppStyle.lineChartMainGridLineColor,
                  ),
                  selected: isCategorySelected(category),
                  onSelected: (isSelected) => onCategorySelected(category),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
