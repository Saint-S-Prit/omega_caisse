class SaveAvisForAppModel {
  UserApp? userApp;
  int? rating;
  String? role;
  String? comment;

  SaveAvisForAppModel({this.userApp, this.rating, this.role, this.comment});

  SaveAvisForAppModel.fromJson(Map<String, dynamic> json) {
    userApp =
    json['userApp'] != null ?  UserApp.fromJson(json['userApp']) : null;
    rating = json['rating'];
    role = json['role'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userApp != null) {
      data['userApp'] = userApp!.toJson();
    }
    data['rating'] = rating;
    data['role'] = role;
    data['comment'] = comment;
    return data;
  }
}

class UserApp {
  int? id;

  UserApp({this.id});

  UserApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    return data;
  }
}