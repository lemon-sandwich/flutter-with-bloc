import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/cubit/counter_cubit.dart';
import 'package:flutter_with_bloc/cubit/internet_cubit.dart';
import 'package:flutter_with_bloc/presentation/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title,required this.colors}) : super(key: key);
  final String title;
  final Color colors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit,InternetState>(
              builder: (context,state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.Wifi)
                  {
                     return const Text('Wifi',
                     style: TextStyle(
                       fontSize: 50
                     ),);
                  }
                else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile)
                {
                  return const Text('Mobile',
                    style: TextStyle(
                        fontSize: 50
                    ),);
                }
                else if (state is InternetDisconnected)
                {
                  return const Text('Disconnected',
                    style: TextStyle(
                        fontSize: 50
                    ),);
                }
                return CircularProgressIndicator();
              },
            ),
            BlocConsumer<CounterCubit, CounterState>( // Combines BlocBuilder and BlocListener to optimize code
              builder: (context, state) {
                if (state.CounterValue < 0) {
                  return Text(
                    'Negative: ${state.CounterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.CounterValue % 2 == 0) {
                  return Text(
                    'Even Number: ${state.CounterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                else if (state.CounterValue % 2 != 0) {
                  return Text(
                    'Odd Number: ${state.CounterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  state.CounterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
              listener: (context, state) { // Listens once per instance. Can be used if you want to navigate.
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                }

                if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  heroTag: 'To Remove', // Provide hero tags to every floating action button or else flutter will show errors.
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: Icon(Icons.add),
                  heroTag: 'To Add',
                ),
              ],
            ),*/
            SizedBox(height: 24,),
            MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed('/second');
            },
              color: widget.colors,
              child: Text('Go to second sreen'),
            ),
            SizedBox(height: 24,),
            MaterialButton(onPressed: () {
              Navigator.of(context).pushNamed('/third');
            },
              color: widget.colors,
              child: Text('Go to third sreen'),
            ),
          ],
        ),
      ),
    );
  }
}