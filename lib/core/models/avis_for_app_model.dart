class AvisForAppModel {
  int? id;
  UserApp? userApp;
  String? role;
  int? rating;
  String? comment;
  String? updatedAt;
  String? isPublish;

  AvisForAppModel(
      {this.id,
        this.userApp,
        this.role,
        this.rating,
        this.comment,
        this.updatedAt,});

  AvisForAppModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userApp =
    json['userApp'] != null ?  UserApp.fromJson(json['userApp']) : null;
    role = json['role'];
    rating = json['rating'];
    comment = json['comment'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (userApp != null) {
      data['userApp'] = userApp!.toJson();
    }
    data['role'] = role;
    data['rating'] = rating;
    data['comment'] = comment;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserApp {
  int? id;
  String? fullName;
  String? phoneNumber;
  String? password;
  String? role;

  UserApp({this.id, this.fullName,this.phoneNumber, this.password, this.role});

  UserApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}