import 'package:flutter/material.dart';

import '../../feactures/products/data/cart_item_model.dart';
import 'package:intl/intl.dart';

import '../../feactures/seller/data/model/history_model.dart';

class Functions {

  static String totalProductInCart(List<CartItemModel> cartItems) {
    double totalSum = 0.0;
    for (var item in cartItems) {
      totalSum += item.quantity;
    }
    return totalSum.toString();
  }

  static String totalPriceProductInCart(List<CartItemModel> cartItems) {
    double totalSumPrice = 0.0;
    for (var item in cartItems) {
      totalSumPrice += item.quantity * item.price;
    }
    return totalSumPrice.toString();
  }


  static String getTodayRange() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 5, 0); // Aujourd'hui à 5h00
    return startOfDay.toString();
  }

  static String getWeekRange() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday)); // Premier jour de la semaine (lundi)
    final startOfWeekAt5 = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 5, 0); // Lundi à 5h00

    return startOfWeekAt5.toString();
  }

  static String getWeekRangeWithoutHour() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday)); // Premier jour de la semaine (lundi)
    final startOfWeekDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day); // Lundi sans heure
    final formattedDate = DateFormat('dd/MM/yyyy').format(startOfWeekDate); // Formater la date
    return formattedDate;
  }

  static String getMonthRange() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1, 5, 0); // Premier jour du mois à 5h00
    return startOfMonth.toString();
  }

  static String getMonthRangeGetMonthName() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1); // Premier jour du mois sans heure
    final monthName = _getMonthName(startOfMonth.month); // Obtenir le nom du mois
    return monthName;
  }


  static String getTodayDateWithoutHour() {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day); // Today's date without time
    final formattedTodayDate = DateFormat('dd/MM/yyyy').format(todayDate); // Format the date
    return formattedTodayDate;
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janvier';
      case 2:
        return 'Février';
      case 3:
        return 'Mars';
      case 4:
        return 'Avril';
      case 5:
        return 'Mai';
      case 6:
        return 'Juin';
      case 7:
        return 'Juillet';
      case 8:
        return 'Août';
      case 9:
        return 'Septembre';
      case 10:
        return 'Octobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Décembre';
      default:
        return 'Invalid month';
    }
  }


  static String formatDateTimeRange(DateTimeRange range) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    final startStr = formatter.format(range.start);
    final endStr = formatter.format(range.end);
    return '$startStr - $endStr';
  }

  // calculer la somme des soldes
  static int calculateTotalBalance(List<HistoryModel> supervisorList) {
    return supervisorList.fold(0, (sum, supervisor) => sum + supervisor.amount);
  }
}