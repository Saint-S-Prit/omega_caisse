import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/validation.dart';
import '../../data/model/history_model.dart';


List<HistoryModel> historyModelLists = [];

class HistoryRepository  {

  //String token = SharedPreferencesService.getToken().toString();



  Future<List<HistoryModel>?> getOrders(
    {
      String? startDay,
        String? endDay,
      required id,
      required token,
      }) async {

    var day = Validation.formatDateYYYMMdd(DateTime.now());
    TimeOfDay now = TimeOfDay.now();

    TimeOfDay releaseTime = const TimeOfDay(hour: 4, minute: 59);

    var h = now.hour > 10 ? now.hour : "0${now.hour}";
    var m = now.minute > 10 ? now.minute : "0${now.minute}";

    var endDate = "$day $h:$m:59";

    var startDate = '';
    if (now.hour < 4) {
      var day1 = Validation.formatDateYYYMMdd(DateTime.now().subtract(const Duration(days: 1)));
      var h1 =
      releaseTime.hour > 10 ? releaseTime.hour : "0${releaseTime.hour}";

      startDate = "$day1 $h1:${releaseTime.minute}:59";
    } else {
      var h2 =
      releaseTime.hour > 10 ? releaseTime.hour : "0${releaseTime.hour}";
      startDate = "$day $h2:${releaseTime.minute}:59";
    }
// Remplacer les caractères spéciaux par des tirets (-)
    String formattedStartDate = startDate.replaceAll(RegExp(r'[^\w\s]'), '-');
    String formattedEndDate = endDate.replaceAll(RegExp(r'[^\w\s]'), '-');

// Construire l'URL avec les dates formatées
    var url = Uri.https(baseUrl, '/api/user/$id/orders/$formattedStartDate/$formattedEndDate');
    var response = await http.get(
      url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest",
          "Authorization": "Bearer $token",
        },
    );

    // http.Response response = await http.get(
    //   Uri.parse('$baseUrl/api/user/$id/orders/$startDate/$endDate'),
    //   headers: <String, String>{
    //     "Content-Type": "application/json",
    //     "X-Requested-With": "XMLHttpRequest",
    //     "Authorization": "Bearer $token",
    //   },
    // );


    //print(response.statusCode);
    if (response.statusCode == 200) {

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody['data'];
      //print(dataList);

      final List<HistoryModel> historyModelList =
      dataList.map((json) => HistoryModel.fromJson(json)).toList();


      //print("àààààààà");
      //print(historyModelList.first.datetime.toString());

      historyModelLists = historyModelList;

    }

    return historyModelLists;

  }

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

