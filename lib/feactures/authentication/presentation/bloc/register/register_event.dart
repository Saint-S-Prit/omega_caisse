import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class VerifyIfPhoneExistEvent extends RegisterEvent {
  final String phoneNumber;
  const VerifyIfPhoneExistEvent({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String role;
  const RegisterSubmittedEvent({required this.fullName,required this.phoneNumber, required this.password,required this.role, });
  @override
  List<Object> get props => [fullName, phoneNumber, password, role];
}