import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/constants/api_path.dart';
import '../../data/product_model.dart';

final localStorageSecurity = LocalStorageSecurity();

List<ProductModel> productList = [];

class ProductRepository {
  String token = SharedPreferencesService.getToken().toString();
  Future<List<ProductModel>> getProductsByClient({required String id}) async {
    var url = Uri.https(baseUrl, '/api/user/$id/products');
    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.get(
      url,
      headers: headers,
    );
    //final response = await get(Uri.parse('$baseUrl/professions'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody['data'];
      final List<ProductModel> products =
          dataList.map((json) => ProductModel.fromJson(json)).toList();

      productList = products;
    }

    return productList;
  }


  Future<bool> updateProduct({required ProductModel productModel}) async {

    var url = Uri.https(baseUrl, '/api/products/${productModel.id.toString()}');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};

    var productJson = {
      "id": productModel.id,
      "name": productModel.name,
      "price": productModel.price,
      "path": productModel.path,
      "description": productModel.description,
    }; // Convertir productModel en JSON

    var response = await http.put(
      url,
      body: jsonEncode(productJson), // Envoyer le JSON dans le corps de la requête
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final bool responseMessage = responseBody['success'];
      return responseMessage;
    }

    return false;
  }

}
