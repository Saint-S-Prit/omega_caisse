class PaymentModel {
  late bool success;
  late PaymentData? data;
  late String message;

  PaymentModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      success: json['success'],
      data: json['data'] != null ? PaymentData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class PaymentData {
  late bool success;
  late String message;
  late String url;

  PaymentData({
    required this.success,
    required this.message,
    required this.url,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      success: json['success'],
      message: json['message'],
      url: json['url'],
    );
  }
}
