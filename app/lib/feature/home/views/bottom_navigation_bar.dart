import 'package:app/feature/home/home_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarView extends StatelessWidget {
  final HomeViewModel viewModel;

  const BottomNavigationBarView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppStyle.bgColor,
        border: Border(
          top: BorderSide(color: AppStyle.secondaryColor2),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyle.horizontalPadding16,
            vertical: AppStyle.verticalPadding8,
          ),
          child: GNav(
            gap: AppStyle.gNavGap,
            activeColor: AppStyle.iconColor,
            iconSize: AppStyle.iconSize24,
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
              vertical: AppStyle.verticalPadding12,
            ),
            tabBackgroundColor: AppStyle.secondaryColor2,
            color: AppStyle.iconColor,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: AppStrings.locationsPageNavBarLabel,
              ),
              GButton(
                icon: Icons.assistant_rounded,
                text: AppStrings.notificationsPageNavBarLabel,
              ),
              GButton(
                icon: Icons.shopping_cart_rounded,
                text: AppStrings.marketplacePageNavBarLabel,
              ),
              GButton(
                icon: Icons.person_rounded,
                text: AppStrings.profilePageNavBarLabel,
              ),
            ],
            selectedIndex: viewModel.currentPageIndex,
            onTabChange: (index) => viewModel.changePage(index),
          ),
        ),
      ),
    );
  }
}
