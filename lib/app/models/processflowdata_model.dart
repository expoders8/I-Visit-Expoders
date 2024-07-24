class GetProcessFlowDataModel {
  bool? success;
  ProcessFlowData? processFlowData;
  List<QuestionsData>? questionsData;
  WelcomeMsgData? welcomeMsgData;
  SuccessMsgData? successMsgData;
  List<Screens>? screens;

  GetProcessFlowDataModel({
    this.success,
    this.processFlowData,
    this.questionsData,
    this.welcomeMsgData,
    this.successMsgData,
    this.screens,
  });

  GetProcessFlowDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    processFlowData = json['processFlowData'] != null
        ? ProcessFlowData.fromJson(json['processFlowData'])
        : null;
    if (json['questionsData'] != null) {
      questionsData = [];
      json['questionsData'].forEach((v) {
        questionsData!.add(QuestionsData.fromJson(v));
      });
    }
    welcomeMsgData = json['welcomeMsgData'] != null
        ? WelcomeMsgData.fromJson(json['welcomeMsgData'])
        : null;
    successMsgData = json['successMsgData'] != null
        ? SuccessMsgData.fromJson(json['successMsgData'])
        : null;
    if (json['screens'] != null) {
      screens = [];
      json['screens'].forEach((v) {
        screens!.add(Screens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (processFlowData != null) {
      data['processFlowData'] = processFlowData!.toJson();
    }
    if (questionsData != null) {
      data['questionsData'] = questionsData!.map((v) => v.toJson()).toList();
    }
    if (welcomeMsgData != null) {
      data['welcomeMsgData'] = welcomeMsgData!.toJson();
    }
    if (successMsgData != null) {
      data['successMsgData'] = successMsgData!.toJson();
    }
    if (screens != null) {
      data['screens'] = screens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProcessFlowData {
  int? iD;
  int? locationID;
  int? visitorTypeID;
  String? createDte;
  int? isActive;
  String? screens;

  ProcessFlowData(
      {this.iD,
      this.visitorTypeID,
      this.locationID,
      this.createDte,
      this.isActive,
      this.screens});

  ProcessFlowData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    visitorTypeID = json['VisitorTypeID'];
    createDte = json['CreateDte'];
    isActive = json['IsActive'];
    screens = json['Screens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['VisitorTypeID'] = visitorTypeID;
    data['CreateDte'] = createDte;
    data['IsActive'] = isActive;
    data['Screens'] = screens;
    return data;
  }
}

class QuestionsData {
  int? iD;
  int? locationID;
  String? questionText;
  int? displayOrder;
  String? inputType;
  String? choice;

  QuestionsData(
      {this.iD,
      this.locationID,
      this.questionText,
      this.displayOrder,
      this.inputType,
      this.choice});

  QuestionsData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    questionText = json['QuestionText'];
    displayOrder = json['DisplayOrder'];
    inputType = json['InputType'];
    choice = json['Choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['QuestionText'] = questionText;
    data['DisplayOrder'] = displayOrder;
    data['InputType'] = inputType;
    data['Choice'] = choice;
    return data;
  }
}

class WelcomeMsgData {
  int? iD;
  int? locationID;
  int? accessPointID;
  String? text;
  String? imageFile;

  WelcomeMsgData(
      {this.iD,
      this.locationID,
      this.accessPointID,
      this.text,
      this.imageFile});

  WelcomeMsgData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    accessPointID = json['AccessPointID'];
    text = json['Text'];
    imageFile = json['ImageFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['AccessPointID'] = accessPointID;
    data['Text'] = text;
    data['ImageFile'] = imageFile;
    return data;
  }
}

class SuccessMsgData {
  int? iD;
  int? locationID;
  int? accessPointID;
  String? text;
  String? imageFile;

  SuccessMsgData(
      {this.iD,
      this.locationID,
      this.accessPointID,
      this.text,
      this.imageFile});

  SuccessMsgData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    accessPointID = json['AccessPointID'];
    text = json['Text'];
    imageFile = json['ImageFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['AccessPointID'] = accessPointID;
    data['Text'] = text;
    data['ImageFile'] = imageFile;
    return data;
  }
}

class Screens {
  String? screenName;
  Fields? fields;

  Screens({this.screenName, this.fields});

  Screens.fromJson(Map<String, dynamic> json) {
    screenName = json['screenName'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['screenName'] = screenName;
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    return data;
  }
}

class Fields {
  int? isAuthenticate;
  int? isName;
  int? isEmail;
  int? isCompany;
  int? isPhone;
  int? isTitle;
  int? isHost;
  int? isDocument;
  int? isPhoto;
  int? isQuestion;
  int? isNameBadge;

  Fields(
      {this.isAuthenticate,
      this.isName,
      this.isEmail,
      this.isCompany,
      this.isPhone,
      this.isTitle,
      this.isHost,
      this.isDocument,
      this.isPhoto,
      this.isQuestion,
      this.isNameBadge});

  Fields.fromJson(Map<String, dynamic> json) {
    isAuthenticate = json['IsAuthenticate'];
    isName = json['IsName'];
    isEmail = json['IsEmail'];
    isCompany = json['IsCompany'];
    isPhone = json['IsPhone'];
    isTitle = json['IsTitle'];
    isHost = json['IsHost'];
    isDocument = json['IsDocument'];
    isPhoto = json['IsPhoto'];
    isQuestion = json['IsQuestion'];
    isNameBadge = json['IsNameBadge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsAuthenticate'] = isAuthenticate;
    data['IsName'] = isName;
    data['IsEmail'] = isEmail;
    data['IsCompany'] = isCompany;
    data['IsPhone'] = isPhone;
    data['IsTitle'] = isTitle;
    data['IsHost'] = isHost;
    data['IsDocument'] = isDocument;
    data['IsPhoto'] = isPhoto;
    data['IsQuestion'] = isQuestion;
    data['IsNameBadge'] = isNameBadge;
    return data;
  }
}
