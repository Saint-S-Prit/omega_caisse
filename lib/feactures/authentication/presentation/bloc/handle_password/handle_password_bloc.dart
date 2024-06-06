import 'package:bloc/bloc.dart';

import '../../../domain/repository/auth_repo.dart';
import 'handle_password_event.dart';
import 'handle_password_state.dart';

class HandlePasswordBloc extends Bloc<HandlePasswordEvent, HandlePasswordState> {
  HandlePasswordBloc() : super(HandlePasswordInitState()){

    on<HandlePasswordLoadedEvent>((event, emit) async {
      emit(HandlePasswordLoadingState());
      //await Future.delayed(const Duration(seconds: 2));
      try {
        final response = await AuthenticationRepository().changePassword(
            variableMap: event.variableMap
        );
        print("my resulte ${response}");
        emit(HandlePasswordLoaderState(response));
      } catch (e) {
        print("erreur interne AAAAA");
        emit(HandlePasswordErrorState(e.toString()));
      }
    });
  }


}
