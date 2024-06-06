abstract class SupervisorEvent {}

class SupervisorLoadedEvent extends SupervisorEvent {}

class SupervisorGetTeamEvent extends SupervisorEvent {}


class SupervisorGetHistoryTeamEvent extends  SupervisorEvent {
  late final int? id;
  late final String? token;
  late final String? startDay;
  late final String? endDay;

  SupervisorGetHistoryTeamEvent({required this.id,required this.token,  this.startDay, this.endDay});

  @override
  List<Object?> get props => [id,token, startDay, endDay]; // Conversion explicite en Object?
}
