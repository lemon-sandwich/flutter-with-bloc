part of 'internet_cubit.dart';

enum ConnectionType{
  Wifi,
  Mobile
}

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;
  InternetConnected({required this.connectionType});
  @override
  String toString() => 'InternetConnected(connectionType: $connectionType)';
}

class InternetDisconnected extends InternetState {}
