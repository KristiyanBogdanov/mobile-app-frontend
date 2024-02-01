import 'package:app/feature/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final _viewModel = ProfileViewModel();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              await _viewModel.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
