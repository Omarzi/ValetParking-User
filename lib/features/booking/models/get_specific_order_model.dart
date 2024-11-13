class GetSpecificOrderModel {
  String? orderId;
  String? orderNumber;
  User? user;
  Garage? garage;
  String? typeOfCar;
  String? date;
  TimeRange? timeRange;
  int? totalPrice;
  int? duration;
  String? paymentMethod;
  bool? isPaid;
  String? status;
  bool? startNow;
  String? qrCode;
  String? createdAt;
  String? updatedAt;

  GetSpecificOrderModel(
      {this.orderId,
        this.orderNumber,
        this.user,
        this.garage,
        this.typeOfCar,
        this.date,
        this.timeRange,
        this.totalPrice,
        this.duration,
        this.paymentMethod,
        this.isPaid,
        this.status,
        this.startNow,
        this.qrCode,
        this.createdAt,
        this.updatedAt});

  GetSpecificOrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNumber = json['orderNumber'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    garage =
    json['garage'] != null ? new Garage.fromJson(json['garage']) : null;
    typeOfCar = json['typeOfCar'];
    date = json['date'];
    timeRange = json['timeRange'] != null
        ? new TimeRange.fromJson(json['timeRange'])
        : null;
    totalPrice = json['totalPrice'];
    duration = json['duration'];
    paymentMethod = json['paymentMethod'];
    isPaid = json['isPaid'];
    status = json['status'];
    startNow = json['startNow'];
    qrCode = json['qrCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNumber'] = this.orderNumber;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.garage != null) {
      data['garage'] = this.garage!.toJson();
    }
    data['typeOfCar'] = this.typeOfCar;
    data['date'] = this.date;
    if (this.timeRange != null) {
      data['timeRange'] = this.timeRange!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    data['duration'] = this.duration;
    data['paymentMethod'] = this.paymentMethod;
    data['isPaid'] = this.isPaid;
    data['status'] = this.status;
    data['startNow'] = this.startNow;
    data['qrCode'] = this.qrCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class User {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? carName;
  String? carNumber;
  String? createdAt;
  String? updatedAt;

  User(
      {this.userId,
        this.name,
        this.email,
        this.phone,
        this.carName,
        this.carNumber,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
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
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['carName'] = this.carName;
    data['carNumber'] = this.carNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Garage {
  String? garageId;
  List<String>? driver;
  List<String>? subOwner;
  String? gragename;
  String? grageDescription;
  String? grageImages;
  int? gragePricePerHoure;
  double? lat;
  double? lng;
  String? openDate;
  String? endDate;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Garage(
      {this.garageId,
        this.driver,
        this.subOwner,
        this.gragename,
        this.grageDescription,
        this.grageImages,
        this.gragePricePerHoure,
        this.lat,
        this.lng,
        this.openDate,
        this.endDate,
        this.active,
        this.createdAt,
        this.updatedAt});

  Garage.fromJson(Map<String, dynamic> json) {
    garageId = json['garageId'];
    driver = json['driver'].cast<String>();
    subOwner = json['subOwner'].cast<String>();
    gragename = json['gragename'];
    grageDescription = json['grageDescription'];
    grageImages = json['grageImages'];
    gragePricePerHoure = json['gragePricePerHoure'];
    lat = json['lat'];
    lng = json['lng'];
    openDate = json['openDate'];
    endDate = json['endDate'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garageId'] = this.garageId;
    data['driver'] = this.driver;
    data['subOwner'] = this.subOwner;
    data['gragename'] = this.gragename;
    data['grageDescription'] = this.grageDescription;
    data['grageImages'] = this.grageImages;
    data['gragePricePerHoure'] = this.gragePricePerHoure;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['openDate'] = this.openDate;
    data['endDate'] = this.endDate;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class TimeRange {
  String? start;
  String? end;

  TimeRange({this.start, this.end});

  TimeRange.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}


// import 'package:valetparking_user/features/auth/models/user_data_model.dart';
//
// class GetSpecificOrderModel {
//   String? orderId;
//   User? user;
//   Garage? garage;
//   String? typeOfCar;
//   String? date;
//   TimeRange? timeRange;
//   int? totalPrice;
//   int? duration;
//   String? paymentMethod;
//   bool? isPaid;
//   String? status;
//   bool? startNow;
//   String? qrCode;
//   String? createdAt;
//   String? updatedAt;
//
//   GetSpecificOrderModel(
//       {this.orderId,
//         this.user,
//         this.garage,
//         this.typeOfCar,
//         this.date,
//         this.timeRange,
//         this.totalPrice,
//         this.duration,
//         this.paymentMethod,
//         this.isPaid,
//         this.status,
//         this.startNow,
//         this.qrCode,
//         this.createdAt,
//         this.updatedAt});
//
//   GetSpecificOrderModel.fromJson(Map<String, dynamic> json) {
//     orderId = json['orderId'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     garage =
//     json['garage'] != null ? new Garage.fromJson(json['garage']) : null;
//     typeOfCar = json['typeOfCar'];
//     date = json['date'];
//     timeRange = json['timeRange'] != null
//         ? new TimeRange.fromJson(json['timeRange'])
//         : null;
//     totalPrice = json['totalPrice'];
//     duration = json['duration'];
//     paymentMethod = json['paymentMethod'];
//     isPaid = json['isPaid'];
//     status = json['status'];
//     startNow = json['startNow'];
//     qrCode = json['qrCode'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['orderId'] = this.orderId;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.garage != null) {
//       data['garage'] = this.garage!.toJson();
//     }
//     data['typeOfCar'] = this.typeOfCar;
//     data['date'] = this.date;
//     if (this.timeRange != null) {
//       data['timeRange'] = this.timeRange!.toJson();
//     }
//     data['totalPrice'] = this.totalPrice;
//     data['duration'] = this.duration;
//     data['paymentMethod'] = this.paymentMethod;
//     data['isPaid'] = this.isPaid;
//     data['status'] = this.status;
//     data['startNow'] = this.startNow;
//     data['qrCode'] = this.qrCode;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class User {
//   String? userId;
//   String? username;
//   String? email;
//   String? password;
//   String? phone;
//   String? profileImage;
//   String? carName;
//   String? carNumber;
//   String? carImage;
//   List<Saved>? saved;
//   String? role;
//   String? createdAt;
//   String? updatedAt;
//   bool? passwordResetVerified;
//   int? wallet;
//
//   User(
//       {this.userId,
//         this.username,
//         this.email,
//         this.password,
//         this.phone,
//         this.profileImage,
//         this.carName,
//         this.carNumber,
//         this.carImage,
//         this.saved,
//         this.role,
//         this.createdAt,
//         this.updatedAt,
//         this.passwordResetVerified,
//         this.wallet});
//
//   User.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     username = json['username'];
//     email = json['email'];
//     password = json['password'];
//     phone = json['phone'];
//     profileImage = json['profileImage'];
//     carName = json['carName'];
//     carNumber = json['carNumber'];
//     carImage = json['carImage'];
//     if (json['saved'] != null) {
//       saved = <Saved>[];
//       json['saved'].forEach((v) {
//         saved!.add(new Saved.fromJson(v));
//       });
//     }
//     role = json['role'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     passwordResetVerified = json['passwordResetVerified'];
//     wallet = json['wallet'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phone'] = this.phone;
//     data['profileImage'] = this.profileImage;
//     data['carName'] = this.carName;
//     data['carNumber'] = this.carNumber;
//     data['carImage'] = this.carImage;
//     if (this.saved != null) {
//       data['saved'] = this.saved!.map((v) => v.toJson()).toList();
//     }
//     data['role'] = this.role;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['passwordResetVerified'] = this.passwordResetVerified;
//     data['wallet'] = this.wallet;
//     return data;
//   }
// }
//
// class Garage {
//   String? garageId;
//   List<String>? garageImages;
//   String? gragename;
//   String? grageDescription;
//   String? grageImages;
//   int? gragePricePerHoure;
//   double? lat;
//   double? lng;
//   String? openDate;
//   String? endDate;
//   bool? active;
//   List<String>? driver;
//   List<String>? subOwner;
//   String? createdAt;
//   String? updatedAt;
//
//   Garage(
//       {this.garageId,
//         this.garageImages,
//         this.gragename,
//         this.grageDescription,
//         this.grageImages,
//         this.gragePricePerHoure,
//         this.lat,
//         this.lng,
//         this.openDate,
//         this.endDate,
//         this.active,
//         this.driver,
//         this.subOwner,
//         this.createdAt,
//         this.updatedAt});
//
//   Garage.fromJson(Map<String, dynamic> json) {
//     garageId = json['garageId'];
//     garageImages = json['garageImages'].cast<String>();
//     gragename = json['gragename'];
//     grageDescription = json['grageDescription'];
//     grageImages = json['grageImages'];
//     gragePricePerHoure = json['gragePricePerHoure'];
//     lat = json['lat'];
//     lng = json['lng'];
//     openDate = json['openDate'];
//     endDate = json['endDate'];
//     active = json['active'];
//     driver = json['driver'].cast<String>();
//     subOwner = json['subOwner'].cast<String>();
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['garageId'] = this.garageId;
//     data['garageImages'] = this.garageImages;
//     data['gragename'] = this.gragename;
//     data['grageDescription'] = this.grageDescription;
//     data['grageImages'] = this.grageImages;
//     data['gragePricePerHoure'] = this.gragePricePerHoure;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['openDate'] = this.openDate;
//     data['endDate'] = this.endDate;
//     data['active'] = this.active;
//     data['driver'] = this.driver;
//     data['subOwner'] = this.subOwner;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class TimeRange {
//   String? start;
//   String? end;
//
//   TimeRange({this.start, this.end});
//
//   TimeRange.fromJson(Map<String, dynamic> json) {
//     start = json['start'];
//     end = json['end'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['start'] = this.start;
//     data['end'] = this.end;
//     return data;
//   }
// }
