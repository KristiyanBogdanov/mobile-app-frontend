import 'package:app/feature/home/home_view_model.dart';
import 'package:app/feature/home/views/index.dart';
import 'package:app/feature/location/locations_page.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppStyle.bgColor,
            body: viewModel.isLoading ? const LoadingView() : _buildBodyForIndex(viewModel.currentPageIndex),
            bottomNavigationBar: BottomNavigationBarView(viewModel: viewModel),
          );
        },
      ),
    );
  }

  Widget? _buildBodyForIndex(int index) {
    switch (index) {
      case 0:
        return LocationsPage();
      case 1:
        return const Scaffold(
          body: Center(
            child: Text(AppStrings.assistantPageTitle),
          ),
        );
      case 2:
        return const Scaffold(
          body: Center(
            child: Text(AppStrings.marketplacePageTitle),
          ),
        );
    }
    return null;
  }
}
