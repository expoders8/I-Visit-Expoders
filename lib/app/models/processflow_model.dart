class GetProcessflowModel {
  ProcessFlowData? processFlowData;
  List<QuestionsData>? questionsData;
  WelcomeMsgData? welcomeMsgData;
  WelcomeMsgData? successMsgData;

  GetProcessflowModel(
      {this.processFlowData,
      this.questionsData,
      this.welcomeMsgData,
      this.successMsgData});

  GetProcessflowModel.fromJson(Map<String, dynamic> json) {
    processFlowData = json['processFlowData'] != null
        ? ProcessFlowData.fromJson(json['processFlowData'])
        : null;
    if (json['questionsData'] != null) {
      questionsData = <QuestionsData>[];
      json['questionsData'].forEach((v) {
        questionsData!.add(QuestionsData.fromJson(v));
      });
    }
    welcomeMsgData = json['welcomeMsgData'] != null
        ? WelcomeMsgData.fromJson(json['welcomeMsgData'])
        : null;
    successMsgData = json['successMsgData'] != null
        ? WelcomeMsgData.fromJson(json['successMsgData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}

class ProcessFlowData {
  int? iD;
  int? locationID;
  int? visitorTypeID;
  int? isAuthenticate;
  int? isName;
  int? isEmail;
  int? isCompany;
  int? isPhone;
  int? isTitle;
  int? isHost;
  int? isQuestion;
  int? isDocument;
  int? isPhoto;
  int? isNameBadge;
  String? createDte;
  int? isActive;

  ProcessFlowData(
      {this.iD,
      this.locationID,
      this.visitorTypeID,
      this.isAuthenticate,
      this.isName,
      this.isEmail,
      this.isCompany,
      this.isPhone,
      this.isTitle,
      this.isHost,
      this.isQuestion,
      this.isDocument,
      this.isPhoto,
      this.isNameBadge,
      this.createDte,
      this.isActive});

  ProcessFlowData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    locationID = json['LocationID'];
    visitorTypeID = json['VisitorTypeID'];
    isAuthenticate = json['IsAuthenticate'];
    isName = json['IsName'];
    isEmail = json['IsEmail'];
    isCompany = json['IsCompany'];
    isPhone = json['IsPhone'];
    isTitle = json['IsTitle'];
    isHost = json['IsHost'];
    isQuestion = json['IsQuestion'];
    isDocument = json['IsDocument'];
    isPhoto = json['IsPhoto'];
    isNameBadge = json['IsNameBadge'];
    createDte = json['CreateDte'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['LocationID'] = locationID;
    data['VisitorTypeID'] = visitorTypeID;
    data['IsAuthenticate'] = isAuthenticate;
    data['IsName'] = isName;
    data['IsEmail'] = isEmail;
    data['IsCompany'] = isCompany;
    data['IsPhone'] = isPhone;
    data['IsTitle'] = isTitle;
    data['IsHost'] = isHost;
    data['IsQuestion'] = isQuestion;
    data['IsDocument'] = isDocument;
    data['IsPhoto'] = isPhoto;
    data['IsNameBadge'] = isNameBadge;
    data['CreateDte'] = createDte;
    data['IsActive'] = isActive;
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
  int? accessPointID;
  String? text;
  String? imageFile;

  WelcomeMsgData({this.iD, this.accessPointID, this.text, this.imageFile});

  WelcomeMsgData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    accessPointID = json['AccessPointID'];
    text = json['Text'];
    imageFile = json['ImageFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['AccessPointID'] = accessPointID;
    data['Text'] = text;
    data['ImageFile'] = imageFile;
    return data;
  }
}
