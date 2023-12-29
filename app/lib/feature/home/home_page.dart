import 'package:app/feature/home/home_view_model.dart';
import 'package:app/feature/location/locations_page.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _viewModel = HomeViewModel();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _buildAppBarForIndex(viewModel.currentPageIndex),
            body: _buildBodyForIndex(viewModel.currentPageIndex),
            bottomNavigationBar: _BottomNavigationBar(viewModel: viewModel),
          );
        },
      ),
    );
  }

  PreferredSizeWidget? _buildAppBarForIndex(int index) {
    switch (index) {
      case 0:
        return const AppBarWidget(title: AppStrings.locationsPageTitle);
      case 1:
        return const AppBarWidget(title: AppStrings.assistantPageTitle);
      case 2:
        return const AppBarWidget(title: AppStrings.marketplacePageTitle);
    }

    return null;
  }

  Widget? _buildBodyForIndex(int index) {
    switch (index) {
      case 0:
        return const LocationsPage();
      case 1:
        return const Center(child: Text(AppStrings.assistantPageTitle));
      case 2:
        return const Center(child: Text(AppStrings.marketplacePageTitle));
    }

    return null;
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final HomeViewModel viewModel;

  const _BottomNavigationBar({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: viewModel.currentPageIndex,
      onTap: (index) => viewModel.changePage(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.solar_power_rounded),
          label: AppStrings.locationsPageNavBarLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assistant_rounded),
          label: AppStrings.assistantPageNavBarLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_rounded),
          label: AppStrings.marketplacePageNavBarLabel,
        ),
      ],
    );
  }
}
