import 'package:app/feature/home/index.dart';
import 'package:app/feature/auth/index.dart';
import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/feature/location/index.dart';
import 'package:app/feature/location/location-insights/solar-tracker/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    if (settings.name == RouteEnum.welcome.name) {
      return MaterialPageRoute(builder: (_) => WelcomePage());
    } else if (settings.name == RouteEnum.signin.name) {
      return MaterialPageRoute(builder: (_) => SignInPage());
    } else if (settings.name == RouteEnum.signup.name) {
      return MaterialPageRoute(builder: (_) => SignUpPage());
    } else if (settings.name == RouteEnum.home.name) {
      return MaterialPageRoute(builder: (_) {
        final currentPageIndex = (args as int?) ?? PageEnum.locations.value;
        return HomeView(viewModel: HomeViewModel(currentPageIndex: currentPageIndex));
      });
    } else if (settings.name == RouteEnum.addLocation.name) {
      return MaterialPageRoute(builder: (_) => const AddLocationPage());
    } else if (settings.name == RouteEnum.locationInsights.name) {
      return MaterialPageRoute(builder: (_) => LocationInsightsPage(viewModel: args as LocationInsightsViewModel));
    } else if (settings.name == RouteEnum.solarTracker.name) {
      return MaterialPageRoute(builder: (_) => SolarTrackerPage(viewModel: args as SolarTrackerViewModel));
    } else {
      return _errorRoute();
    }
  }

  // TODO: change that
  Route<MaterialPageRoute> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
