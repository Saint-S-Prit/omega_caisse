abstract class OrderEvent {}

class InitEvent extends OrderEvent {}



class OrderLoadedEvent extends OrderEvent {
  
  final Map<String, dynamic> variableMap;
  OrderLoadedEvent({required this.variableMap});
  @override
  List<Object> get props => [variableMap];

}