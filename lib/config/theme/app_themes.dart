import 'package:flutter/material.dart';
import '../../core/utils/styles/color.dart';


TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    bodyLarge: const TextStyle(
      //fontFamily: 'Montserrat',
      fontFamily: 'Inter',
      //fontWeight: FontWeight.bold,
      fontSize: 16.0,
      // Autres styles de texte pour le corps du texte
    ),
    // Tu peux ajouter d'autres styles de texte ici si nécessaire
  );
}

ThemeData lightTheme = ThemeData(
  fontFamily: "Inter",
  textTheme: _buildTextTheme(ThemeData.light().textTheme),
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme:   AppBarTheme(
    backgroundColor: appPrincipalColor, // Couleur de l'AppBar en bleu
  ),
);


ThemeData darkTheme = ThemeData(
  textTheme: _buildTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
    colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: appPrincipalColor, // Couleur de l'AppBar en bleu
  ),
);




const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  outline: Color(0xFF79747E),
  //background: Color(0xFFFFFBFE),
  //background: Color(0xFFF5F5F5),
  background: Color(0xFFf3f2f7),
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceVariant: Color(0xFFE7E0EC),
  onSurfaceVariant: Color(0xFF49454F),
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF6750A4),
  outlineVariant: Color(0xFFCAC4D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFD0BCFF),
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  outline: Color(0xFF938F99),
  //background: Color(0xFF1C1B1F),
  background: Color(0xFF010101),
  //background: appBackgroundColor,
  onBackground: Color(0xFFE6E1E5),
  surface: Color(0xFF1C1B1F),
  onSurface: Color(0xFFE6E1E5),
  surfaceVariant: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF6750A4),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFD0BCFF),
  outlineVariant: Color(0xFF49454F),
  scrim: Color(0xFF000000),
);
