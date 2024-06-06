class SupervisorModel {
  final int id;
  final int profileId;
  final int teamId;
  final int categoryId;
  final String name;
  final String phone;
  final String address;
  final String email;
  final int balance;

  SupervisorModel({
    required this.id,
    required this.profileId,
    required this.teamId,
    required this.categoryId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.balance,
  });

  factory SupervisorModel.fromJson(Map<String, dynamic> json) {
    return SupervisorModel(
      id: json['id'] as int,
      profileId: json['profile_id'],
      teamId: json['team_id'],
      categoryId: json['category_id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      balance: json['balance'],
    );
  }
}
