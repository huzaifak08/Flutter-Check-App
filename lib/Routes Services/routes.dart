import 'package:flutter/material.dart';
import 'package:test_app/Routes%20Screens/first_screen.dart';
import 'package:test_app/Routes%20Screens/second_screen.dart';
import 'package:test_app/Routes%20Screens/third_screen.dart';
import 'package:test_app/Routes%20Services/route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.firstScreen:
        return MaterialPageRoute(
          builder: (context) => FirstScreen(),
        );
      case RouteName.secondScreen:
        return MaterialPageRoute(
          builder: (context) => SecondScreen(data: settings.arguments as Map),
        );
      case RouteName.thirdScreen:
        return MaterialPageRoute(
          builder: (context) => ThirdScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No Route Defined')),
          ),
        );
    }
  }
}
