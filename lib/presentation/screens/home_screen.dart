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
    // Advantage of BlocProvider. You just have to type WHAT to do and not HOW to do it.
    // Just calling the functions of that CounterCubit instance. The working in CounterCubit is all removed.
    // We don't have to type the logic of how it should be done in the CounterCubit now.
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
                  if (state.counterValue < 0) {
                    return Text(
                      'Negative: ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'Even Number: ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                  else if (state.counterValue % 2 != 0) {
                    return Text(
                      'Odd Number: ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                  return Text(
                    state.counterValue.toString(),
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
              SizedBox(height:30),
              Builder(
                  builder: (context) {
                    final counterState = context.watch<CounterCubit>().state;
                    final internetState = context.watch<InternetCubit>().state;
                    if(internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile) {
                      return Text('Counter: ' + counterState.counterValue.toString() + ' Internet: Mobile',
                      style: Theme.of(context).textTheme.headline6,);
                    }
                    else if(internetState is InternetConnected && internetState.connectionType == ConnectionType.Wifi) {
                      return Text('Counter: ' + counterState.counterValue.toString() + ' Internet: Wifi',
                        style: Theme.of(context).textTheme.headline6,);
                    }
                    else {
                      return Text('Counter: ' + counterState.counterValue.toString() + ' Internet: Disconnected',
                    style: Theme.of(context).textTheme.headline6,);
                    }
                  }
              ),
              SizedBox(height: 30,),
              Builder(
                  builder: (context){
                final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);
                return Text(
                  'Counter' + counterValue.toString(),
                  style: Theme.of(context).textTheme.headline6,
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                    //  BlocProvider.of<CounterCubit>(context).decrement();
                      context.read<CounterCubit>().decrement(); // You can use either
                    },
                    heroTag: 'To Remove', // Provide hero tags to every floating action button or else flutter will show errors.
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      //BlocProvider.of<CounterCubit>(context).increment();
                      context.read<CounterCubit>().increment();
                    },
                    child: Icon(Icons.add),
                    heroTag: 'To Add',
                  ),
                ],
              ),
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