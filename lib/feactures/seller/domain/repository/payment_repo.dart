import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:omega_caisse/feactures/seller/data/model/payment_model.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/constants/api_path.dart';

final localStorageSecurity = LocalStorageSecurity();


class PaymentRepo {

  late Map<String, dynamic> paymentResponse;

  late PaymentModel paymentResponss;

  String token = SharedPreferencesService.getToken().toString();

  Future<PaymentModel> payedByWave({required String phone}) async {

try {

    var url = Uri.https(baseUrl, '/api/suscription/init/payment');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {
      'phone': phone,
      'payment_method': "wave-senegal"
    };

    Response response  = await http.post(url, body: jsonEncode(body), headers: headers);
   // print("************ENterrrrrr*************");
    //print(response.statusCode);

    //final response = await get(Uri.parse('$baseUrl/professions'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      PaymentModel paymentResponses = PaymentModel.fromJson(responseBody);


      return paymentResponss = paymentResponses;
    }
    else
      {
        return paymentResponss;
      }
  } catch (e) {
    return paymentResponss;
  }
  }


  Future<Map<String, dynamic>> payedByOrange({required String phone, required String ussdCode}) async {



    try {

      var url = Uri.https(baseUrl, '/api/suscription/init/payment');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> body = {
        'phone': phone,
        'ussd_code': ussdCode,
        'payment_method': "orange-money-senegal",
      };

      Response response  = await http.post(url, body: jsonEncode(body), headers: headers);

      //final response = await get(Uri.parse('$baseUrl/professions'));
      if (response.statusCode == 200) {


        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // print("*****responseBody******");
        // print(responseBody);
        // print("*****responseBody******");

        //PaymentModel paymentResponses = PaymentModel.fromJson(responseBody);

        Map<String, dynamic> paymentResponses = {
          'success': responseBody["success"],
          'message': responseBody["data"]["message"]
        };

        return paymentResponse = paymentResponses ;
      }
      else
      {
        Map<String, dynamic> paymentResponses = {
          'success': false,
          'message': "Une erreur s'est produite, Ressayez plus tard"
        };

        return paymentResponse = paymentResponses ;
      }
    } catch (e) {
      Map<String, dynamic> paymentResponses = {
        'success': false,
        'message': "Une erreur s'est produite, Ressayez plus tard"
      };
      return paymentResponse = paymentResponses ;
    }
  }

}
