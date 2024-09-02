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
    // Vérifiez si les produits sont déjà enregistrés dans le stockage local
    List<ProductModel>? cachedProducts = SharedPreferencesService.getProducts();
    if (cachedProducts != null && cachedProducts.isNotEmpty) {
      return cachedProducts;
    }

    // Si non, faites un appel réseau pour les obtenir
    var url = Uri.https(baseUrl, '/api/user/$id/products');
    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.get(
      url,
      headers: headers,
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody['data'];
      final List<ProductModel> products = dataList.map((json) => ProductModel.fromJson(json)).toList();

      // Sauvegardez les produits dans le stockage local
      await SharedPreferencesService.setProducts(products);

      return products;
    }

    // En cas d'erreur, renvoyez une liste vide ou gérez l'erreur comme nécessaire
    return [];
  }




  Future<bool> updateProduct({required ProductModel productModel}) async {
    var url = Uri.https(baseUrl, '/api/products/${productModel.id}');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var productJson = {
      "id": productModel.id,
      "name": productModel.name,
      "price": productModel.price,
      "path": productModel.path,
      "description": productModel.description,
    };

    var response = await http.put(
      url,
      body: jsonEncode(productJson),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        // Update the product in local storage
        List<ProductModel> products = SharedPreferencesService.getProducts() ?? [];
        int index = products.indexWhere((p) => p.id == productModel.id);
        if (index != -1) {
          products[index].name = productModel.name;
          products[index].price = productModel.price;
          await SharedPreferencesService.setProducts(products);
        }
        return true;
      }
    }

    return false;
  }

}
