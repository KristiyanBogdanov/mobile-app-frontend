import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class AddNewLocationButtonView extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewLocationButtonView({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding16,
          vertical: AppStyle.verticalPadding8,
        ),
        backgroundColor: AppStyle.contrastColor,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.add_rounded,
            color: AppStyle.iconColor,
          ),
          SizedBox(width: AppStyle.horizontalPadding4),
          const Text(
            AppStrings.addNewLocationButton,
            style: TextStyle(color: AppStyle.textColor),
          ),
        ],
      ),
    );
  }
}
