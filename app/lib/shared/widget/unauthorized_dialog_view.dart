import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class UnauthorizedDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const UnauthorizedDialogView({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppStyle.secondaryColor2,
      
      title: Text(
        AppStrings.unauthorizedDialogTitle,
        style: TextStyle(
          color: AppStyle.textColor,
        ),
      ),
      content: Text(
        AppStrings.unauthorizedDialogDescription,
        style: TextStyle(
          color: AppStyle.textColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => completer(DialogResponse(confirmed: true)),
          child: Text(
            AppStrings.unauthorizedDialogButton,
            style: TextStyle(
              color: AppStyle.contrastColor1,
            ),
          ),
        ),
        
      ],
    );
  }
}
