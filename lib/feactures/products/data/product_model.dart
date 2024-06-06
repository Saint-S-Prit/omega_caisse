class ProductModel {
  late int id;
  late String name;
  late int price;
  late String path;
  late String? description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.path,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      path: json['path'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Product ID: $id, Name: $name, Price: $price, Path: $path, Description: $description';
  }
}
