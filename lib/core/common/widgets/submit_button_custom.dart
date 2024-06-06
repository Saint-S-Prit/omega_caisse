import 'package:flutter/material.dart';

import '../../../feactures/products/services/cardService.dart';
import '../../utils/styles/color.dart';


final CartService cartService = CartService();

class SubmitButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String textSubmit;
  final bool isLoading;

  const SubmitButtonCustom({
    Key? key,
    required this.onPressed,
    required this.textSubmit,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrincipalColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Ajustez le rayon de bordure ici
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(appPrincipalColor),
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
                width: isLoading
                    ? 10
                    : 0), // Ajoute un espace entre le loader et le texte
            Text(
              textSubmit,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
