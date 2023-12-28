import 'package:app/feature/auth/signin/signin_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:app/util/route/index.dart';
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
            const _SignInForm(),
            TextButton(
              onPressed: () => creteAccount(context),
              child: const Text(AppStrings.createAccountButton),
            ),
            PrimaryButton(
              text: AppStrings.signInButton,
              onPressed: () => signIn(context),
            ),
          ],
        ),
      ),
    );
  }

  void creteAccount(BuildContext context) {
    Navigator.pushNamed(context, RouteEnum.signup.name);
  }

  Future<void> signIn(BuildContext context) async {
    await _viewModel.signIn(ScaffoldMessenger.of(context).showSnackBar)
      .then((isSuccessful) => {
        if (isSuccessful) {
          Navigator.pushNamedAndRemoveUntil(context, RouteEnum.home.name, (route) => false)
        }
      });
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({Key? key}) : super(key: key);

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
