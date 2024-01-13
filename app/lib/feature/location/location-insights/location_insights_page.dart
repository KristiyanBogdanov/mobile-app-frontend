import 'package:app/feature/location/location-insights/location_insights_view_model.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationInsightsPage extends StatelessWidget {
  final LocationInsightsViewModel viewModel;

  const LocationInsightsPage({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBarView(title: viewModel.locationModel.name),
        body: Consumer<LocationInsightsViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(viewModel.locationInsightsModel.toString()),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
