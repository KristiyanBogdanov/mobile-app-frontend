import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class TextFormFieldView extends StatefulWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;
  final String hintText;
  final String? errorText;

  const TextFormFieldView({
    this.onChanged,
    required this.validator,
    this.controller,
    this.isPassword = false,
    required this.hintText,
    this.errorText,
    super.key,
  });

  @override
  State<TextFormFieldView> createState() => _TextFormFieldViewState();
}

class _TextFormFieldViewState extends State<TextFormFieldView> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: obscureText,
      style: const TextStyle(
        color: AppStyle.textColor,
      ),
      cursorColor: AppStyle.contrastColor1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding12,
          vertical: AppStyle.verticalPadding16,
        ),
        hintText: widget.hintText,
        errorText: widget.errorText,
        hintStyle: TextStyle(
          color: AppStyle.textColorWith05Opacity,
        ),
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
          borderSide: const BorderSide(
            color: AppStyle.contrastColor1,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: toggleObscureText,
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppStyle.iconColor.withOpacity(0.7),
                ),
              )
            : null,
      ),
    );
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
