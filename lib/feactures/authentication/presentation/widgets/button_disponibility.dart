import 'package:flutter/material.dart';

 class ButtonAvailable extends StatelessWidget {
  final Color color;
  final VoidCallback onPress;

  const ButtonAvailable({super.key, required this.color, required this.onPress});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), backgroundColor: color,
        padding: EdgeInsets.zero, // Supprimer le padding par défaut du bouton
      ),
      child: const SizedBox(
        width: 50, // Définir une largeur pour limiter la taille du bouton
        height: 50, // Définir une hauteur pour obtenir un bouton circulaire
        child: Center(
          child: Icon(
            Icons.power_settings_new,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
