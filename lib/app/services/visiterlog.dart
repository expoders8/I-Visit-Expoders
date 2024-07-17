import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../controller/visiter_controller.dart';

class VisiterService {
  getVisiterLog(String badgeId) async {
    // var token = getStorage.read("authToken");
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
      if (response.statusCode == 200) {
        if (decodedUser['success']) {
          return true;
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(decodedUser['message'], "");
          return false;
        }
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
