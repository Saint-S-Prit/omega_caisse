import '../../../../data/product_model.dart';

abstract class ProductUpdateEvent {}

class UpdateProdEvent extends ProductUpdateEvent {

  final ProductModel productModel;

  UpdateProdEvent({required this.productModel});
  @override
  List<Object> get props => [productModel];
}