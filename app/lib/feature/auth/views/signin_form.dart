import 'package:app/feature/auth/signin/signin_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInFormView extends StatelessWidget {
  const SignInFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInViewModel>(
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) => viewModel.setEmail(value),
                validator: (value) => viewModel.validateEmail(value),
                decoration: InputDecoration(
                  labelText: AppStrings.emailLabel,
                  hintText: AppStrings.emailHint,
                  errorText: viewModel.emailError,
                ),
              ),
              TextFormField(
                onChanged: (value) => viewModel.setPassword(value),
                validator: (value) => viewModel.validatePassword(value),
                decoration: InputDecoration(
                  labelText: AppStrings.passwordLabel,
                  hintText: AppStrings.passwordHint,
                  errorText: viewModel.passwordError,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
