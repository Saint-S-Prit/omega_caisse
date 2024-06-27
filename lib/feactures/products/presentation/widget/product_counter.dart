import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/animated_toggle.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/styles/color.dart';
import '../../data/cart_item_model.dart';
import '../../data/product_model.dart';
import '../../services/cardService.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_event.dart';
import '../bloc/cart/add_to_cart_state.dart';

final CartService cartService = CartService();

class ProductCounter extends StatefulWidget {
  final ProductModel product;
  final num currentNumber;
  final Function() onAdd;
  final Function() onRemove;

  const ProductCounter({
    Key? key,
    required this.product,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  double sommeByProduct = 0;
  @override
  void initState() {
    super.initState();
    calculateTotal();
    super.initState();
    _currentNumber = widget
        .currentNumber; // Initialisez la variable d'état avec la valeur initiale
    _numberController = TextEditingController(text: "${widget.currentNumber}");
    category = SharedPreferencesService.getCategory();
  }

  void calculateTotal() {
    sommeByProduct = 0;
    CartState state = context.read<CartBloc>().state;
    for (var cartItem in state.cartItems) {
      sommeByProduct += cartItem.price * cartItem.quantity;
    }
  }

  // Initialiser une liste pour stocker les objets JSON
  List<Map<String, dynamic>> cartItemsJson = [];

  late TextEditingController _numberController;
  late num _currentNumber;
  String? category;
  String? unity = "Mètre";
  int _toggleValue = 0;
  bool isMeterSelected = false;
  bool isYardSelected = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProductCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mettre à jour le texte du contrôleur lorsque le nombre actuel change
    _numberController.text = "$_currentNumber";
  }

  @override
  Widget build(BuildContext context) {
    return SharedPreferencesService.getCategory() != categoryTextile

        // AJOUTER  PRODUITS DIFFERENT DE TISSUS
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.price} XOF",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: appPrincipalColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentNumber > 0
                                  ? _currentNumber--
                                  : _currentNumber = 0;
                            });
                            widget.onRemove();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _currentNumber.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentNumber++; // Incrémentez le nombre actuel
                            });
                            widget.onAdd(); // Appeler la méthode onAdd
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sous-total",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.price * _currentNumber} XOF",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _currentNumber > 0
                    ? SubmitButtonCustom(
                        onPressed: () {
                          // Vérifier si le produit est déjà dans le panier
                          final cartBloc = context.read<CartBloc>();
                          final currentState = cartBloc.state;
                          final cartItems = currentState.cartItems;
                          bool alreadyExists = false;
                          // Mise à jour de la quantité du produit s'il existe déjà dans le panier
                          for (var item in cartItems) {
                            if (item.name.toString() ==
                                widget.product.name.toString()) {
                              alreadyExists = true;
                              item.quantity +=
                                  _currentNumber; // Mise à jour de la quantité
                              CartItemModel cartItemModel = CartItemModel(
                                id: item.id.toString(),
                                name: item.name,
                                price: item.price,
                                unity: "",
                                quantity: item.quantity,
                                path: item.path.isNotEmpty ? item.path : '',
                              );
                              cartItems.remove(item);
                              cartBloc.add(AddToCartEvent(cartItemModel));
                              Navigator.of(context).pop();
                            }
                          }

                          // Si le produit n'existe pas déjà dans le panier, l'ajouter
                          if (!alreadyExists) {
                            CartItemModel cartItemModel = CartItemModel(
                              id: widget.product.id.toString(),
                              name: widget.product.name,
                              price: widget.product.price,
                              unity: "",
                              quantity: _currentNumber,
                              path: widget.product.path,
                            );
                            cartBloc.add(AddToCartEvent(cartItemModel));
                            Navigator.pop(context);
                          }
                        },
                        textSubmit: "Ajouter",
                      )
                    : const SizedBox()
              ],
            ),
          )
        // AJOUTER  PRODUITS TISSUS
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.price} XOF",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: appPrincipalColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentNumber > 0
                                  ? _currentNumber -= 0.5
                                  : _currentNumber = 0;
                            });
                            widget.onRemove();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _currentNumber.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentNumber +=
                                  0.5; // Incrémentez le nombre actuel
                            });
                            widget.onAdd(); // Appeler la méthode onAdd
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedToggle(
                  values: const ['Mètre', 'Yard'],
                  onToggleCallback: (value) {
                    setState(() {
                      _toggleValue = value;
                      value == 0 ? unity = "Mètre" : unity = "Yard";
                    });
                  },
                  buttonColor: const Color(0xFF0A3157),
                  backgroundColor: const Color(0xFFB5C1CC),
                  textColor: const Color(0xFFFFFFFF),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sous-total",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.product.price * _currentNumber} XOF",
                      style: TextStyle(
                          color: appPrincipalColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _currentNumber > 0
                    ? SubmitButtonCustom(
                        onPressed: () {
                          // Vérifier si le produit est déjà dans le panier
                          final cartBloc = context.read<CartBloc>();
                          final currentState = cartBloc.state;
                          final cartItems = currentState.cartItems;
                          bool alreadyExists = false;
                          for (var item in cartItems) {
                            if (item.id.toString() ==
                                widget.product.id.toString()) {
                              alreadyExists = true;
                              item.quantity +=
                                  _currentNumber; // Mise à jour de la quantité
                              CartItemModel cartItemModel = CartItemModel(
                                id: item.id.toString(),
                                name: item.name,
                                price: item.price,
                                unity: unity.toString().isNotEmpty
                                    ? unity
                                    : "Mètre",
                                quantity: item.quantity,
                                path: item.path,
                              );
                              cartItems.remove(item);
                              cartBloc.add(AddToCartEvent(cartItemModel));

                              Navigator.of(context).pop();
                            }
                          }
                          // Si le produit n'existe pas déjà dans le panier, l'ajouter
                          if (!alreadyExists) {
                            CartItemModel cartItemModel = CartItemModel(
                              id: widget.product.id.toString(),
                              name: widget.product.name,
                              price: widget.product.price,
                              unity:
                                  unity.toString().isNotEmpty ? unity : "Mètre",
                              quantity: _currentNumber,
                              path: widget.product.path,
                            );
                            cartBloc.add(AddToCartEvent(cartItemModel));
                          }
                          Navigator.pop(context);
                        },
                        textSubmit: "Ajouter",
                      )
                    : SizedBox(),
              ],
            ),
          );
  }
}
