import 'package:app/api/location/model/location_model.dart';
import 'package:app/feature/home/home_page.dart'; // TODO: fix here
import 'package:app/feature/auth/index.dart';
import 'package:app/feature/location/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    if (settings.name == RouteEnum.welcome.name) {
      return MaterialPageRoute(builder: (_) => WelcomePage());
    } else if (settings.name == RouteEnum.signin.name) {
      return MaterialPageRoute(builder: (_) => SignInPage());
    } else if (settings.name == RouteEnum.signup.name) {
      return MaterialPageRoute(builder: (_) => SignUpPage());
    } else if (settings.name == RouteEnum.home.name) {
      return MaterialPageRoute(builder: (_) => const HomePage());
    } else if (settings.name == RouteEnum.locationInsights.name) {
      return MaterialPageRoute(builder: (_) => LocationInsightsPage(locationModel: args as LocationModel));
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
