import 'package:app/feature/auth/signup/signup_view_model.dart';
import 'package:app/feature/auth/views/index.dart';
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
        appBar: AppBar(
          title: const Text(AppStrings.signUpPageTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SignUpFormView(),
            PrimaryButton(
              text: AppStrings.signInButton,
              onPressed: () async => await _viewModel.signUp(),
            ),
          ],
        ),
      ),
    );
  }
}