import 'package:get/get.dart';

import '../models/visitor_types_model.dart';
import '../services/visiter_service.dart';

class GetAllVisitorTypesController extends GetxController {
  var isLoading = true.obs;
  var visitorList = <GetAllVisitorTypeModel>[].obs;
  VisitorService visitorService = VisitorService();

  @override
  void onInit() {
    fetchAllVisitorTypes();
    super.onInit();
  }

  void fetchAllVisitorTypes() async {
    try {
      isLoading(true);
      var visitortype = await visitorService.getAllVisitorTypes();
      visitorList.assign(visitortype);
    } finally {
      isLoading(false);
    }
  }
}
