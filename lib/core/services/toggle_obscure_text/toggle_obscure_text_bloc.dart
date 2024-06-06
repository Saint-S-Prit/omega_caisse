import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/core/services/toggle_obscure_text/toggle_obscure_text_event.dart';

import 'toggle_obscure_text_state.dart';

class ToggleObscureTextBloc extends Bloc<ToggleObscureTextEvent, ToggleObscureTextState> {
  ToggleObscureTextBloc() : super(const ToggleState(true)){
    on<ToggleEvent>((event, emit)  {
        emit(ToggleState(!(state as ToggleState).isObscure));
    });
  }

}
