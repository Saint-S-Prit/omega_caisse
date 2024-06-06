import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/auth_repo.dart';
import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitState()) {

    on<LogoutSubmittedEvent>((event, emit) async {
      print("deonnexion");
      if(event is LogoutSubmittedEvent){
      emit(LogoutLoadingState());
      //await Future.delayed(const Duration(seconds: 2));
      try {
        final result = await AuthenticationRepository().logout();
        emit(LogoutLoaderState(result!));
      } catch (e) {
        //print("erreur interne");
        emit(LogoutErrorState(e.toString()));
      }
      }
    });
  }
}

