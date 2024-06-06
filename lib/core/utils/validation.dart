import 'package:intl/intl.dart';

class Validation {
  // validation numero telephone senegal
  static final phoneRegExp = RegExp(r'^(7[05-8])[0-9]{7}$');

  // Limitation du nombre de caractères entre min et max
  static RegExp lengthRegExp(int min, int max) {
    return RegExp('^.{${min.toString()},${max.toString()}}\$');
  }


  // Vérifier si la valeur ne contient que des chiffres et exactement 4 chiffres
  static final RegExp digitsOnly = RegExp(r'^[0-9]{4}$');

  // Fonction pour extraire l'heure de la date
  static String getHour(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);

      // Formater les heures en ajoutant un zéro si nécessaire
      final String formattedHour =
      dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();

      // Formater les minutes en ajoutant un zéro si nécessaire
      final String formattedMinute =
      dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();

      // Formater les secondes en ajoutant un zéro si nécessaire
      final String formattedSecond =
      dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second.toString();

      // Concaténer le tout pour former l'heure finale
      final String formattedTime = '$formattedHour:$formattedMinute:$formattedSecond';

      return formattedTime;
    } catch (e) {
      print("Erreur lors de l'extraction de l'heure : $e");
      return ''; // Ou une valeur par défaut selon vos besoins
    }
  }

  // Fonction pour extraire la date de la date
  static String getDate(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);

      // Formater le jour en ajoutant un zéro si nécessaire
      final String formattedDay = dateTime.day < 10
          ? '0${dateTime.day}'
          : dateTime.day.toString();

      // Formater le mois en utilisant le nom du mois
      final List<String> months = [
        'Janvier', 'Février', 'Mars', 'Avril',
        'Mai', 'Juin', 'Juillet', 'Août',
        'Septembre', 'Octobre', 'Novembre', 'Décembre'
      ];
      final String formattedMonth = months[dateTime.month - 1];

      // Formater l'année
      final String formattedYear = dateTime.year.toString();

      // Concaténer le tout pour former la date finale
      final String formattedDate = '$formattedDay $formattedMonth $formattedYear';

      return formattedDate;
    } catch (e) {
      print("Erreur lors de l'extraction de la date : $e");
      return ''; // Ou une valeur par défaut selon vos besoins
    }
  }


// Affiche la différence de temps sous forme lisible
  static String formatTimeDifference(String createdAt) {
    DateTime commentDate = DateTime.parse(createdAt);
    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(commentDate);

    if (difference.inSeconds < 60) {
      return "Maintenant";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} h";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} jours";
    } else if (difference.inDays < 365) {
      return DateFormat('dd MMM').format(commentDate);
    } else {
      // Si la différence est supérieure à un an, on affiche la date sous la forme "jour mois année"
      return DateFormat('dd MMM yyyy').format(commentDate);
    }
  }



  static String formatDateYYYMMdd(DateTime date) {
    final format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }


  static String formatBalance(num number) {
    final NumberFormat numberFormat = NumberFormat("#,###", "en_US");
    return numberFormat.format(number).replaceAll(",", " ");
  }


  static String formatPrice(double price) {
    if (price == price.toInt()) {
      return price.toInt().toString();
    } else {
      return price.toStringAsFixed(2);
    }
  }
}
