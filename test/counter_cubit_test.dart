import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_with_bloc/cubit/counter_cubit.dart';

void main(){

  group('Counter Cubit', () {
    CounterCubit counterCubit = CounterCubit();

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });
    test('the initial state for the CounterCubit is CounterState(counterValue: 0)', () {
      expect(counterCubit.state, CounterState(CounterValue: 0));
    });

    blocTest<CounterCubit, CounterState>(
      'the cubit should emit a CounterState(counterValue: 1,wasIncremented: true) when cubit.increment() function is called',
      build: () => CounterCubit(),
      act: (bloc) {
        bloc.increment();
      },
      expect: () => <CounterState>[
        CounterState(CounterValue: 1,wasIncremented: true)
      ],
    );

    blocTest<CounterCubit, CounterState>(
      'the cubit should emit a CounterState(counterValue: -1,wasIncremented: false) when cubit.increment() function is called',
      build: () => CounterCubit(),
      act: (bloc) {
        bloc.decrement();
      },
      expect: () => <CounterState>[
        CounterState(CounterValue: -1,wasIncremented: false)
      ],
    );
  });
}