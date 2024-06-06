import 'package:flutter/material.dart';

import '../../utils/styles/color.dart';

class TextAreaCustomer extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final Function? validator;
  final String? initialValue;
  final int? maxLength;
  final Function(String)? onChanged; // Ajout du paramètre onChanged

  const TextAreaCustomer({
    Key? key,
    this.controller,
    this.initialValue,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.onChanged,
      this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                //labelStyle: TextStyle(color: Colors.yellow),
                errorStyle: const TextStyle( // Style du texte d'erreur
                  color: appColorError, // Couleur du texte d'erreur
                ),
                //hintStyle: const TextStyle(color: Colors.grey),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appColorError, width: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: appColorError,width: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: appPrincipalColor, width: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: appPrincipalColor,width: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              ),
              onChanged: onChanged, // Appel de la fonction onChanged
              validator: (value) {
                final errorMessage = validator!(value);
                if (errorMessage != null) {
                  // Enregistrez l'erreur dans le stateProvider approprié ici si nécessaire
                }
                return errorMessage;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }
}
