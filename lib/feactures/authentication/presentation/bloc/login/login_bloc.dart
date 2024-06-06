import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/auth_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState()) {

    on<LoginSubmittedEvent>((event, emit) async {
      if(event is LoginSubmittedEvent){
      emit(LoginLoadingState());
      //await Future.delayed(const Duration(seconds: 2));
      try {
        final result = await AuthenticationRepository().login(event.phoneNumber, event.password);
        emit(LoginLoaderState(result!));
      } catch (e) {
        //print("erreur interne");
        emit(LoginErrorState(e.toString()));
      }
      }
    });
  }
}

