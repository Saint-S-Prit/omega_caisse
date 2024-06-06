import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cart_item_model.dart';
import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  CartBloc(): super(CartState([])){
    on<CartEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(CartEvent event, Emitter<CartState> emit) async {
    if(event is AddToCartEvent){
      final updatedCard = List<CartItemModel>.from(state.cartItems)..add(event.cartItem);
      emit(CartState(updatedCard));
    }

    if(event is RemoveFromCartEvent){
      final updatedCard = List<CartItemModel>.from(state.cartItems)..remove(event.cartItem);
      emit(CartState(updatedCard));
    }
  }


}