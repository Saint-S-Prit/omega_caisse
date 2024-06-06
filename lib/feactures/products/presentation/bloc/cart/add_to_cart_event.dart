import 'package:equatable/equatable.dart';
import '../../../data/cart_item_model.dart';

class CartEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final CartItemModel cartItem;
  AddToCartEvent(this.cartItem);


  @override
  List<Object> get props => [cartItem];
}
class RemoveFromCartEvent extends CartEvent {
  CartItemModel cartItem;
  RemoveFromCartEvent({required this.cartItem});


  @override
  List<Object> get props => [cartItem];
}

