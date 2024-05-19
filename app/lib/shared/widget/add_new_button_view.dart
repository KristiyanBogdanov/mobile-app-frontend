import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class AddNewButtonView extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const AddNewButtonView({
    required this.text,
    required this.icon,
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
        backgroundColor: AppStyle.contrastColor1,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppStyle.iconColor,
          ),
          SizedBox(width: AppStyle.horizontalPadding4),
          Text(
            text,
            style: const TextStyle(color: AppStyle.textColor),
          ),
        ],
      ),
    );
  }
}
