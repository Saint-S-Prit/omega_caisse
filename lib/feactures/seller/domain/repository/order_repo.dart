import 'dart:convert';

import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/constants/api_path.dart';
import 'package:http/http.dart' as http;


class OrderRepository {
  String token = SharedPreferencesService.getToken().toString();
  String id = SharedPreferencesService.getId().toString();


  Future<String> createOrder({
    required Map<String, dynamic> variableMap,
  }) async {


    var uri = Uri.https(baseUrl, "/api/orders");
    //print(uri);
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
      //print("valide");
      return "valide";
    } else {
      Map<String, dynamic> responseBody = json.decode(response.body);
      //print('Échec de la requête : ${responseBody['message']}');
      //print("message");
      return  responseBody['message'];
    }
  }

}