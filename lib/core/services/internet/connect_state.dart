abstract class ConnectState {}


class InitState extends ConnectState {}

class ConnectedState extends ConnectState {
String message;

ConnectedState({required this.message});

}
class NotConnectedState extends ConnectState {
  String message;
  NotConnectedState({required this.message});
}

