import 'package:app/feature/auth/signin/signin_view_model.dart';
import 'package:app/feature/auth/views/index.dart';
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
        appBar: AppBar(
          title: const Text(AppStrings.signInPageTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SignInFormView(),
            PrimaryButton(
              text: AppStrings.signInButton,
              onPressed: () async => await _viewModel.signIn(),
            ),
          ],
        ),
      ),
    );
  }
}
