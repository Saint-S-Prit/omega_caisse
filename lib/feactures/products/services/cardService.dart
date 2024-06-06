import 'dart:convert'; // Importez le package dart:convert
import 'package:shared_preferences/shared_preferences.dart';

import '../data/cart_item_model.dart';
import '../data/product_model.dart';

class CartService {
  static const _cartKey = 'cart';

  Future<void> addToCart(ProductModel product, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    // // Créez un objet CartItem contenant le nom du produit, le prix unitaire et la quantité
    // CartItemModel cartItem = CartItemModel(
    //   id: product.id,
    //   name: product.name,
    //   price: product.price,
    //   path: product.path,
    //   quantity: quantity,
    // );

    // Convertissez l'objet CartItem en JSON et ajoutez-le au panier
    cart.add(jsonEncode([]));
    //cart.add(jsonEncode(cartItem.toJson()));
    await prefs.setStringList(_cartKey, cart);
  }




  // Méthode pour récupérer les produits du panier
  Future<List<CartItemModel>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> cart = prefs.getStringList(_cartKey) ?? [];
    // Convert each string into a ProductModel object
    List<CartItemModel> cartItems = cart.map((jsonString) {
      CartItemModel cartItem = CartItemModel.fromJson(jsonDecode(jsonString));
      // Assuming ProductModel has a constructor that takes CartItemModel
      return CartItemModel(
        id: cartItem.id,
        name: cartItem.name,
        price: cartItem.price,
        path: cartItem.path,
        quantity: cartItem.quantity,
      );
    }).toList();
    return cartItems;
  }


  //
  // void addToCartExample(ProductModel productModel, int quantity) async {
  //   CartService cartService = CartService();
  //   CartItemModel cartItemModel = CartItemModel(name: productModel.name, price: productModel.price, quantity: quantity);
  //   await cartService.addToCart(product, 2);
  //   print('Product added to cart.');
  // }
  //
  // void getCartExample() async {
  //   CartService cartService = CartService();
  //   List<ProductModel> cartProducts = await cartService.getCart();
  //   print('Cart Products: $cartProducts');
  // }
}
