import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class ColumnSectionTitleView extends StatelessWidget {
  final String title;
  final bool padding;

  const ColumnSectionTitleView({
    super.key,
    required this.title,
    this.padding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding ? AppStyle.verticalPadding12 : 0),
      child: Text(
        title,
        style: TextStyle(
          color: AppStyle.textColor,
          fontSize: AppStyle.fontSize16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
