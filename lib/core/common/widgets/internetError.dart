import 'package:flutter/material.dart';

import '../../utils/styles/color.dart';

class InternetError extends StatelessWidget {

  final VoidCallback onPressed;

  const InternetError({
    Key? key,
    required this.onPressed
  }) : super(key: key);

  //final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return
      Center(
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
                style: TextStyle(
                    fontSize: 14, color: Colors.grey[800]),
          //style: MyTextStyle.text16_w400_normal_body,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
// Action à effectuer lors du clic sur le bouton Retry
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color:
                          appPrincipalColor), // Bordure autour du bouton
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                      12.0), // Ajouter un Padding autour du texte
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Text(
                      'Reesseyer',
                      style: TextStyle(color: appPrincipalColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

}




