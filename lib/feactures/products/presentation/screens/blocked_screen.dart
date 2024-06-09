
import 'package:flutter/material.dart';
import 'package:omega_caisse/feactures/Seller/presentation/screens/payment_screen.dart';

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  _BlockedScreenState createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Afficher le popup si _showDialog est vrai
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: AlertDialog(
                    title: const Text('INDISPOBILE'),
                    content: const Text("Votre abonnement a expiré, veuillez procéder au paiement des 5.000 FCFA!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled:
                            true, // Permet au contenu de prendre autant de place que nécessaire
                            builder: (BuildContext context) {
                              return SizedBox(
                                // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
                                  height: MediaQuery.of(context).size.height *
                                      0.3, // Définir la hauteur souhaitée
                                  child: const PaymentScreen());
                            },
                          );
                        },
                        child: Text('Payer'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}