import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin{
  CounterCubit() : super(CounterState(counterValue: 0));
  
  void increment() => emit(CounterState(counterValue: state.counterValue + 1,wasIncremented: true));

  void decrement() => emit(CounterState(counterValue: state.counterValue - 1,wasIncremented: false));

  @override
  CounterState? fromJson(Map<String, dynamic> json) { // called everytime the app needs the data
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) { //  called for every state
  //  addError(Exception("Couldn't write to storage"),StackTrace.current);
    return state.toMap();
  }

  /*@override
  void onError(Object error, StackTrace stackTrace) { // To check for Errors
    print('$error , $stackTrace');
    super.onError(error, stackTrace);
  }*/

  @override
  void onChange(Change<CounterState> change) { // Tells the currentState and nextState
    print(change);
    super.onChange(change);
  }

}