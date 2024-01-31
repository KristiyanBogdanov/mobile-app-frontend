import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textColor;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.bgColor = AppStyle.contrastColor1,
    this.textColor = AppStyle.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(AppStyle.primaryButtonHeight),
        backgroundColor: bgColor,
        foregroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: AppStyle.fontSize16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
