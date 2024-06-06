import 'package:equatable/equatable.dart';

import '../../../data/product_model.dart';

abstract class ProductState extends Equatable{}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductModel> productList;
  ProductLoadedState(this.productList);
  @override
  List<Object> get props => [productList];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);

  @override
  List<Object> get props => [];
}

