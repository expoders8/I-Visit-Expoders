import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../controller/visiter_controller.dart';
import '../models/visitor_types_model.dart';

class VisitorService {
  Future<GetAllVisitorTypeModel> getAllVisitorTypes() async {
    var data = getStorage.read('user');
    var getUserData = jsonDecode(data);
    var orgId = getUserData['OrganizationID'] ?? "";
    try {
      var response = await http.get(
          Uri.parse(
              '$baseUrl/api/visitortype/list?page=1&&pageSize=100&&OrgId=$orgId'),
          headers: {
            'Content-type': 'application/json',
          });
      var decodedUser = jsonDecode(response.body);
      if (decodedUser['success']) {
        return GetAllVisitorTypeModel.fromJson(decodedUser);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedUser['error'], "");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Visitor not found!", "");
      throw e.toString();
    }
  }

  getVisiterLog(String badgeId) async {
    var orgID = getStorage.read("orgId") ?? "";
    var user = getStorage.read("user");
    var getUserData = jsonDecode(user);
    var locationId = getUserData['LocationID'];
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/visitorslog/add'),
          body: json.encode({
            "BadgeID": badgeId,
            "OrgID": orgID,
            "LocationID": locationId,
          }),
          headers: {
            'Content-type': 'application/json',
          });
      var decodedUser = jsonDecode(response.body);
      if (decodedUser['success']) {
        return true;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedUser['message'], "");
        return false;
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Invalid Badge ID!", "");
      throw e.toString();
    }
  }

  getVisitorByBadgeId(String badgeId) async {
    final visitorController = Get.put(VisiterController());
    try {
      var response = await http.get(
          Uri.parse(
              '$baseUrl/api/visitor/getVisitorByBadgeId?badgeId=$badgeId'),
          headers: {
            'Content-type': 'application/json',
          });
      var decodedUser = jsonDecode(response.body);
      if (decodedUser['success']) {
        visitorController.saveFirstname(decodedUser['data']['FirstName']);
        visitorController.saveLastname(decodedUser['data']['LastName']);
        visitorController.saveEmail(decodedUser['data']['Email']);
        visitorController.saveTitle(decodedUser['data']['Title']);
        visitorController.savephoneNumber(decodedUser['data']['Phone']);
        return true;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedUser['error'], "");
        return false;
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Visitor not found!", "");
      throw e.toString();
    }
  }

  saveVisit(
    String visitorTypeID,
  ) async {
    var accessPointId = getStorage.read("accessPointId") ?? "";
    var user = getStorage.read("user");
    var getUserData = jsonDecode(user);
    var locationId = getUserData['LocationID'];
    final visitorController = Get.put(VisiterController());
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/visit/saveVisit'),
          body: json.encode({
            "ID": accessPointId,
            "FirstName": visitorController.saveFirstname.value,
            "LastName": visitorController.saveLastname.value,
            "Email": visitorController.saveEmail.value,
            "Phone": visitorController.savephoneNumber.value,
            "Title": visitorController.saveTitle.value,
            "Host": visitorController.saveHost.value,
            "BadgeID": "",
            "Document": visitorController.saveDoc.value,
            "ImageFile": visitorController.saveImagePath.value,
            "VisitorTypeID": visitorTypeID,
            "LocationID": locationId,
            "Questions": visitorController.saveQue.value,
          }),
          headers: {
            'Content-type': 'application/json',
          });
      var decodedUser = jsonDecode(response.body);
      if (decodedUser['status'] == 200) {
        LoaderX.hide();
        SnackbarUtils.showSnackbar(decodedUser['message'], "");
        return true;
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedUser['message'], "");
        return false;
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar(e.toString(), "");
      throw e.toString();
    }
  }
}
