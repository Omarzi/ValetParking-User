class UpdatePasswordModel {
  String? status;
  User? user;
  String? token;

  UpdatePasswordModel({this.status, this.user, this.token});

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? userId;
  String? username;
  String? email;
  String? phone;
  String? carName;
  String? carNumber;
  String? createdAt;
  String? updatedAt;

  User(
      {this.userId,
        this.username,
        this.email,
        this.phone,
        this.carName,
        this.carNumber,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    carName = json['carName'];
    carNumber = json['carNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['carName'] = this.carName;
    data['carNumber'] = this.carNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
