class HistoryModel{
  final int id;
  final int userId;
  final String name;
  final int amount;
  final dynamic detail; // Le type peut être ajusté en fonction de la structure attendue
  final String description;
  final String datetime;
  HistoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.amount,
    required this.detail,
    required this.description,
    required this.datetime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      amount: json['amount'],
      detail: json['detail'],
      description: json['description'],
      datetime: json['datetime'],
    );
  }
}
