import 'package:flutter/material.dart';
import 'package:omega_caisse/feactures/seller/presentation/screens/orange_transactor.dart';
import 'package:omega_caisse/feactures/seller/presentation/screens/wave_transactor.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/styles/color.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text("Payez votre abonnement avec :", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          // Action à effectuer lors du tap sur le conteneur
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled:
                            true, // Permet au contenu de prendre autant de place que nécessaire
                            builder: (_) {
                              return const SizedBox(
                                  child: WaveTransactor());
                            },
                          );

                        },
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appPrincipalColor.withOpacity(0.1), // Couleur de l'ombre
                            spreadRadius: 3, // Rayon de diffusion
                            blurRadius: 4, // Flou de l'ombre
                            offset: const Offset(0, 2), // Décalage de l'ombre
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Définir le rayon pour rendre les coins de l'image arrondis
                        child: Image.asset(
                          "assets/logo-wave.jpeg",
                          //fit: BoxFit.cover, // Ajuster l'image pour couvrir entièrement le conteneur
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();

                      // Action à effectuer lors du tap sur le conteneur
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                        true, // Permet au contenu de prendre autant de place que nécessaire
                        builder: (_) {
                          return const SizedBox(
                              child: OrangeTransactor());
                        },
                      );

                    },
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appPrincipalColor.withOpacity(0.1), // Couleur de l'ombre
                            spreadRadius: 3, // Rayon de diffusion
                            blurRadius: 4, // Flou de l'ombre
                            offset: const Offset(0, 2), // Décalage de l'ombre
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Définir le rayon pour rendre les coins de l'image arrondis
                        child: Image.asset(
                          "assets/logo-orange.png",
                          fit: BoxFit.cover, // Ajuster l'image pour couvrir entièrement le conteneur
                        ),
                      ),
                    ),
                  )


                  // GestureDetector(
                  //   child: Container(
                  //     width: 100,
                  //     height: 100,
                  //     decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //       border: Border.all(
                  //         color: appPrincipalColor.withOpacity(0.2),
                  //         width: 2,
                  //       ),
                  //     ),
                  //     child: ClipRRect( // Définir le rayon pour rendre les coins de l'image arrondis
                  //       child: Image.asset(
                  //         "assets/Orange-Money-logo.png",
                  //         fit: BoxFit.cover, // Ajuster l'image pour couvrir entièrement le conteneur
                  //       ),
                  //     ),
                  //   )
                  //
                  //   ,
                  // ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void sharePressed() {
  String message = 'Check out eclectify University, where you can become an '
      'Elite Flutter Developer in no time: https://eclectify-universtiy.web.app';
  Share.share(message);

  /// optional subject that will be used when sharing to email
  // Share.share(message, subject: 'Become An Elite Flutter Developer');

  /// share a file
  // Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
  /// share multiple files
  // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
}
