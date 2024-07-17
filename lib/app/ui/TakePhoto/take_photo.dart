import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';

import '../../controller/processflow_conroller.dart';
import '../../controller/visiter_controller.dart';
import '../Auth/login.dart';
import '../../routes/app_pages.dart';
import '../widgets/comman_appbar.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../widgets/thankyou_widget.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  File? imageFile;
  String accessPoint = "";
  final visitorController = Get.put(VisiterController());
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
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
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CommonAppBar(
          width: MediaQuery.of(context).size.width,
          showBackButton: true,
          text: "Back",
          onBackPressed: () {
            Navigator.of(context).pop();
          },
          showLogoutButton: true,
          onLogoutPressed: () {
            logoutConfirmationDialog();
          },
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
            Text("Today is $day, $formattedDate",
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
            const Text("We need to take your photo. Smile!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 16)),
            const SizedBox(height: 10),
            Expanded(
              child: imageFile == null
                  ? SmartFaceCamera(
                      defaultCameraLens: CameraLens.front,
                      onCapture: (File? image) {
                        setState(() {
                          imageFile = File(image!.path);
                        });
                        visitorController.saveImageData(imageFile!.path);

                        if (getAllProcessflowController
                                .processflowList[0].successMsgData ==
                            null) {
                          Get.to(() => const ThankyouWidget());
                        } else {
                          Get.toNamed(Routes.thankYouPage);
                        }
                      },
                    )
                  : Stack(
                      children: [
                        Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            child: IconButton(
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: kWhiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              imageFile = null;
                            });
                          },
                        ))
                      ],
                    ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  logoutConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert !"),
        elevation: 5,
        titleTextStyle: const TextStyle(fontSize: 18, color: kRedColor),
        content: const Text("Are you sure want to logout?"),
        contentPadding: const EdgeInsets.only(left: 25, top: 10),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Get.back();
              getStorage.remove('user');
              getStorage.remove('authToken');
              getStorage.write('onBoard', 0);
              Get.offAll(() => const LoginPage());
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'No',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
