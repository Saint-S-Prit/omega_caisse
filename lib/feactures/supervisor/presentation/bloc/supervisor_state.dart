import 'package:equatable/equatable.dart';

import '../../../seller/data/model/history_model.dart';
import '../../data/supervisor_model.dart';

abstract class SupervisorState extends Equatable{}

class SupervisorLoadingState extends SupervisorState {
  @override
  List<Object> get props => [];
}


class SupervisorStateLoadedState extends SupervisorState {
  final List<SupervisorModel> supervisorTeamsList;
  SupervisorStateLoadedState(this.supervisorTeamsList);
  @override
  List<Object> get props => [supervisorTeamsList];
}


class SupervisorGetHistoryTeamState extends SupervisorState {
  final List<HistoryModel> supervisorGetHistoryTeamList;
  SupervisorGetHistoryTeamState(this.supervisorGetHistoryTeamList);
  @override
  List<Object> get props => [supervisorGetHistoryTeamList];
}



class SupervisorErrorState extends SupervisorState {
  final String error;
  SupervisorErrorState(this.error);

  @override
  List<Object> get props => [];
}
