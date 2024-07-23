class GetAllVisitorTypeModel {
  List<Visitortypes>? visitortypes;
  int? totalEntries;

  GetAllVisitorTypeModel({this.visitortypes, this.totalEntries});

  GetAllVisitorTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['visitortypes'] != null) {
      visitortypes = <Visitortypes>[];
      json['visitortypes'].forEach((v) {
        visitortypes!.add(Visitortypes.fromJson(v));
      });
    }
    totalEntries = json['totalEntries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (visitortypes != null) {
      data['visitortypes'] = visitortypes!.map((v) => v.toJson()).toList();
    }
    data['totalEntries'] = totalEntries;
    return data;
  }
}

class Visitortypes {
  int? iD;
  int? locationID;
  String? name;
  String? authMethod;
  String? description;
  int? isActive;

  Visitortypes(
      {this.iD,
      this.locationID,
      this.name,
      this.authMethod,
      this.description,
      this.isActive});

  Visitortypes.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    name = json['Name'];
    authMethod = json['AuthMethod'];
    description = json['Description'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['Name'] = name;
    data['AuthMethod'] = authMethod;
    data['Description'] = description;
    data['IsActive'] = isActive;
    return data;
  }
}
