
  import 'package:equatable/equatable.dart';

abstract class HandlePasswordState extends Equatable{}


  class HandlePasswordInitState extends HandlePasswordState {
    @override
    List<Object> get props => [];
  }

  class HandlePasswordLoadingState extends HandlePasswordState {
    @override
    List<Object> get props => [];
  }


  class HandlePasswordLoaderState extends HandlePasswordState {

     final String message;
    HandlePasswordLoaderState(this.message);
  @override
  List<Object> get props => [message];
  }


  class HandlePasswordErrorState extends HandlePasswordState {
    final String error;
    HandlePasswordErrorState(this.error);

    @override
    List<Object> get props => [];
  }
