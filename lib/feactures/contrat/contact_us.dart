import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/common/widgets/call_options.dart';
import '../../core/common/widgets/custom_mode_call_worker.dart';
import '../../core/services/storage/SharedPreferencesService.dart';
import '../../core/utils/constants/app_constants.dart';
import '../../core/utils/styles/color.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final id = SharedPreferencesService.getId();
    CallOption callOption = CallOption();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
          onPressed: () {
            // Action du bouton de retour
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 35.0,
              child: Text(
                'Contactez-nous',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/black.png",
                    height: 200,
                    width: 200,
                    color: appPrincipalColor,
                  ),
                  ),
                const Text(
                    "vous pouvez contacter notre équipe de support client pour obtenir de l'aide en cas de questions ou de problèmes. Nous sommes là pour vous aider "),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (id != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Voulez-vous passer un appel téléphone ?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, "Annuler"),
                            child: const Text("Annuler"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Pour appeler via WhatsApp
                              callOption.makePhoneCall(appPhoneNumber);
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed('/loginClientScreen');
                  }
                },
                child: const CustomModeCallWorker(
                  mode: "appel",
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (id != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Voulez-vous passer un appel WhatsApp ?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Annuler'),
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Pour appeler via WhatsApp
                              callOption.whatsApp(appPhoneNumber);
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed('/loginClientScreen');
                  }
                },
                child: const CustomModeCallWorker(
                  mode: "whatsapp",
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (id != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Confirmation"),
                        content:
                            const Text("Voulez-vous passer un message Gmail ?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Annuler'),
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Pour appeler via WhatsApp
                              callOption.whatsApp(appPhoneNumber);
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed('/loginClientScreen');
                    // Ne pas afficher le showDialog car performCall a renvoyé false
                    // Vous pouvez gérer cette condition selon vos besoins
                  }
                },
                child: const CustomModeCallWorker(
                  mode: "Gmail",
                ),
              ),
            ],
          ),

          // Row(
          //   children: [
          //     const SizedBox(width: 50.0),
          //     GestureDetector(
          //       onTap: () {
          //           showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 title: const Text("Confirmation"),
          //                 content: const Text(
          //                   "Voulez-vous passer un appel téléphone ?",
          //                   style: TextStyle(fontSize: 12),
          //                 ),
          //                 actions: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                     children: [
          //                       TextButton(
          //                         child: const Row(
          //                           children: [
          //                             Icon(
          //                               Icons.cancel,
          //                               color: Colors.red, // Icône Annuler en rouge
          //                             ),
          //                             SizedBox(
          //                               width: 5.0,
          //                             ),
          //                             Text(
          //                               "Annuler",
          //                               style: TextStyle(color: Colors.red),
          //                             ),
          //                           ],
          //                         ),
          //                         onPressed: () {
          //                           Navigator.of(context).pop();
          //                         },
          //                       ),
          //                       TextButton(
          //                         child:  Row(
          //                           children: [
          //                             Icon(
          //                               Icons.phone, // Utilisez l'icône de message (WhatsApp)
          //                               color: appPrincipalColor,
          //                             ),
          //                             Text(
          //                               "Appel",
          //                               style: TextStyle(color: appPrincipalColor),
          //                             ),
          //                           ],
          //                         ),
          //                         onPressed: () {
          //                           // if (currentClientPhoneNumber.isNotEmpty && targetPhoneNumber.isNotEmpty) {
          //                           //   // Ajoutez des journaux d'appels et passez l'appel ici
          //                           //   callLogController.addNewCallLog(
          //                           //       currentClientPhoneNumber, targetPhoneNumber, "APPEL");
          //                           //   workerController.makePhoneCall(targetPhoneNumber);
          //                           //
          //                           //   Navigator.of(context).pop(); // Ferme la boîte de dialogue
          //                           // } else {
          //                           //   // Gérez le cas où les numéros de téléphone sont vides
          //                           //   // Vous pouvez afficher un message d'erreur ou effectuer d'autres actions.
          //                           //   Navigator.of(context).pop(); // Ferme la boîte de dialogue
          //                           // }
          //                         },
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               );
          //             },
          //           );
          //
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             width: 50,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: appPrincipalColor,
          //             ),
          //             child: Center(
          //               child: Image.asset(
          //                 "assets/calling.png",
          //                 width: 20,
          //                 height: 20,
          //                 color: appWhiteColor,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 10.0,
          //           ),
          //           const Text(
          //             "Appel",
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 50.0),
          //     GestureDetector(
          //       onTap: () {
          //         // if (currentClient != null ||
          //         //     clientController.currentClientUpdates.value) {
          //           showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 title: const Text("Confirmation"),
          //                 content: const Text(
          //                   "Voulez-vous passer un appel WhatsApp ?",
          //                   style: TextStyle(fontSize: 12),
          //                 ),
          //                 actions: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                     children: [
          //                       TextButton(
          //                         child: const Row(
          //                           children: [
          //                             Icon(
          //                               Icons.cancel,
          //                               color: Colors.red, // Icône Annuler en rouge
          //                             ),
          //                             SizedBox(
          //                               width: 5.0,
          //                             ),
          //                             Text(
          //                               "Annuler",
          //                               style: TextStyle(color: Colors.red),
          //                             ),
          //                           ],
          //                         ),
          //                         onPressed: () {
          //                           Navigator.of(context).pop();
          //                         },
          //                       ),
          //                       TextButton(
          //                         child:  Row(
          //                           children: [
          //                             Icon(
          //                               Icons.message, // Utilisez l'icône de message (WhatsApp)
          //                               color: appPrincipalColor,
          //                             ),
          //                             Text(
          //                               "WhatsApp",
          //                               style: TextStyle(color: appPrincipalColor),
          //                             ),
          //                           ],
          //                         ),
          //                         onPressed: () {
          //                           // String url = "https://wa.me/$targetPhoneNumber/?text=Worker Express221";
          //                           // launch(url);
          //                           // // Ajouter dans le journal d'appels
          //                           // callLogController.addNewCallLog(
          //                           //   currentClientPhoneNumber,
          //                           //   targetPhoneNumber,
          //                           //   "WHATSAPP",
          //                           // );
          //                           // Navigator.of(context).pop();
          //                         },
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               );
          //             },
          //           );
          //         // } else {
          //         //   _showEditProfilePopup();
          //         // }
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             width: 50,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: appPrincipalColor,
          //             ),
          //             child: Center(
          //               child: Image.asset(
          //                 "assets/logo_whatsap.png", // Utilisez le bon nom d'icône pour WhatsApp
          //                 width: 20,
          //                 height: 20,
          //                 color: appWhiteColor,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 10.0,
          //           ),
          //            Text(
          //             "WhatsApp", // Changez le texte en "WhatsApp"
          //             style: TextStyle(
          //               color: appPrincipalColor,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 50.0),
          //     GestureDetector(
          //       onTap: () {
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               title: const Text("Confirmation"),
          //               content: const Text(
          //                 "Voulez-vous passer un appel WhatsApp ?",
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //               actions: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: [
          //                     TextButton(
          //                       child: const Row(
          //                         children: [
          //                           Icon(
          //                             Icons.cancel,
          //                             color: Colors.red, // Icône Annuler en rouge
          //                           ),
          //                           SizedBox(
          //                             width: 5.0,
          //                           ),
          //                           Text(
          //                             "Annuler",
          //                             style: TextStyle(color: Colors.red),
          //                           ),
          //                         ],
          //                       ),
          //                       onPressed: () {
          //                         Navigator.of(context).pop();
          //                       },
          //                     ),
          //                     TextButton(
          //                       child: Row(
          //                         children: [
          //                           Icon(
          //                             Icons.message, // Utilisez l'icône de message (WhatsApp)
          //                             color: appPrincipalColor,
          //                           ),
          //                           Text(
          //                             "Gmail",
          //                             style: TextStyle(color: appPrincipalColor),
          //                           ),
          //                         ],
          //                       ),
          //                       onPressed: () async {
          //                         // final Uri _emailLaunchUri = Uri(
          //                         //   scheme: 'mailto',
          //                         //   path: 'saintespritt@gmail.com',
          //                         //   queryParameters: {
          //                         //     'subject': 'Sujet de l\'e-mail',
          //                         //     'body': 'Contenu du message',
          //                         //   },
          //                         // );
          //                         // final String url = _emailLaunchUri.toString();
          //                         // if (await canLaunch(url)) {
          //                         //   await launch(url);
          //                         // } else {
          //                         //   throw 'Impossible de lancer l\'e-mail';
          //                         // }
          //                         Navigator.of(context).pop();
          //                       },
          //                     ),
          //                   ],
          //                 )
          //               ],
          //             );
          //           },
          //         );
          //
          //       },
          //       child: Column(
          //         children: [
          //           Container(
          //             width: 50,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: appPrincipalColor,
          //             ),
          //             child: Center(
          //               child: Image.asset(
          //                 "assets/gmail.png", // Utilisez le bon nom d'icône pour WhatsApp
          //                 width: 20,
          //                 height: 20,
          //                 color: appWhiteColor,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 10.0,
          //           ),
          //            Text(
          //             "gmail", // Changez le texte en "WhatsApp"
          //             style: TextStyle(
          //               color: appPrincipalColor,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      )),
    );
  }
}
