abstract class SoldEvent {}

class SoldLoadedEvent extends SoldEvent {}

class SoldClientEvent extends SoldEvent {
  final int id;
  final String? startDay;
  final String? endDay;

  SoldClientEvent({required this.id,  this.startDay, this.endDay});

  @override
  List<Object?> get props => [id, startDay, endDay]; // Conversion explicite en Object?
}
