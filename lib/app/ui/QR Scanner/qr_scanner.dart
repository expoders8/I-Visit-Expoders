import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../routes/app_pages.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  String accessPoint = "";
  @override
  void initState() {
    var data = getStorage.read('accessPoint') ?? "";
    setState(() {
      accessPoint = data;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);
    String day = DateFormat('EEEE').format(now);
    final double width = Get.width;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: kTapColor3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.back();
                          },
                          child: Container(
                            width: width / 2,
                            color: kTapColor,
                            child: const Center(
                                child: Text(
                              "Back",
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                        Container(
                          width: width / 5,
                          color: kTapColor1,
                        ),
                        Container(
                          width: width / 5,
                          color: kTapColor2,
                        ),
                        Container(
                          color: kTapColor3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(accessPoint,
                style: const TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            Text("Today is $day, $formattedDate at $formattedTime.",
                style: const TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            const SizedBox(height: 52),
            Image.asset(
              "assets/i-Visits_logo.png",
              fit: BoxFit.cover,
              scale: 1.5,
            ),
            const SizedBox(height: 80),
            const Text("WELCOME TO DREAMWORKS!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 16)),
            const SizedBox(height: 10),
            CupertinoButton(
              onPressed: () {
                getAllProcessflowController.fetchAllProcessFlow();
                Get.toNamed(Routes.processFlowPage);
              },
              child: const Text("Scan Below",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kDiscriptionColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 14)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: kWhiteColor,
                    borderRadius: 14,
                    borderLength: 20,
                    borderWidth: 5,
                    cutOutHeight: 260,
                    cutOutWidth: 260),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen(
      (scanData) {
        controller.dispose();
      },
    );
  }
}
