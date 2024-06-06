import 'package:flutter/material.dart';

class SnackBarCustomer extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const SnackBarCustomer({
    Key? key,
    required this.message,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(); // Ce widget ne rend rien directement.
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(
          message,
          style: TextStyle(color: textColor ?? Theme.of(context).snackBarTheme.actionTextColor),
        ),
        duration: const Duration(milliseconds: 1500),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
