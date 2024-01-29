import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(AppStyle.primaryButtonHeight),
        backgroundColor: AppStyle.contrastColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppStyle.textColor,
          fontSize: AppStyle.fontSize14,
        ),
      ),
    );
  }
}
