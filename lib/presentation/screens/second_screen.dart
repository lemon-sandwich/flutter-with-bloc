import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/cubit/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.title,required this.colors}) : super(key: key);
  final String title;
  final Color colors;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.colors,
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
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
              listener: (context, state) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  heroTag: 'To Remove',
                  child: Icon(Icons.remove),
                  backgroundColor: widget.colors,
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: Icon(Icons.add),
                  backgroundColor: widget.colors,
                  heroTag: 'To Add',
                ),
              ],
            ),
            SizedBox(height: 24,),
            MaterialButton(onPressed: () {
              Navigator.pushNamed(context, '/third');
            },
              color: widget.colors,
              child: Text('Go to third sreen'),
            )
          ],
        ),
      ),
    );
  }
}