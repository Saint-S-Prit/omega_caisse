import 'dart:convert';


class OrderModel {
  int? id;
  int? userId;
  String? name;
  int? amount;
  Detail? detail;
  String? description;
  String? datetime;

  OrderModel(
      {this.id,
        this.userId,
        this.name,
        this.amount,
        this.detail,
        this.description,
        this.datetime});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    amount = json['amount'];
    detail =
    json['detail'] != null ? Detail.fromJson(json['detail']) : null; // Change here
    description = json['description'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['amount'] = amount;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    data['description'] = description;
    data['datetime'] = datetime;
    return data;
  }
}

class Detail {
  String? nom;
  int? prix;
  int? quantity;

  Detail({this.nom, this.prix, this.quantity});

  Detail.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prix = json['prix'];
    quantity = json['quantity']; // Change here
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = nom;
    data['prix'] = prix;
    data['quantity'] = quantity; // Change here
    return data;
  }
}

