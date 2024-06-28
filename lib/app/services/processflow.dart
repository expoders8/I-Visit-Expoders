import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/processflow_model.dart';
import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class ProcessFlowService {
  Future<GetProcessflowModel> getProcessFlow() async {
    var data = getStorage.read('user');
    var getUserData = jsonDecode(data);
    var orgId = getUserData['OrganizationID'] ?? "";
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/api/processflow/getProcessFlow?OrgId=$orgId'),
      );
      if (response.statusCode == 200) {
        var accesspointdata = jsonDecode(response.body);
        getStorage.write('IsAuthenticate',
            accesspointdata['processFlowData']['IsAuthenticate']);
        return GetProcessflowModel.fromJson(accesspointdata);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar("Server Error",
            "Error while Accesspoint, Please try after some time.");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Server Error", e.toString());
      throw e.toString();
    }
  }
}
