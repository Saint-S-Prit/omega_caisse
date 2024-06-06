import 'package:equatable/equatable.dart';

abstract class SoldState extends Equatable{}

class SoldLoadingState extends SoldState {
  @override
  List<Object> get props => [];
}

class SoldClientLoadedState extends SoldState {
   String  sold;
  SoldClientLoadedState(this.sold);
  @override
  List<Object> get props => [sold];
}

class SoldErrorState extends SoldState {
  final String error;
  SoldErrorState(this.error);

  @override
  List<Object> get props => [];
}
