import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../authentication/domain/repository/auth_repo.dart';
import 'product_event.dart';
import 'product_state.dart';

class SoldBloc extends Bloc<SoldEvent, SoldState> {

  SoldBloc() : super(SoldLoadingState()) {
    on<SoldEvent>((event, emit) async {
      if (event is SoldClientEvent) {
        emit(SoldLoadingState());
        try {
          final sold = await AuthenticationRepository().getBalanceClient(id: event.id
          );
          emit(SoldClientLoadedState(sold));
        } catch (e) {
          emit(SoldErrorState(e.toString()));
        }
      }
    });
  }
}
