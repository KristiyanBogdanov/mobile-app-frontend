import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class DropdownButtonView extends StatelessWidget {
  final int? currentValue;
  final void Function(int?) onChanged;
  final List<DropdownMenuItem<int>> items;
  final AlignmentDirectional? alignment;

  const DropdownButtonView({
    required this.currentValue,
    required this.onChanged,
    required this.items,
    this.alignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: currentValue,
      onChanged: onChanged,
      dropdownColor: AppStyle.secondaryColor2,
      underline: Container(),
      alignment: alignment ?? AlignmentDirectional.centerStart,
      style: TextStyle(
        color: AppStyle.textColor,
        fontFamily: 'Nunito',
        fontSize: AppStyle.fontSize16,
        fontWeight: FontWeight.w500,
      ),
      borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
      items: items,
    );
  }
}
