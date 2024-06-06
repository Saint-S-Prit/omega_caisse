import 'package:equatable/equatable.dart';

abstract class ToggleObscureTextState extends Equatable{

  const ToggleObscureTextState();

  @override
  List<Object?> get props => [];
}

class ToggleState extends ToggleObscureTextState {
    final bool isObscure;

   const ToggleState(this.isObscure);

    @override
    List<Object?> get props => [isObscure];
}