part of 'counter_cubit.dart';

class CounterState extends Equatable{
  final int counterValue;
  final bool wasIncremented;

  CounterState({
    required this.counterValue,
    this.wasIncremented = false,
});

  // All of this done to store the changes in the local devices. Kind of like a cache.
  Map<String, dynamic> toMap() { // To create a map of the class instance to later convert it to json format
    return {
      'CounterValue' : counterValue,
      'wasIncremented' : wasIncremented
    };
  }

  factory CounterState.fromMap(Map<String,dynamic> map ) { // Used to create a class instance after decoding it from json
    return CounterState(
        counterValue: map['CounterValue'],
        wasIncremented: map['wasIncremented']
    );
  }
  String toJson() => json.encode(toMap()); // To convert the map into json format

  factory CounterState.fromJson(String source) => CounterState.fromMap(json.decode(source)); // Used to decode the json to a map so dart can understand it
  @override
  List<Object> get props => [counterValue, wasIncremented]; // whichever variable you want to equate in different objects of a class
  // Remember! using equatable will equate the run type of the objects. Even if the value is different, the == operator will return true.

@override
  String toString() => 'CounterState(counterValue: $counterValue, wasIncremented: $wasIncremented';
}