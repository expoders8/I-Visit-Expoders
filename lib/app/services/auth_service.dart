import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../ui/AccessPoint/access_point.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class AuthService {
  login(String organizationId, String email, String password) async {
    try {
      var response = await http.post(Uri.parse('$baseUrl/api/auth/login'),
          body: json.encode({
            "organizationId": organizationId,
            "email": email,
            "password": password,
          }),
          headers: {'Content-type': 'application/json'});
      var decodedUser = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getStorage.write('orgId', organizationId);
        getStorage.write('email', email);
        getStorage.write('password', password);
        if (decodedUser['success']) {
          getStorage.write('authToken', decodedUser['api_token']);
          getUserByToken(decodedUser['api_token']);
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(
              "Failed to login", decodedUser['message']);
          return Future.error("Server Error");
        }
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedUser['message'], "");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Server Error", e.toString());
      throw e.toString();
    }
  }

  getUserByToken(String token) async {
    try {
      var response = await http.get(
          Uri.parse('$baseUrl/api/auth/getUserByToken'),
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        if (decodedUser['success']) {
          var userObj = decodedUser["user"];

          if (userObj != null && decodedUser["success"]) {
            getStorage.write('user', jsonEncode(decodedUser["user"]));
            getStorage.write('onBoard', 1);
            LoaderX.hide();
            // if (orgId == "RFIDEAS") {
            //   Get.offAll(() => const TapYourCardPage());
            // } else {
            Get.offAll(() => const AccessPointPage());
            // }
          }
        } else {
          LoaderX.hide();
          SnackbarUtils.showErrorSnackbar(
              "Failed to login", decodedUser['message']);
          return Future.error("Server Error");
        }
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Server Error", e.toString());
      throw e.toString();
    }
  }
}
