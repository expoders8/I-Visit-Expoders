import 'package:get/get.dart';

import '../services/processflow.dart';
import '../models/processflowdata_model.dart';

class GetAllProcessflowController extends GetxController {
  var isLoading = true.obs;
  var processflowList = <GetProcessFlowDataModel>[].obs;
  ProcessFlowService processFlowService = ProcessFlowService();

  @override
  void onInit() {
    fetchAllProcessFlow();
    super.onInit();
  }

  void fetchAllProcessFlow() async {
    try {
      isLoading(true);
      var processflow = await processFlowService.getProcessFlow();
      processflowList.assign(processflow);
    } finally {
      isLoading(false);
    }
  }
}
