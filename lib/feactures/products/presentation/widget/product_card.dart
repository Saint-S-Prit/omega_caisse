import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:omega_caisse/core/services/subscription/subscription_service.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_edite.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../../Seller/presentation/screens/payment_screen.dart';
import '../../data/product_model.dart';
import '../screens/add_product.dart';


final localStorageSecurity = LocalStorageSecurity();

class ProductCard extends StatelessWidget {
  final product;
  const ProductCard({super.key, required ProductModel this.product});

  @override
  Widget build(BuildContext context) {

    final SubscriptionService subscriptionService = SubscriptionService();


    return GestureDetector(
      onTap: () async {
        bool update = await subscriptionService.checkAndUpdateSubscriptionStatus(context);
        if (!update) {
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
        } else if (SharedPreferencesService.getIsNotified() == "true") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: const Icon(IconData(0xe0b2, fontFamily: 'MaterialIcons')),
                title: const Text('Paiement'),
                content: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Nous vous remercions de bien vouloir effectuer le paiement de votre abonnement avant ',
                          style: const TextStyle(color: Colors.black), // Style par défaut pour le texte
                          children: <TextSpan>[
                            TextSpan(
                              text: 'le 5 ${Functions.getMonthRangeGetMonthName().toString()} .',
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold), // Style pour la partie en rouge
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pour espacer les boutons
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appPrincipalColor, // Couleur du bouton
                        ),
                        child: const Text(
                          "Payez maintenant",
                          style: TextStyle(color: Colors.white, fontSize: 12), // Couleur du texte
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // Permet au contenu de prendre autant de place que nécessaire
                            builder: (_) {
                              return const SizedBox(
                                  child: PaymentScreen());
                            },
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appWarning, // Couleur du bouton
                        ),
                        child: const Text(
                          "Plus tard",
                          style: TextStyle(color: Colors.white, fontSize: 12), // Couleur du texte
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                ],


              );
            },
          );
        } else {
          // Si la condition n'est pas remplie, ne faites rien ou affichez un autre widget
        }
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


