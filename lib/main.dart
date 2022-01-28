import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/cubit/internet_cubit.dart';
import 'package:flutter_with_bloc/cubit/utility/app_bloc_observer.dart';
import 'package:flutter_with_bloc/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'cubit/counter_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized(); // We have to initialize it to run the native code

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  ).then((value) => { // to make sure that storage is initialized before the app runs
  HydratedBlocOverrides.runZoned(
  () => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity())),
  storage: value,
    blocObserver: AppBlocObserver() // To observe the states of bloc creation, changes, events, errors, transitions. Check app_bloc_observer to see all the functions
  )
  }); // To initialize the required storage and link it to HydratedBloc
  // How data will be stored? JSONS!


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
  Widget build(BuildContext MyAppcontext) {
    return MultiBlocProvider( // MultiBlocProvider used for organizing code.
      providers: [
        BlocProvider<InternetCubit>(
          create: (InternetCubicontext) => InternetCubit(connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (CounterCubitcontext) => CounterCubit(),
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
