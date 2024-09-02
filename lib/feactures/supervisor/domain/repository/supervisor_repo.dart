import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/validation.dart';
import '../../../seller/data/model/history_model.dart';
import '../../data/supervisor_model.dart';

final localStorageSecurity = LocalStorageSecurity();

List<SupervisorModel> supervisorTeamList = [];
List<HistoryModel> supervisorGetHistoryTeamList = [];

class SupervisorRepository {
  String token = SharedPreferencesService.getToken().toString();


  Future<List<SupervisorModel>> getSupervisorTeamList() async {
    var url = Uri.https(baseUrl, '/api/team/users');
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(
      url,
      headers: headers,
    );

    //print(url);
    //final response = await get(Uri.parse('$baseUrl/professions'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody['data'];

      final List<SupervisorModel> teamLists =
          dataList.map((json) => SupervisorModel.fromJson(json)).toList();


      supervisorTeamList = teamLists;
    }

    return supervisorTeamList;
  }



  Future<List<HistoryModel>?> getOrdersItemTeam({
        String? startDay,
        String? endDay,
        required id,
        required token,
      }) async {

    String formattedStartDate;
    String formattedEndDate;

    if ((startDay == null || startDay.isEmpty) && (endDay == null || endDay.isEmpty)) {
      var day = Validation.formatDateYYYMMdd(DateTime.now());
      TimeOfDay now = TimeOfDay.now();
      TimeOfDay releaseTime = const TimeOfDay(hour: 6, minute: 00);

      var h = now.hour.toString().padLeft(2, '0');
      var m = now.minute.toString().padLeft(2, '0');

      var endDate = "$day $h:$m:59";
      var startDate = '';
      if (now.hour < 6) {
        var day1 = Validation.formatDateYYYMMdd(DateTime.now().subtract(const Duration(days: 1)));
        var h1 = releaseTime.hour.toString().padLeft(2, '0');
        startDate = "$day1 $h1:${releaseTime.minute.toString().padLeft(2, '0')}:00";
      } else {
        var h2 = releaseTime.hour.toString().padLeft(2, '0');
        startDate = "$day $h2:${releaseTime.minute.toString().padLeft(2, '0')}:00";
      }

      formattedStartDate = startDate.replaceAll(' ', '-');
      formattedEndDate = endDate.replaceAll(' ', '-');
    } else {
      formattedStartDate = startDay!.replaceAll(' ', '-');
      formattedEndDate = endDay!.replaceAll(' ', '-');
    }


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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody['data'];
      final List<HistoryModel> historyModelList =
       dataList.map((json) => HistoryModel.fromJson(json)).toList();
      supervisorGetHistoryTeamList = historyModelList;

    }
    return supervisorGetHistoryTeamList;

  }

}
