import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable{}

class LogoutInitState extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoadingState extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoaderState extends LogoutState {
  String? responseLogout;
  LogoutLoaderState(this.responseLogout);
  @override
  List<Object> get props => [];
}



class LogoutErrorState extends LogoutState {
  final String error;
  LogoutErrorState(this.error);

  @override
  List<Object> get props => [];
}