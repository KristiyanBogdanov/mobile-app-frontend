import 'package:app/feature/home/home_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarView extends StatelessWidget {
  final HomeViewModel viewModel;

  const BottomNavigationBarView({required this.viewModel, super.key});

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
