import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import '../AccessPoint/access_point.dart';
import '../../services/visiter_service.dart';
import '../../../config/constant/font_constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';

class ThankyouWidget extends StatefulWidget {
  final String? code;
  const ThankyouWidget({super.key, this.code});

  @override
  State<ThankyouWidget> createState() => _ThankyouRFIEADSPageState();
}

class _ThankyouRFIEADSPageState extends State<ThankyouWidget> {
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  VisitorService visiterService = VisitorService();
  @override
  void initState() {
    autoNavigateScreen();
    super.initState();
  }

  autoNavigateScreen() {
    visiterService
        .saveVisit(getAllProcessflowController
            .processflowList[0].processFlowData!.visitorTypeID
            .toString())
        .then((value) => {
              if (value)
                {
                  Future.delayed(const Duration(seconds: 3), () {
                    LoaderX.hide();
                    Get.offAll(() => const AccessPointPage());
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/checkjson.json',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Thank You!",
            style: TextStyle(
                color: kPrimaryColor,
                fontFamily: kCircularStdMedium,
                fontSize: 28),
          ),
          const Text(
            "You have successfully registered your visit!!",
            style: TextStyle(
                color: kSecondaryPrimaryColor,
                fontFamily: kCircularStdNormal,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
