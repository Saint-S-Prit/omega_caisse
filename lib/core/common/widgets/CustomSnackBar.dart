import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      BuildContext context,
      String text,
      Color backgroundColor, {
        bool center = false, // Paramètre par défaut pour afficher en bas
      }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    // Ajouter l'OverlayEntry
    overlay?.insert(overlayEntry);

    // Retirer l'OverlayEntry après une certaine durée
    center ?
    Future.delayed(const Duration(seconds: 5), () {
      overlayEntry.remove();
    }) :
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
