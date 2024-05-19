import 'package:app/feature/auth/signin/signin_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final _viewModel = SignInViewModel();

  SignInPage({super.key});

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
            child: Consumer<SignInViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppStrings.signInPageTitle,
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
                            AppStrings.signInSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppStyle.fontSize16,
                              color: AppStyle.textColorWith07Opacity,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          TextFormFieldView(
                            onChanged: (value) => viewModel.setEmail(value),
                            validator: (value) => viewModel.validateEmail(value),
                            hintText: AppStrings.emailHint,
                            errorText: viewModel.emailError,
                          ),
                          SizedBox(height: AppStyle.verticalPadding16),
                          TextFormFieldView(
                            controller: viewModel.passwordController,
                            onChanged: (value) => viewModel.setPassword(value),
                            validator: (value) => viewModel.validatePassword(value),
                            isPassword: true,
                            hintText: AppStrings.passwordHint,
                            errorText: viewModel.passwordError,
                          ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      isDisabled: !viewModel.isButtonEnabled,
                      text: AppStrings.signInButton,
                      onPressed: () async => await _viewModel.signIn(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
