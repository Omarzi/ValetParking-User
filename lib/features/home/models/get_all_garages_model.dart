class GetAllGaragesModel {
  List<GarageDetails>? garageDetails;

  GetAllGaragesModel({this.garageDetails});

  GetAllGaragesModel.fromJson(Map<String, dynamic> json) {
    if (json['Garage Details'] != null) {
      garageDetails = <GarageDetails>[];
      json['Garage Details'].forEach((v) {
        garageDetails!.add(new GarageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.garageDetails != null) {
      data['Garage Details'] =
          this.garageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GarageDetails {
  String? garageId;
  String? gragename;
  String? grageDescription;
  String? grageImages;
  dynamic? gragePricePerHoure;
  dynamic? lat;
  dynamic? lng;
  String? openDate;
  String? endDate;
  bool? active;
  bool? isSaved;
  List<String>? driver;
  List<String>? subOwner;
  String? createdAt;
  String? updatedAt;

  GarageDetails(
      {this.garageId,
        this.gragename,
        this.grageDescription,
        this.grageImages,
        this.gragePricePerHoure,
        this.lat,
        this.lng,
        this.openDate,
        this.endDate,
        this.active,
        this.isSaved,
        this.driver,
        this.subOwner,
        this.createdAt,
        this.updatedAt});

  GarageDetails.fromJson(Map<String, dynamic> json) {
    garageId = json['garageId'];
    gragename = json['gragename'];
    grageDescription = json['grageDescription'];
    grageImages = json['grageImages'];
    gragePricePerHoure = json['gragePricePerHoure'];
    lat = json['lat'];
    lng = json['lng'];
    openDate = json['openDate'];
    endDate = json['endDate'];
    active = json['active'];
    isSaved = json['isSaved'];
    driver = json['driver'].cast<String>();
    subOwner = json['subOwner'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garageId'] = this.garageId;
    data['gragename'] = this.gragename;
    data['grageDescription'] = this.grageDescription;
    data['grageImages'] = this.grageImages;
    data['gragePricePerHoure'] = this.gragePricePerHoure;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['openDate'] = this.openDate;
    data['endDate'] = this.endDate;
    data['active'] = this.active;
    data['isSaved'] = this.isSaved;
    data['driver'] = this.driver;
    data['subOwner'] = this.subOwner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
