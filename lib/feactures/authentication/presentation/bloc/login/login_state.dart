import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{}

class LoginInitState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaderState extends LoginState {
  final String status;
  LoginLoaderState(this.status);
  @override
  List<Object> get props => [];
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);

  @override
  List<Object> get props => [];
}