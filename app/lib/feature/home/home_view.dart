import 'package:app/feature/home/index.dart';
import 'package:app/feature/home/views/index.dart';
import 'package:app/feature/location/home/locations_page.dart';
import 'package:app/feature/notification/notifications_page.dart';
import 'package:app/feature/profile/profile_page.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppStyle.bgColor,
            body: _buildBodyForIndex(viewModel.currentPageIndex),
            bottomNavigationBar: BottomNavigationBarView(viewModel: viewModel),
          );
        },
      ),
    );
  }

  Widget? _buildBodyForIndex(int index) {
    if (index == PageEnum.locations.value) {
      return const LocationsPage();
    } else if (index == PageEnum.notifications.value) {
      return const NotificationsPage();
    } else if (index == PageEnum.marketplace.value) {
      return const Scaffold(
        body: Center(
          child: Text(AppStrings.marketplacePageTitle),
        ),
      );
    } else if (index == PageEnum.profile.value) {
      return ProfilePage();
    }

    return null;
  }
}
