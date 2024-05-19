import 'package:app/feature/location/location-insights/invite-user/invite_user_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class InviteUserDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  final InviteUserViewModel _viewModel;

  InviteUserDialog({
    required this.request,
    required this.completer,
    super.key,
  }) : _viewModel = request.data as InviteUserViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<InviteUserViewModel>(
        builder: (context, viewModel, child) {
          return Dialog(
            backgroundColor: AppStyle.secondaryColor1,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppStyle.horizontalPadding16,
                vertical: AppStyle.verticalPadding16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.inviteUserDialogTitle,
                    style: TextStyle(
                      fontSize: AppStyle.fontSize20,
                      fontWeight: FontWeight.w500,
                      color: AppStyle.textColor,
                    ),
                  ),
                  SizedBox(height: AppStyle.verticalPadding32),
                  TextFieldView(
                    onChanged: (value) => viewModel.setEmail(value),
                    hintText: AppStrings.emailHint,
                    errorText: viewModel.emailError,
                  ),
                  SizedBox(height: AppStyle.verticalPadding32),
                  PrimaryButton(
                    text: AppStrings.inviteUserButton,
                    isDisabled: viewModel.isButtonDisabled,
                    onPressed: () async {
                      final result = await viewModel.inviteUser();
                      
                      if (result) {
                        await completer(DialogResponse(confirmed: true));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
