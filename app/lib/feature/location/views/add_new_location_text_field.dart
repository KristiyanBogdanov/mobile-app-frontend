import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  final Function onChanged;
  final TextInputType? keyboardType;
  final String? errorText;

  const TextFieldView({
    required this.onChanged,
    this.keyboardType,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: (value) => onChanged(value),
      style: const TextStyle(
        color: AppStyle.textColor,
      ),
      cursorColor: AppStyle.contrastColor,
      decoration: InputDecoration(
        hintText: AppStrings.inputFieldHint,
        errorText: errorText,
        hintStyle: TextStyle(
          color: AppStyle.textColor.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
          borderSide: const BorderSide(
            color: AppStyle.contrastColor,
          ),
        ),
      ),
    );
  }
}

// TODO: change selection text color
