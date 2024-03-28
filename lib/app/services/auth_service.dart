import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class AuthService {
  login(String organizationId, String email, String password,
      String fcmToken) async {
    try {
      var response =
          await http.post(Uri.parse('$baseUrl/api/Authentication/Login'),
              body: json.encode({
                "orgID": organizationId,
                "email": email,
                "password": password,
                "fcmToken": fcmToken
              }),
              headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        var decodedUser = jsonDecode(response.body);
        if (decodedUser['success']) {
          var userObj = decodedUser["data"];

          if (userObj != null && decodedUser["success"]) {
            getStorage.write('user', jsonEncode(decodedUser["data"]));
            getStorage.write('authToken', decodedUser["data"]['authToken']);
            getStorage.write('onBoard', 1);
            LoaderX.hide();

            // Get.offAll(() => const TabPage());
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
