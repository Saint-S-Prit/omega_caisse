
abstract class ProductEvent {}

class ProductLoadedEvent extends ProductEvent {}

class SoldProductEvent extends ProductEvent {
  final int id;
  final String? startDay;
  final String? endDay;

  SoldProductEvent({required this.id,  this.startDay, this.endDay});

  @override
  List<Object?> get props => [id, startDay, endDay]; // Conversion explicite en Object?
}

class SearchProductEvent extends ProductEvent {
  final String id;

   SearchProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}
