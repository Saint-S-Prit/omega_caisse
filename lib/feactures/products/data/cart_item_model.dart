class CartItemModel {
  final String id;
  final String name;
  final int price;
  final String? unity;
  late num quantity;
   //late  num quantity; // Modifié le type de la propriété quantity
  final String path;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.unity,
    required this.quantity,
    required this.path,
  });

  // Méthode pour convertir un objet CartItem en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'unity': unity,
      'quantity': quantity,
      'path': path,
    };
  }

  // Méthode pour créer un objet CartItem à partir d'un JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      unity: json['unity'],
      quantity: json['quantity'],
      path: json['path'],
    );
  }
}
