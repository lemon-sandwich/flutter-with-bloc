part of 'counter_cubit.dart';

class CounterState extends Equatable{
  final int CounterValue;
  final bool wasIncremented;

  CounterState({
    required this.CounterValue,
    this.wasIncremented = false,
});
  @override
  List<Object> get props => [this.CounterValue, this.wasIncremented]; // whichever variable you want to equate in different objects of a class

}