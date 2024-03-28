import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:face_camera/face_camera.dart';

import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../routes/app_pages.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leadingWidth: 100,
        leading: CupertinoButton(
          child: const Text(
            "BACK",
            style: TextStyle(
                color: kWhiteColor,
                fontFamily: kCircularStdMedium,
                fontSize: 14),
          ),
          onPressed: () {
            Get.back();
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
            const Text("FRONT DESK",
                style: TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            const Text("Today is Saturday, October 28, 2022 at 8:30 am.",
                style: TextStyle(
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
                        Get.toNamed(Routes.thankYouPage);
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
}
