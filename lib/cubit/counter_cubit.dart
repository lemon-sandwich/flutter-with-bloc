import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_with_bloc/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(CounterValue: 0));
  
  void increment() => emit(CounterState(CounterValue: state.CounterValue + 1,wasIncremented: true));

  void decrement() => emit(CounterState(CounterValue: state.CounterValue - 1,wasIncremented: false));

}