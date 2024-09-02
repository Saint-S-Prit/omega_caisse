import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/constants/api_path.dart';
import '../storage/SharedPreferencesService.dart';

class SubscriptionService {

  Future<bool> checkAndUpdateSubscriptionStatus(BuildContext context) async {
    bool update = false;
    String? lastCheckDateStr = SharedPreferencesService.getLastCheckDate();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (lastCheckDateStr != null) {
      DateTime lastCheckDate = DateTime.parse(lastCheckDateStr);
      DateTime lastCheckDay = DateTime(lastCheckDate.year, lastCheckDate.month, lastCheckDate.day);

      // Si la date d'aujourd'hui est différente de la dernière date de vérification
      if (lastCheckDay != today) {
        print("---------------login---------------");
        await login(context);
        await SharedPreferencesService.setLastCheckDate(now.toIso8601String());
        update =  true;
      }
    } else {
      print("---------------login---------------");
      await login(context);
      await SharedPreferencesService.setLastCheckDate(now.toIso8601String());
      update =  true;
    }
    return update;

  }

  Future<void> login(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.https(baseUrl, '/api/login');

    Map<String, dynamic> body = {
      'phone': SharedPreferencesService.getPhoneNumber(),
      'password': SharedPreferencesService.getPassword()
    };

    http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

    print("response.statusCode");
    print(response.statusCode);
    print("response.statusCode");


    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final user = jsonResponse['data'];
      await SharedPreferencesService.setId(user['id'].toString());
      await SharedPreferencesService.setPassword(SharedPreferencesService.getPassword().toString());
      await SharedPreferencesService.setToken(user['token'].toString());
      await SharedPreferencesService.setPhoneNumber(user['phone'].toString());
      await SharedPreferencesService.setFullName(user['name'].toString());
      await SharedPreferencesService.setAddress(user['address'].toString());
      await SharedPreferencesService.setProfile(user['profile']['label'].toString());
      await SharedPreferencesService.setTeam(user['team']['label'].toString());
      await SharedPreferencesService.setCategory(user['category']['label'].toString());
      await SharedPreferencesService.setIsSubscribed(user['suscription']['is_subscribed'].toString());
      await SharedPreferencesService.setIsNotified(user['suscription']['is_notified'].toString());
      Navigator.of(context).pushNamed("/homeScreen");
    } else {
      Navigator.of(context).pushNamed("/loginScreen");
    }
  }
}
