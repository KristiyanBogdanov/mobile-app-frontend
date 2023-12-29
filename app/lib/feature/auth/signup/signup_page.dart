import 'package:app/feature/auth/signup/signup_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:app/util/route/index.dart';
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
            const _SignUpForm(),
            PrimaryButton(
              text: AppStrings.signInButton,
              onPressed: () => signUp(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    await _viewModel.signUp(ScaffoldMessenger.of(context).showSnackBar)
      .then((isSuccessful) => {
        if (isSuccessful) {
          Navigator.pushNamedAndRemoveUntil(context, RouteEnum.home.name, (route) => false)
        }
      });
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) => viewModel.setUsername(value),
                validator: (value) => viewModel.validateUsername(value),
                decoration: InputDecoration(
                  labelText: AppStrings.usernameLabel,
                  hintText: AppStrings.usernameHint,
                  errorText: viewModel.usernameError,
                ),
              ),
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.passwordLabel,
                  hintText: AppStrings.passwordHint,
                  errorText: viewModel.passwordError,
                ),
              ),
              TextFormField(
                validator: (value) => viewModel.validateConfirmPassword(value),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: AppStrings.confirmPasswordLabel,
                  hintText: AppStrings.confirmPasswordHint,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
