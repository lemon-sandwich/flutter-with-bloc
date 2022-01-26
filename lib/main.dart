import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/presentation/screens/home_screen.dart';
import 'package:flutter_with_bloc/presentation/screens/second_screen.dart';
import 'package:flutter_with_bloc/presentation/screens/third_screen.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget { // Converted the class to StatefulWidget so as to dispose the instance created at the end.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit(); // Made a single instance of the class to be used everywhere

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: { // Using Generated Route Access ( More Professional )
        '/': (context) =>
            BlocProvider.value( // Used BlocProvider.value to pass the existing instance to the screens
              value: _counterCubit,
              child:
              HomeScreen(title: 'Home Screen', colors: Colors.blueAccent),
            ),
        '/second': (context) =>
            BlocProvider.value(
              value: _counterCubit,
              child: SecondScreen(title: 'Second Screen', colors: Colors.red),
            ),
        '/third': (context) =>
            BlocProvider.value(
              value: _counterCubit,
              child: ThirdScreen(
                  title: 'Third Screen', colors: Colors.greenAccent),
            ),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _counterCubit.close(); // Always dispose the instance after its use.
    super.dispose();
  }
}
