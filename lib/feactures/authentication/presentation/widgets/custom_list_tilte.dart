import 'package:flutter/material.dart';

import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';

class CustomListTitle extends StatelessWidget {
  final String text;
  final Color iconColor; // Couleur personnalisée pour les icônes
  final IconData leadingIcon; // Icône pour leading
  final IconData? trailingIcon; // Icône pour trailing (optionnel)
  final VoidCallback? onTap; // Fonction de rappel optionnelle pour la navigation
  final Navigator? trailing; // Fonction de rappel optionnelle pour la navigation
  final Color? containerColor; // Couleur optionnelle du conteneur

  const CustomListTitle({
    super.key,
    required this.text,
    this.iconColor = Colors.red,
    required this.leadingIcon, // Icône requise pour leading
    this.trailingIcon, // Icône optionnelle pour trailing
    this.onTap,
    this.trailing, // Fonction de rappel optionnelle pour la navigation
    this.containerColor, // Couleur optionnelle du conteneur
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      child: Container(
        //decoration: TextStyles.boxDecorationCustomer,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10.0), // Rayon de bordure
        ),

        child: ListTile(
          leading: Icon(leadingIcon, color: appPrincipalColor),
          title: Text(text),
          trailing: trailingIcon != null ? Icon(trailingIcon, color: appPrincipalColor) : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
