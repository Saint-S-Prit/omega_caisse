import 'package:intl/intl.dart';

class Format {
  static String formatDateString(String dateString) {
    DateTime? dateTime = DateTime.tryParse(dateString);
    if (dateTime != null) {
      return formatDate(dateTime);
    } else {
      return "Date invalide";
    }
  }

  static String formatDate(DateTime dateTime) {
    // Utilisez le formateur pour obtenir la date formatée
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatSomme(int somme) {
    return NumberFormat('#,##0', 'fr').format(somme);
  }


  static String formatDate2(DateTime date) {
    final format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }
}
