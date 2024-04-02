import 'package:get/get.dart';

import '../services/accesspoint.dart';
import '../models/accesspoint_model.dart';

class GetAllAccessPointController extends GetxController {
  var isLoading = true.obs;
  var accessPointList = <GetAllAccessPointModel>[].obs;
  AccessPointService accessPointService = AccessPointService();

  @override
  void onInit() {
    fetchAllAccessPoint();
    super.onInit();
  }

  void fetchAllAccessPoint() async {
    try {
      isLoading(true);
      var accesspoint = await accessPointService.getAccesssPoint();
      accessPointList.assign(accesspoint);
    } finally {
      isLoading(false);
    }
  }
}
