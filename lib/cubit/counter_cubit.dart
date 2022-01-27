import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_with_bloc/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;
  CounterCubit(this.internetCubit) : super(CounterState(CounterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      }
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }
  
  void increment() => emit(CounterState(CounterValue: state.CounterValue + 1,wasIncremented: true));

  void decrement() => emit(CounterState(CounterValue: state.CounterValue - 1,wasIncremented: false));

  @override
  Future<void> close() {
    // TODO: implement close
    internetStreamSubscription.cancel();
    return super.close();
  }
}