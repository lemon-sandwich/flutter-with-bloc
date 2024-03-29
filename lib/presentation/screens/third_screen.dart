import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/cubit/counter_cubit.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title,required this.colors}) : super(key: key);
  final String title;
  final Color colors;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
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
                    //BlocProvider.of<CounterCubit>(context).decrement();
                    context.read<CounterCubit>().decrement();
                  },
                  heroTag: 'To Remove',
                  child: Icon(Icons.remove),
                  backgroundColor: widget.colors,
                ),
                FloatingActionButton(
                  onPressed: () {
                    //BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterCubit>().increment();
                  },
                  child: Icon(Icons.add),
                  backgroundColor: widget.colors,
                  heroTag: 'To Add',
                ),
              ],
            ),
            SizedBox(height: 24,),
            MaterialButton(onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
              color: widget.colors,
              child: Text('Go to first sreen'),
            )
          ],
        ),
      ),
    );
  }
}