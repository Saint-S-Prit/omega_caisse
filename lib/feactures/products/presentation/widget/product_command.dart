import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/core/utils/validation.dart';

import '../../../../core/common/widgets/separator.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../seller/presentation/bloc/order/order_bloc.dart';
import '../../../seller/presentation/bloc/order/order_event.dart';
import '../../data/cart_item_model.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_event.dart';
import '../bloc/cart/add_to_cart_state.dart';

class ProductCommand extends StatefulWidget {
  const ProductCommand({super.key});

  @override
  State<ProductCommand> createState() => _ProductCommandState();
}

class _ProductCommandState extends State<ProductCommand> {
  double sommeByProduct = 0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() {
    sommeByProduct = 0;
    CartState state = context.read<CartBloc>().state;
    for (var cartItem in state.cartItems) {
      sommeByProduct += cartItem.price * cartItem.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      // appBar: AppBar(),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text("Votre panier est vide"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        CartItemModel carts = state.cartItems[index];
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            appPrincipalColor.withOpacity(0.2),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: carts.path == null
                                          ? Colors.green
                                          : null, // Si le path est null, utiliser la couleur verte
                                      image: carts.path != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  fileURL + carts.path),
                                              fit: BoxFit.contain,
                                            )
                                          : null, // Ne pas utiliser d'image si le path est null
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          carts.name.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${carts.quantity.toString()} x ${Validation.formatBalance(carts.price)} XOF",
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SharedPreferencesService.getCategory() !=
                                          categoryTextile
                                      ? Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: appPrincipalColor
                                                  .withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          width: 130,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (carts.quantity > 0) {
                                                      carts
                                                          .quantity--; // Diminuer la quantité actuelle
                                                      sommeByProduct -=
                                                          carts.price;
                                                    }
                                                    if (carts.quantity == 0) {
                                                      // Récupérer l'objet CartItemModel à supprimer de la liste
                                                      final CartItemModel
                                                          itemToRemove = state
                                                              .cartItems
                                                              .firstWhere(
                                                                  (item) =>
                                                                      item.id ==
                                                                      carts.id);
                                                      if (itemToRemove !=
                                                          null) {
                                                        // Si l'objet est trouvé dans la liste, déclencher l'événement RemoveFromCartEvent avec cet objet
                                                        context.read<CartBloc>().add(
                                                            RemoveFromCartEvent(
                                                                cartItem:
                                                                    itemToRemove));
                                                      }
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove),
                                              ),
                                              Text(carts.quantity.toString()),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    carts
                                                        .quantity++; // Incrémentez le nombre actuel
                                                    sommeByProduct +=
                                                        carts.price;
                                                  });
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ))
                                      : Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: appPrincipalColor
                                                  .withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          width: 130,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (carts.quantity > 0) {
                                                      carts.quantity = carts
                                                              .quantity -
                                                          0.5; // Diminuer la quantité actuelle
                                                      sommeByProduct -=
                                                          carts.price;
                                                    }
                                                    if (carts.quantity == 0) {
                                                      // Récupérer l'objet CartItemModel à supprimer de la liste
                                                      final CartItemModel
                                                          itemToRemove = state
                                                              .cartItems
                                                              .firstWhere(
                                                                  (item) =>
                                                                      item.id ==
                                                                      carts.id);
                                                      if (itemToRemove !=
                                                          null) {
                                                        // Si l'objet est trouvé dans la liste, déclencher l'événement RemoveFromCartEvent avec cet objet
                                                        context.read<CartBloc>().add(
                                                            RemoveFromCartEvent(
                                                                cartItem:
                                                                    itemToRemove));
                                                      }
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove),
                                              ),
                                              Text(carts.quantity.toString()),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    carts.quantity = carts
                                                            .quantity +
                                                        0.5; // Incrémentez le nombre actuel
                                                    sommeByProduct +=
                                                        carts.price;
                                                  });
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Separator(), // Espace entre la ListView.builder et le total à payer
                  Text(
                    'Total à payer :   ${Validation.formatBalance(sommeByProduct)} XOF',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 50.0, left: 50.0, top: 5, bottom: 5.0),
                    child: SubmitButtonCustom(
                      onPressed: () {
                        final Map<String, dynamic> variableMap = {
                          "detail": jsonEncode(state.cartItems),
                          "amount": Functions.totalPriceProductInCart(
                              state.cartItems),
                          "description": "send by Saint",
                        };

                        // Envoyer l'événement pour charger les données
                        context
                            .read<OrderBloc>()
                            .add(OrderLoadedEvent(variableMap: variableMap));
                        // Naviguer vers la page "/productInvoice" après avoir ajouté l'événement
                        Navigator.of(context)
                            .pushNamed("/productInvoice", arguments: []);
                      },
                      textSubmit: 'Valider la commande',
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
