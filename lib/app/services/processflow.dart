import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';
import '../models/processflowdata_model.dart';

class ProcessFlowService {
  Future<GetProcessFlowDataModel> getProcessFlow() async {
    var data = getStorage.read('user');
    var accessPointId = getStorage.read('accessPointId');
    var getUserData = jsonDecode(data);
    var orgId = getUserData['OrganizationID'] ?? "";
    try {
      var response = await http.get(
        Uri.parse(
            '$baseUrl/api/processflow/getProcessFlowData?OrgId=$orgId&&AccessPointId=$accessPointId'),
      );
      if (response.statusCode == 200) {
        var accesspointdata = jsonDecode(response.body);
        return GetProcessFlowDataModel.fromJson(accesspointdata);
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
