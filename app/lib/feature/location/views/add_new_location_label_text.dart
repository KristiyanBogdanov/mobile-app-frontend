import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class LabelTextView extends StatelessWidget {
  final String label;

  const LabelTextView({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppStyle.verticalPadding12),
      child: Text(
        label,
        style: TextStyle(
          color: AppStyle.textColor,
          fontSize: AppStyle.fontSize16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
