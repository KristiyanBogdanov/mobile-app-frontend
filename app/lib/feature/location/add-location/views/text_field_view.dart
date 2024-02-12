import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  final Function onChanged;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;

  const TextFieldView({
    required this.onChanged,
    this.keyboardType,
    this.hintText,
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
      cursorColor: AppStyle.contrastColor1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding12,
          vertical: AppStyle.verticalPadding16,
        ),
        hintText: hintText ?? AppStrings.inputFieldHint,
        errorText: errorText,
        hintStyle: TextStyle(
          color: AppStyle.textColorWith05Opacity,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
          borderSide: const BorderSide(
            color: AppStyle.contrastColor1,
          ),
        ),
      ),
    );
  }
}

// TODO: change selection text color
