import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/validation.dart';
import '../../data/model/history_model.dart';


List<HistoryModel> historyModelLists = [];

class HistoryRepository  {

  //String token = SharedPreferencesService.getToken().toString();



  Future<List<HistoryModel>?> getOrders({
    String? startDay,
    String? endDay,
    required  id,
    required  token,
  }) async {
    // Obtenez la date et l'heure actuelles
    DateTime now = DateTime.now();

    // Format de la date 'YYYY-MM-DD'
    String day = Validation.formatDateYYYMMdd(now);

    // Obtenez l'heure actuelle
    TimeOfDay currentTime = TimeOfDay.now();

    // Définissez l'heure de libération à 06:00 AM
    TimeOfDay releaseTime = const TimeOfDay(hour: 6, minute: 0);

    // Formatez les heures et les minutes pour assurer qu'elles ont toujours deux chiffres
    String formattedHour = currentTime.hour.toString().padLeft(2, '0');
    String formattedMinute = currentTime.minute.toString().padLeft(2, '0');

    // Définissez la date de fin à l'heure actuelle
    String endDate = "$day $formattedHour:$formattedMinute:59";

    // Déterminez la date de début en fonction de l'heure actuelle
    String startDate;
    if (currentTime.hour < releaseTime.hour) {
      // Si l'heure actuelle est avant 06:00 AM, utilisez le jour précédent
      DateTime previousDay = now.subtract(const Duration(days: 1));
      String previousDayFormatted = Validation.formatDateYYYMMdd(previousDay);
      startDate = "$previousDayFormatted ${releaseTime.hour.toString().padLeft(2, '0')}:${releaseTime.minute.toString().padLeft(2, '0')}:00";
    } else {
      // Sinon, utilisez la date d'aujourd'hui à 06:00 AM
      startDate = "$day ${releaseTime.hour.toString().padLeft(2, '0')}:${releaseTime.minute.toString().padLeft(2, '0')}:00";
    }

    // Remplacez les caractères spéciaux dans les dates par des tirets
    String formattedStartDate = startDate.replaceAll(RegExp(r'[^\w\s]'), '-');
    String formattedEndDate = endDate.replaceAll(RegExp(r'[^\w\s]'), '-');

    // Construisez l'URL avec les dates formatées
    var url = Uri.https(baseUrl, '/api/user/$id/orders/$formattedStartDate/$formattedEndDate');

    // Effectuez la requête HTTP GET
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Authorization": "Bearer $token",
      },
    );

    // Si la réponse est réussie (code 200)
    if (response.statusCode == 200) {
      // Décodez le corps de la réponse JSON
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Récupérez la liste des données
      final List<dynamic> dataList = responseBody['data'];

      // Convertissez chaque élément de la liste de données en HistoryModel
      final List<HistoryModel> historyModelList = dataList.map((json) => HistoryModel.fromJson(json)).toList();

      // Retournez la liste des modèles d'historique
      return historyModelList;
    } else {
      // Si la réponse n'est pas réussie, retournez null
      return null;
    }
  }



//   Future<List<HistoryModel>?> getOrders(
//     {
//       String? startDay,
//         String? endDay,
//       required id,
//       required token,
//       }) async {
//
//     var day = Validation.formatDateYYYMMdd(DateTime.now());
//     TimeOfDay now = TimeOfDay.now();
//
//     TimeOfDay releaseTime = const TimeOfDay(hour: 5, minute: 00);
//
//     var h = now.hour > 10 ? now.hour : "0${now.hour}";
//     var m = now.minute > 10 ? now.minute : "0${now.minute}";
//
//     var endDate = "$day $h:$m:59";
//
//     var startDate = '';
//     if (now.hour < 5) {
//       var day1 = Validation.formatDateYYYMMdd(DateTime.now().subtract(const Duration(days: 1)));
//       var h1 =
//       releaseTime.hour > 10 ? releaseTime.hour : "0${releaseTime.hour}";
//
//       startDate = "$day1 $h1:${releaseTime.minute}:59";
//     } else {
//       var h2 =
//       releaseTime.hour > 10 ? releaseTime.hour : "0${releaseTime.hour}";
//       startDate = "$day $h2:${releaseTime.minute}:59";
//     }
// // Remplacer les caractères spéciaux par des tirets (-)
//     String formattedStartDate = startDate.replaceAll(RegExp(r'[^\w\s]'), '-');
//     String formattedEndDate = endDate.replaceAll(RegExp(r'[^\w\s]'), '-');
//
// // Construire l'URL avec les dates formatées
//     var url = Uri.https(baseUrl, '/api/user/$id/orders/$formattedStartDate/$formattedEndDate');
//     var response = await http.get(
//       url,
//         headers: <String, String>{
//           "Content-Type": "application/json",
//           "X-Requested-With": "XMLHttpRequest",
//           "Authorization": "Bearer $token",
//         },
//     );
//
//
//
//     //print(response.statusCode);
//     if (response.statusCode == 200) {
//
//       final Map<String, dynamic> responseBody = jsonDecode(response.body);
//       final List<dynamic> dataList = responseBody['data'];
//       //print(dataList);
//
//       final List<HistoryModel> historyModelList =
//       dataList.map((json) => HistoryModel.fromJson(json)).toList();
//
//
//       //print("àààààààà");
//       //print(historyModelList.first.datetime.toString());
//
//       historyModelLists = historyModelList;
//
//     }
//
//     return historyModelLists;
//
//   }

}

//
// Future<List<OrderModel>> getOfflineOrders(
//     String _startDate, String _endDate) async {
//   DatabaseHelper helper = DatabaseHelper.instance;
//
//   List<OrderModel> orders = await helper.queryAllOrders();
//   orders = orders.where((OrderModel order) {
//     var date = DateTime.parse(order.date);
//
//     var startDay = DateTime.parse(_startDate);
//
//     var endDay = DateTime.parse(_endDate);
//     return date.isAfter(startDay) && date.isBefore(endDay);
//   }).toList();
//   if (orders == null) {
//     // print('read row ${orders.length}: empty');
//     return [];
//   } else {
//     // print('read row length: ${orders.length}');
//     return orders.isEmpty ? [] : orders;
//   }
// }

