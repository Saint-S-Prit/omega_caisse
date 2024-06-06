import 'package:flutter/material.dart';
import 'color.dart';

class TextStyles {
  final String? labelText;
  final Color? myColor;

  TextStyles({
    this.labelText,
    this.myColor
  });

  // static BoxDecoration boxDecorationCustomer(BuildContext context) {
  //   final Brightness brightness = Theme.of(context).brightness;
  //   return BoxDecoration(
  //     color: brightness == Brightness.light
  //         ? Colors.white // Couleur pour le thème clair
  //         : appSecondColor, // Couleur pour le thème sombre
  //     borderRadius: BorderRadius.circular(10.0), // Coins arrondis
  //   );
  // }

  static BoxDecoration boxDecorationCustomer(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return BoxDecoration(
      color: brightness == Brightness.light
          ? Colors.white // Couleur pour le thème clair
          : Colors.red, // Couleur pour le thème sombre
      borderRadius: BorderRadius.circular(10.0), // Coins arrondis
      border: Border.all(color: Colors.grey.withOpacity(0.3)), // Bordure grise
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1), // Couleur de l'ombre
          spreadRadius: 1, // Distance de dispersion de l'ombre
          blurRadius: 1, // Flou de l'ombre
          offset: const Offset(0, 1), // Position de l'ombre (horizontal, vertical)
        ),
      ],
    );
  }


  static BoxDecoration customBoxDecoration(BuildContext context){
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Couleur de l'ombre
          spreadRadius: 1, // Rayon de dispersion de l'ombre
          blurRadius: 1, // Flou de l'ombre
          offset: const Offset(0, 1), // Décalage de l'ombre (horizontal, vertical)
        ),
      ],
    );
  }
  OutlineInputBorder get outlineInputBorder {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: myColor ?? appPrincipalColor,
        width: 0.1,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
