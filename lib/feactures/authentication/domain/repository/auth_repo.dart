import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../../../core/utils/format.dart';



class AuthenticationRepository {

  String token = SharedPreferencesService.getToken().toString();

  Future<String?> login(String phoneNumber, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.https(baseUrl, '/api/login');

      Map<String, dynamic> body = {
        'phone': phoneNumber,
        'password': password
      };

      http.Response response  = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {

        final jsonResponse = jsonDecode(response.body);



        // Décoder les données utilisateur
        //final user = UserResponse.fromJson(jsonResponse);
        final user = jsonResponse['data'];

        await SharedPreferencesService.setId(user['id'].toString());
        await SharedPreferencesService.setPassword(password);
        await SharedPreferencesService.setToken(user['token'].toString());
        await SharedPreferencesService.setPhoneNumber(user['phone'].toString());
        await SharedPreferencesService.setFullName(user['name'].toString());
        await SharedPreferencesService.setAddress(user['address'].toString());
        await SharedPreferencesService.setProfile(user['profile']['label'].toString());
        await SharedPreferencesService.setTeam(user['team']['label'].toString());
        await SharedPreferencesService.setCategory(user['category']['label'].toString());
        await SharedPreferencesService.setIsSubscribed(user['suscription']['is_subscribed'].toString());
        await SharedPreferencesService.setIsNotified(user['suscription']['is_notified'].toString());
        return "200";
      }
      else {
        return "400";
      }
    } catch (e) {
      return "500";
    }
  }


  Future<String?> logout() async {
    try {
      var url = Uri.https(baseUrl, '/api/logout');
      http.Response response  = await http.post(
          url,
          body: [],
          headers: <String, String>{
            "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Authorization": "Bearer $token",
      }
      );

      if (response.statusCode == 200) {
        return "200";
      }
      else {
        return "400";
      }
    } catch (e) {
      return "500";
    }
  }

  Future<String?> verifyIfNumberExist(String phoneNumber) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.https(baseUrl, '/users/$phoneNumber/phone');
      http.Response response  = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return "200";
      } else if(response.statusCode == 404){
        return "404";
      }
    } catch (e) {
      return "500";
    }
  }

  Future<String?> register(String fullName,String phoneNumber, String password, String role) async {
        try {
          var headers = {'Content-Type': 'application/json'};
          var url = Uri.https(baseUrl, '/auth/register');

          Map<String, dynamic> body = {
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'password': password,
            'role': role
          };
          http.Response response  = await http.post(url, body: jsonEncode(body), headers: headers);

          //print(response.reasonPhrase);
          if (response.statusCode == 200) {
            //print("valid 🥴: Felicitation");
            return "200";
          } else if(response.statusCode == 404){
            //print("Forbidden 🥴: Ce numero de telephone existe déjà");
            return "404";
          }
          else if(response.statusCode == 500){
            //print("Internal Server Error 🥴: ${response.reasonPhrase.toString()}");
            return "500";
          }
        } catch (e) {
          //print('Internal Server Error 😵: $e');
          return "500";
        }
  }

  Future<String> changePassword({
    required Map<String, dynamic> variableMap,
  }) async {
    String token = SharedPreferencesService.getToken().toString();
    String id = SharedPreferencesService.getId().toString();
    var uri = Uri.https(baseUrl, "api/user/$id/reset/password");
    //var token = await localStorageSecurity.getToken(); // Remplacez cela par la façon dont vous obtenez le jeton
    var response = await http.post(
      uri,
      body: jsonEncode(variableMap), // Convertir l'objet en JSON
      headers: {
        'Content-Type': 'application/json', // Spécifier le type de contenu JSON
        'Authorization': 'Bearer $token', // Ajouter le jeton à l'en-tête Authorization
      },
    );

    if (response.statusCode == 200) {
      //print("Données insérées vers l'API (USER MODIFIER)");
        return "valide";
    } else {
      Map<String, dynamic> responseBody = json.decode(response.body);
      //print('Échec de la requête : ${responseBody['message']}');
      return  responseBody['message'];
    }
  }
  Future<String> getBalanceClient({
    required int id,
    String? startDay,
    String? endDay,
  }) async {
    if (startDay != null && endDay != null) {
      // Si des dates de début et de fin sont fournies, utilisez-les pour construire l'URL
      var url = Uri.https(baseUrl, '/api/user/$id/balance/$startDay/$endDay');
      var headers = {'Authorization': 'Bearer $token'};
      var response = await http.get(url, headers: headers);
      var body = jsonDecode(response.body);
      return body['balance'];
    } else {
      // Obtenez la date actuelle au format YYYY-MM-DD
      var day = Format.formatDate2(DateTime.now());
      TimeOfDay now = TimeOfDay.now();
      TimeOfDay releaseTime = const TimeOfDay(hour: 6, minute: 0);

      // Définissez endDate à l'heure actuelle plus une minute
      var endDate = "$day ${now.hour}:${now.minute + 1}";

      var startDate = '';

      // Si l'heure actuelle est avant 6 heures du matin, utilisez la date d'hier à 6 heures du matin
      if (now.hour < 6) {
        var day1 = Format.formatDate2(DateTime.now().subtract(const Duration(days: 1)));
        startDate = "$day1 ${releaseTime.hour}:${releaseTime.minute}";
      } else {
        // Sinon, utilisez la date d'aujourd'hui à 6 heures du matin
        startDate = "$day ${releaseTime.hour}:${releaseTime.minute}";
      }

      // Construisez l'URL en utilisant startDate et endDate
      var url = Uri.https(baseUrl, '/api/user/$id/balance/$startDate/$endDate');
      var headers = {'Authorization': 'Bearer $token'};
      var response = await http.get(url, headers: headers);
      var body = jsonDecode(response.body);

      // Retournez le solde
      return body['balance'].toString();
    }
  }

}
