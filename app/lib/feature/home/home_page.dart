import 'package:app/feature/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _viewModel = HomeViewModel();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: _buildBodyForIndex(viewModel.currentPageIndex),
            bottomNavigationBar: _buildBottomNavigationBar(context),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _viewModel.currentPageIndex,
      onTap: (index) => _viewModel.changePage(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildBodyForIndex(int index) {
    switch (index) {
      // case 0:
      //   return _buildLocationPage();
      // case 1:
      //   return _buildProfilePage();
      default:
        return const Text('ERROR');
    }
  }
}

// TODO: each _build... should be a separate view