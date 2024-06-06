import '../../../data/cart_item_model.dart';

class CartState {
  List<CartItemModel> cartItems;
  CartState(this.cartItems);
}


class RemoveFromCartState {
  CartItemModel cartItem;
  RemoveFromCartState(this.cartItem);
}