import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(CounterValue: 0, wasIncremented: false));
  
  void increment() => emit(CounterState(CounterValue: state.CounterValue + 1,wasIncremented: true));

  void decrement() => emit(CounterState(CounterValue: state.CounterValue - 1,wasIncremented: false));
}