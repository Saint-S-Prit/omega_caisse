import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:omega_caisse/core/services/subscription/subscription_service.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_edite.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../data/product_model.dart';
import '../screens/add_product.dart';

class ProductCard extends StatelessWidget {
  final product;
  const ProductCard({super.key, required ProductModel this.product});

  @override
  Widget build(BuildContext context) {

    final SubscriptionService subscriptionService = SubscriptionService();

    return GestureDetector(
      onTap: () async {
        await subscriptionService.checkAndUpdateSubscriptionStatus(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled:
              true, // Permet au contenu de prendre autant de place que nécessaire
          builder: (_) {
            return SizedBox(
              // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
              height: MediaQuery.of(context).size.height *
                  0.4, // Définir la hauteur souhaitée
              child: AddProduct(
                product: product,
              ),
            );
          },
        );
      },
      child: Container(
        decoration: TextStyles.customBoxDecoration(context),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(fileURL + product.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // DETAILS PRODUCT
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: appSecondaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            color: appPrincipalColor,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${Validation.formatBalance(product.price)} Fcfa",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: appPrincipalColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // EDITE
            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Permet au contenu de prendre autant de place que nécessaire
                      builder: (_) {
                        return SizedBox(
                          // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
                          //height: MediaQuery.of(context).size.height * 0.4, // Définir la hauteur souhaitée
                          child: ProductEdite(
                            product: product,
                          ),
                        );
                      },
                    );
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: appWhiteColor,
                      ),
                      width: 25,
                      height: 25,
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                      )),
                  color: appPrincipalColor, // Couleur de l'icône
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


