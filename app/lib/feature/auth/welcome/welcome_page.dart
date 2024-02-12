import 'package:app/feature/auth/welcome/welcome_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  final _viewModel = WelcomeViewModel();

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyle.horizontalPadding16,
            vertical: AppStyle.verticalPadding16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(height: AppStyle.verticalPadding40),
                  Text(
                    AppStrings.appName,
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
                      AppStrings.appSlogan,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppStyle.fontSize16,
                        color: AppStyle.textColorWith07Opacity,
                      ),
                    ),
                  ),
                  SizedBox(height: AppStyle.verticalPadding32),
                  Image.asset(
                    AppImages.welcomePage,
                    width: AppStyle.welcomePageImageSize,
                    height: AppStyle.welcomePageImageSize,
                  ),
                ],
              ),
              Column(
                children: [
                  PrimaryButton(
                    text: AppStrings.signInButton,
                    onPressed: () async => await _viewModel.navigateToSignIn(),
                  ),
                  SizedBox(height: AppStyle.verticalPadding8),
                  PrimaryButton(
                    text: AppStrings.signUpButton,
                    onPressed: () async => await _viewModel.navigateToSignUp(),
                    bgColor: AppStyle.textColor,
                    textColor: Colors.black,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
