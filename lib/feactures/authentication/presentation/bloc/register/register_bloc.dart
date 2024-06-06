import 'package:bloc/bloc.dart';
import 'package:omega_caisse/feactures/authentication/presentation/bloc/register/register_event.dart';
import 'package:omega_caisse/feactures/authentication/presentation/bloc/register/register_state.dart';
import '../../../domain/repository/auth_repo.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitState()) {

    on<VerifyIfPhoneExistEvent>((event, emit) async {
      emit(RegisterLoadingState());
      //await Future.delayed(const Duration(seconds: 2));
      try {
        final result = await AuthenticationRepository().verifyIfNumberExist(event.phoneNumber);
        emit(RegisterLoaderState(result!));
      } catch (e) {
        print("erreur interne");
        emit(RegisterLoaderState(e.toString()));
      }
    });


    on<RegisterSubmittedEvent>((event, emit) async {
      emit(RegisterLoadingState());
      //await Future.delayed(const Duration(seconds: 2));
      try {
        final result = await AuthenticationRepository().register(event.fullName, event.phoneNumber, event.password, event.role);
        emit(RegisterLoaderState(result!));
      } catch (e) {
        print("erreur interne");
        emit(RegisterLoaderState(e.toString()));
      }
    });
  }
}

