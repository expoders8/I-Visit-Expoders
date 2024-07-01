import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

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
}
