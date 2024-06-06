import 'package:equatable/equatable.dart';

abstract class UpdateProductState extends Equatable{}

class UpdateProductInitState extends UpdateProductState {
  @override
  List<Object> get props => [];
}
class UpdateProdLoadingState extends UpdateProductState {
  @override
  List<Object> get props => [];
}




class UpdateProdLoaderState extends UpdateProductState {
  final bool response;
  UpdateProdLoaderState(this.response);

  @override
  List<Object> get props => [];
}
class UpdateProdErrorState extends UpdateProductState {
  final String error;
  UpdateProdErrorState(this.error);

  @override
  List<Object> get props => [];
}

