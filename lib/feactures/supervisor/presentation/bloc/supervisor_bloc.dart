import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/feactures/supervisor/presentation/bloc/supervisor_event.dart';
import 'package:omega_caisse/feactures/supervisor/presentation/bloc/supervisor_state.dart';
import '../../data/supervisor_model.dart';
import '../../domain/repository/supervisor_repo.dart';

class SupervisorBloc extends Bloc<SupervisorEvent, SupervisorState> {
  final SupervisorRepository supervisorRepository;

  SupervisorBloc({required this.supervisorRepository}) : super(SupervisorLoadingState()) {
    on<SupervisorEvent>((event, emit) async {
      if (event is SupervisorGetTeamEvent) {
        emit(SupervisorLoadingState());
        try {
          final supervisorTeamList = await supervisorRepository.getSupervisorTeamList();
          emit(SupervisorStateLoadedState(supervisorTeamList));
        } catch (e) {
          emit(SupervisorErrorState(e.toString()));
        }
      } else if (event is SupervisorGetHistoryTeamEvent) {
        emit(SupervisorLoadingState());
        try {
          final supervisorGetHistoryTeamList = await supervisorRepository.getOrdersItemTeam(
            id: event.id,
            token: event.token,
            startDay: event.startDay,
            endDay: event.endDay,
          );
          emit(SupervisorGetHistoryTeamState(supervisorGetHistoryTeamList!));
        } catch (e) {
          emit(SupervisorErrorState(e.toString()));
        }
      }
    });
  }
}
