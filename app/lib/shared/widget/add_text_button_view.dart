import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class AddTextButtonView extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const AddTextButtonView({
    required this.icon,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppStyle.contrastColor1.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius24),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppStyle.horizontalPadding16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppStyle.contrastColor1,
          ),
          SizedBox(width: AppStyle.horizontalPadding4),
          Text(
            text,
            style: TextStyle(
              fontSize: AppStyle.fontSize14,
              fontWeight: FontWeight.w500,
              color: AppStyle.contrastColor1,
            ),
          ),
        ],
      ),
    );
  }
}
