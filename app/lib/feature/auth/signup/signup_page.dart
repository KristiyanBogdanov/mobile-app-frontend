import 'package:app/feature/auth/signup/signup_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final _viewModel = SignUpViewModel();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
              vertical: AppStyle.verticalPadding16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.signUpPageTitle,
                      style: TextStyle(
                        fontSize: AppStyle.fontSize28,
                        fontWeight: FontWeight.bold,
                        color: AppStyle.textColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppStyle.horizontalPadding16,
                        vertical: AppStyle.verticalPadding8,
                      ),
                      child: Text(
                        AppStrings.signUpSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppStyle.fontSize16,
                          color: AppStyle.textColorWith07Opacity,
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer<SignUpViewModel>(
                  builder: (context, viewModel, child) {
                    return Form(
                      key: viewModel.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormFieldView(
                            onChanged: (value) => viewModel.setUsername(value),
                            validator: (value) => viewModel.validateUsername(value),
                            hintText: AppStrings.usernameHint,
                            errorText: viewModel.usernameError,
                          ),
                          SizedBox(height: AppStyle.verticalPadding16),
                          TextFormFieldView(
                            onChanged: (value) => viewModel.setEmail(value),
                            validator: (value) => viewModel.validateEmail(value),
                            hintText: AppStrings.emailHint,
                            errorText: viewModel.emailError,
                          ),
                          SizedBox(height: AppStyle.verticalPadding16),
                          TextFormFieldView(
                            onChanged: (value) => viewModel.setPassword(value),
                            validator: (value) => viewModel.validatePassword(value),
                            isPassword: true,
                            hintText: AppStrings.passwordHint,
                            errorText: viewModel.passwordError,
                          ),
                          SizedBox(height: AppStyle.verticalPadding16),
                          TextFormFieldView(
                            validator: (value) => viewModel.validateConfirmPassword(value),
                            isPassword: true,
                            hintText: AppStrings.confirmPasswordHint,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                PrimaryButton(
                  text: AppStrings.createAccountButton,
                  onPressed: () async => await _viewModel.signUp(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
