abstract class HistoryEvent {}

class InitEvent extends HistoryEvent {}



class HistoryLoadedEvent extends HistoryEvent {
  late final int? id;
  late final String? token;
  late final String? startDay;
  late final String? endDay;

  HistoryLoadedEvent({required this.id,required this.token,  this.startDay, this.endDay});

  @override
  List<Object?> get props => [id,token, startDay, endDay]; // Conversion explicite en Object?
}