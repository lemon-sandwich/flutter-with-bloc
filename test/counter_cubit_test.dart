import 'dart:math';

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
  });
}