import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
  @override
  List<Object> get props => [];
}


class LogoutSubmittedEvent extends LogoutEvent {

  const LogoutSubmittedEvent();
  @override
  List<Object> get props => [];
}
