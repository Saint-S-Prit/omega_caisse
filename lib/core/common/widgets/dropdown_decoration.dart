
import 'package:flutter/material.dart';

import '../../utils/styles/typo.dart';

InputDecoration dropdownDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red), // Bordure en cas d'erreur
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red), // Bordure en cas d'erreur avec le focus
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.yellow), // Bordure par défaut
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.orange), // Bordure lors du focus
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
  );
}
