import 'package:equatable/equatable.dart';

import '../login/login_state.dart';


abstract class RegisterState extends Equatable{}

class RegisterInitState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}


class VerifyIfPhoneExistState extends RegisterState {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String status;
  VerifyIfPhoneExistState(this.status,this.fullName, this.phoneNumber, this.password);
  @override
  List<Object> get props => [];
}

class RegisterLoaderState extends RegisterState {
  final String status;
  RegisterLoaderState(this.status);
  @override
  List<Object> get props => [];
}


class RegisterErrorState extends LoginState {
  final String error;
  RegisterErrorState(this.error);

  @override
  List<Object> get props => [];
}
