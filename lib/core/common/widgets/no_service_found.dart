import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/styles/color.dart';

class NoServiceFound extends StatelessWidget {


  final String title;
  final String description;

  const NoServiceFound({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
// Votre image ici
        Lottie.asset('assets/animations/notFound.json', width: 150),
        //Image.asset('assets/not-found-unscreen.gif', width: 150), // Remplacez par le chemin de votre image

// Texte à afficher si la liste est vide
         Text(
          title,
          style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appPrincipalColor),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 10,),
        ),
      ],
    );
  }
}



