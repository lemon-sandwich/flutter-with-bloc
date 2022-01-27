import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/cubit/internet_cubit.dart';
import 'package:flutter_with_bloc/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'cubit/counter_cubit.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity()));
}
// CounterCubit depends on InternetCubit which depends upon connectivity_plus. So it's an architectural tip to initiate the
// connectivity_plus when the app launches.
class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // MultiBlocProvider used for organizing code.
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        )

      ],// Providing Globally
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.OnGenerateRoute, // Most Professional Routing Method
      ),
    );
  }
}
