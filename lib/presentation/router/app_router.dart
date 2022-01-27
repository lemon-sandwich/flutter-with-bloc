import 'package:flutter/material.dart';
import 'package:flutter_with_bloc/cubit/counter_cubit.dart';

import '../screens/home_screen.dart';
import '../screens/second_screen.dart';
import '../screens/third_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? OnGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(
                      title: 'Home Screen', colors: Colors.blueAccent),
                );
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const SecondScreen(
                      title: 'Second Screen', colors: Colors.redAccent),
                );
        break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) => const ThirdScreen(
                      title: 'Third Screen', colors: Colors.greenAccent),
                );
        break;
      default:
        return null;
    }
  }
}
