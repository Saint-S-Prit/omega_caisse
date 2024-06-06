import 'package:equatable/equatable.dart';

abstract class HandlePasswordEvent extends Equatable{}



class HandlePasswordLoadedEvent extends HandlePasswordEvent {
  final Map<String, dynamic> variableMap;
  HandlePasswordLoadedEvent({required this.variableMap});
  @override
  List<Object> get props => [variableMap];
}