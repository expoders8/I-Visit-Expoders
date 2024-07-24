import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constant/constant.dart';
import '../models/processflowdata_model.dart';
import '../../config/provider/loader_provider.dart';
import '../../config/provider/snackbar_provider.dart';

class ProcessFlowService {
  Future<GetProcessFlowDataModel> getProcessFlow() async {
    var data = getStorage.read('user');
    var accessPointId = getStorage.read('accessPointId');
    var visitorTypeId = getStorage.read('visitorTypeId');
    var getUserData = jsonDecode(data);
    var orgId = getUserData['OrganizationID'] ?? "";
    try {
      var response = await http.get(
        Uri.parse(
            '$baseUrl/api/processflow/getProcessFlowData?OrgId=$orgId&&AccessPointId=$accessPointId&&VisitorTypeId=$visitorTypeId'),
      );
      var decodedData = jsonDecode(response.body);
      if (decodedData['success']) {
        return GetProcessFlowDataModel.fromJson(decodedData);
      } else {
        LoaderX.hide();
        SnackbarUtils.showErrorSnackbar(decodedData['error'], "");
        return Future.error("Server Error");
      }
    } catch (e) {
      LoaderX.hide();
      SnackbarUtils.showErrorSnackbar("Server Error", e.toString());
      throw e.toString();
    }
  }
}
