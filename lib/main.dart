import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/presentation/screens/home_screen.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(), // Creating an instance of CounterCubit to be used in multiple routes
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(title: 'Flutter Demo Home Page', colors: Colors.blueAccent,),
      ),
    );
  }
}
