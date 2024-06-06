import 'package:equatable/equatable.dart';

abstract class ToggleObscureTextEvent extends Equatable{
  const ToggleObscureTextEvent();
  @override
  List<Object?> get props => [];
}

class ToggleEvent extends ToggleObscureTextEvent {}
