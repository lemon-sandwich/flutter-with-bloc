import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/presentation/router/app_router.dart';
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
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _appRouter.OnGenerateRoute,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _appRouter.dispose(); // Always dispose the instance after its use.
    super.dispose();
  }
}
