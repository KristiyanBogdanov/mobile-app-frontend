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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 100),
              const Text('Welcome'),
              Column(
                children: [
                  PrimaryButton(
                    text: AppStrings.signInButton,
                    onPressed: () async => await _viewModel.navigateToSignIn(),
                  ),
                  PrimaryButton(
                    text: AppStrings.signUpButton,
                    onPressed: () async => await _viewModel.navigateToSignUp(),
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
