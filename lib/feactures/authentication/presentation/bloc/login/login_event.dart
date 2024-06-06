import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}


class LoginSubmittedEvent extends LoginEvent {
  final String phoneNumber;
  final String password;


  const LoginSubmittedEvent({required this.phoneNumber, required this.password});
  @override
  List<Object> get props => [phoneNumber, password];
}

