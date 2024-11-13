class UserDataModel {
  String? message;
  UserData? userData;
  String? token;

  UserDataModel({this.message, this.userData, this.token});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}

class UserData {
  String? userId;
  String? username;
  String? email;
  String? phone;
  String? profileImage;
  String? carName;
  String? carNumber;
  String? carImage;
  String? role;
  List<Saved>? saved;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.role,
        this.profileImage,
        this.carImage,
        this.userId,
        this.phone,
        this.username,
        this.email,
        this.carName,
        this.carNumber,
        this.saved,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    userId = json['userId'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    carImage = json['carImage'];
    username = json['username'];
    email = json['email'];
    carName = json['carName'];
    carNumber = json['carNumber'];
    if (json['saved'] != null) {
      saved = <Saved>[];
      json['saved'].forEach((v) {
        saved!.add(new Saved.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['carImage'] = this.carImage;
    data['phone'] = this.phone;
    data['profileImage'] = this.profileImage;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['carName'] = this.carName;
    data['carNumber'] = this.carNumber;
    if (this.saved != null) {
      data['saved'] = this.saved!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Saved {
  String? sId;
  String? gragename;
  String? grageDescription;
  String? grageImages;
  int? gragePricePerHoure;
  double? lat;
  double? lng;
  String? openDate;
  String? endDate;
  bool? active;
  List<String>? driver;
  List<String>? subOwner;
  String? createdAt;
  String? updatedAt;

  Saved(
      {this.sId,
        this.gragename,
        this.grageDescription,
        this.grageImages,
        this.gragePricePerHoure,
        this.lat,
        this.lng,
        this.openDate,
        this.endDate,
        this.active,
        this.driver,
        this.subOwner,
        this.createdAt,
        this.updatedAt});

  Saved.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gragename = json['gragename'];
    grageDescription = json['grageDescription'];
    grageImages = json['grageImages'];
    gragePricePerHoure = json['gragePricePerHoure'];
    lat = json['lat'];
    lng = json['lng'];
    openDate = json['openDate'];
    endDate = json['endDate'];
    active = json['active'];
    driver = json['driver'].cast<String>();
    subOwner = json['subOwner'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gragename'] = this.gragename;
    data['grageDescription'] = this.grageDescription;
    data['grageImages'] = this.grageImages;
    data['gragePricePerHoure'] = this.gragePricePerHoure;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['openDate'] = this.openDate;
    data['endDate'] = this.endDate;
    data['active'] = this.active;
    data['driver'] = this.driver;
    data['subOwner'] = this.subOwner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
