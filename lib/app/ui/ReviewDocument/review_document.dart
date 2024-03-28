import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/imagepicker_provider.dart';
import '../../routes/app_pages.dart';

class ReviewDocumentPage extends StatefulWidget {
  const ReviewDocumentPage({super.key});

  @override
  State<ReviewDocumentPage> createState() => _ReviewDocumentPageState();
}

class _ReviewDocumentPageState extends State<ReviewDocumentPage> {
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
      body: SingleChildScrollView(
        child: Container(
          height: Get.height - 100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      builsTitleWidget("Read and review the document  below."),
                      SizedBox(height: 25),
                      const Text(
                        "Scroll down to sign",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: kCircularStdMedium,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 190.0,
                  ),
                ],
              ),
              SizedBox(
                width: Get.width - 20,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                  child: const Text("Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {
                    Get.toNamed(Routes.takePhotoPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  builsTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        title,
        style: const TextStyle(
            color: kPrimaryColor, fontFamily: kCircularStdMedium, fontSize: 14),
      ),
    );
  }
}
