import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_add.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_app_bar.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_card.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../../seller/presentation/bloc/order/order_bloc.dart';
import '../../../seller/presentation/bloc/order/order_event.dart';
import '../../data/product_model.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_state.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../bloc/solde/product_bloc.dart';
import '../bloc/solde/product_event.dart';
import '../bloc/solde/product_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredProducts = [];

  String? idClient;
  String? isSubscription;
  String? isNotified;
  bool showBalance = false;



  //   // Exemple to get null
  ProductModel productModelNullValue = ProductModel(
    id: 0,
    name: "",
    price: 1,
    path: "",
    description: "",
  );



  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
    idClient = SharedPreferencesService.getId();
    isNotified = SharedPreferencesService.getIsNotified();

  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
            create: (BuildContext context) => ProductBloc()
              ..add(SearchProductEvent(id: idClient.toString()))),
        BlocProvider<SoldBloc>(
            create: (BuildContext context) => SoldBloc()
              ..add(SoldClientEvent(id: int.parse(idClient.toString())))),
      ],
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: appPrincipalColor,
                size: 14.0,
              ),
            );
          }
          if (state is ProductErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/internet_error.png",
                      height: 100,
                      width: 100,
                      excludeFromSemantics: true,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pas de connexion Internet',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Vérifiez votre connexion, puis actualisez la page.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        // Action à effectuer lors du clic sur le bouton Retry
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: appPrincipalColor),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Reessayez',
                            style: TextStyle(color: appPrincipalColor)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is ProductLoadedState) {
            List<ProductModel> products = state.productList;
            filteredProducts = products;
            return Scaffold(
              backgroundColor: appWhiteColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50, child: ProductScreenAppbar()),
                      const SizedBox(height: 10),
                      Container(
                        decoration: TextStyles.customBoxDecoration(context),
                        width: double.infinity,
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Votre solde",
                                  style: TextStyle(
                                      color: appPrincipalColor, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                BlocBuilder<SoldBloc, SoldState>(
                                  builder: (context, state) {
                                    if (state is SoldLoadingState) {
                                      return Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                          color: appPrincipalColor,
                                          size: 14.0,
                                        ),
                                      );
                                    }

                                    if (state is SoldClientLoadedState) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            showBalance
                                                ? "${Validation.formatBalance(int.parse(state.sold))} XOF"
                                                : "****",
                                            style: TextStyle(
                                              color: appPrincipalColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showBalance = !showBalance;
                                              });
                                            },
                                            child: Icon(
                                              showBalance
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                              color: appPrincipalColor,
                                            ),
                                          ),
                                        ],
                                      );
                                    }

                                    if (state is SoldErrorState) {
                                      // Retourner un widget d'erreur approprié
                                      return const Text("indisponible");
                                    }

                                    // Retourner un widget par défaut si l'état n'est pas géré
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      products.length > productLimitToAddSearchWidget
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration:
                                    TextStyles.customBoxDecoration(context),
                                child: InputCustom(
                                  controller: searchController,
                                  labelText: "Recherche",
                                  prefixIcon: Icons.search,
                                  hintText: "Recherche",
                                  obscureText: false,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                            ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              //childAspectRatio: 1,
                            ),
                            itemCount: products.length + 1,
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                return SizedBox(
                                  child: ProductCard(product: products[index]),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true, // Permet au contenu de prendre autant de place que nécessaire
                                      builder: (_) {
                                        return SizedBox(
                                          // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
                                          //height: MediaQuery.of(context).size.height * 0.4, // Définir la hauteur souhaitée
                                          child: ProductAdd(
                                            product: productModelNullValue,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration:
                                        TextStyles.customBoxDecoration(context),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: Icon(
                                            Icons.add,
                                            size: 35,
                                            color: appPrincipalColor,
                                          ),
                                        ),
                                        // DETAILS PRODUCT
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: appSecondaryColor,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Nouveau produit dans le panier",
                                                    style: TextStyle(
                                                      color: appPrincipalColor,
                                                      fontSize: 16,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),

                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return state.cartItems.isNotEmpty
                              ? Container(
                            decoration:
                            TextStyles.boxDecorationCustomer(
                                context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${Functions.totalPriceProductInCart(state.cartItems)} XOF",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: appPrincipalColor,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      Text(
                                        "${Functions.totalProductInCart(state.cartItems)} éléments dans le panier",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: appPrincipalColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final Map<String, dynamic>
                                      variableMap = {
                                        "detail":
                                        jsonEncode(state.cartItems),
                                        "amount": Functions
                                            .totalPriceProductInCart(
                                            state.cartItems),
                                        "description": "send by Saint",
                                      };
                                      context.read<OrderBloc>().add(
                                          OrderLoadedEvent(
                                              variableMap:
                                              variableMap));
                                      Navigator.of(context)
                                          .pushNamed("/productInvoice");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(15)),
                                        color: appPrincipalColor,
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Validez la commande",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: appWhiteColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                              : const SizedBox();
                        },
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );

  }
}



