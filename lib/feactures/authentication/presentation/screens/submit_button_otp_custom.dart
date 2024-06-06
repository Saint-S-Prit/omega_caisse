import 'package:flutter/material.dart';

import '../../../../core/utils/styles/color.dart';

class SubmitButtonOtpCustomer extends StatelessWidget {
  final VoidCallback onPressed;
  final String textSubmit;

  const SubmitButtonOtpCustomer(
      {
        super.key,
        required this.onPressed,
        required this.textSubmit,
      }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: appPrincipalColor, // Définissez la couleur du fond
        ),
        child: Text(textSubmit, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
      ),
    );
  }
}
