class UserResponse {
  late bool success;
  late UserData? data;
  late String message;

  UserResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class UserData {
  late String token;
  late int id;
  late String phone;
  late String address;
  late String name;
  late int profileId;
  late int teamId;
  late int categoryId;
  late int subscription;

  UserData({
    required this.token,
    required this.id,
    required this.phone,
    required this.address,
    required this.name,
    required this.profileId,
    required this.teamId,
    required this.categoryId,
    required this.subscription,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'],
      id: json['id'],
      phone: json['phone'],
      address: json['address'],
      name: json['name'],
      profileId: json['profile_id'],
      teamId: json['team_id'],
      categoryId: json['category_id'],
      subscription: json['subscription'],
    );
  }
}
