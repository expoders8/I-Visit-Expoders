class GetAllAccessPointModel {
  List<GetAllAccessPointDataModel>? accesspoints;
  int? totalEntries;

  GetAllAccessPointModel({this.accesspoints, this.totalEntries});

  GetAllAccessPointModel.fromJson(Map<String, dynamic> json) {
    if (json['accesspoints'] != null) {
      accesspoints = <GetAllAccessPointDataModel>[];
      json['accesspoints'].forEach((v) {
        accesspoints!.add(GetAllAccessPointDataModel.fromJson(v));
      });
    }
    totalEntries = json['totalEntries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accesspoints != null) {
      data['accesspoints'] = accesspoints!.map((v) => v.toJson()).toList();
    }
    data['totalEntries'] = totalEntries;
    return data;
  }
}

class GetAllAccessPointDataModel {
  int? iD;
  int? locationID;
  String? name;
  String? description;
  bool? checkOut;
  int? isEnable;
  String? createDte;
  int? isActive;

  GetAllAccessPointDataModel(
      {this.iD,
      this.locationID,
      this.name,
      this.description,
      this.checkOut,
      this.isEnable,
      this.createDte,
      this.isActive});

  GetAllAccessPointDataModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    name = json['Name'];
    description = json['Description'];
    checkOut = json['CheckOut'];
    isEnable = json['IsEnable'];
    createDte = json['CreateDte'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['Name'] = name;
    data['Description'] = description;
    data['CheckOut'] = checkOut;
    data['IsEnable'] = isEnable;
    data['CreateDte'] = createDte;
    data['IsActive'] = isActive;
    return data;
  }
}
