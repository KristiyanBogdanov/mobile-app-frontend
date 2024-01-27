import 'package:app/feature/home/index.dart';
import 'package:app/feature/home/views/index.dart';
import 'package:app/feature/location/locations_page.dart';
import 'package:app/feature/notification/notifications_page.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final HomeViewModel viewModel;

  const Home({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
    }

    return null;
  }
}
