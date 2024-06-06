import 'package:bloc/bloc.dart';

import '../../../domain/repository/history_repo.dart';
import 'history_event.dart';
import 'history_state.dart';


class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryLoadingState()) {
    on<HistoryEvent>((event, emit) async {
      if (event is HistoryLoadedEvent) {
        emit(HistoryLoadingState());
        try {
          final history = await HistoryRepository().getOrders(id: event.id, token: event.token
          );
          emit(HistoryLoadedState(history!));
        } catch (e) {
          emit(HistoryErrorState(e.toString()));
        }
      }
    });


  }
}
