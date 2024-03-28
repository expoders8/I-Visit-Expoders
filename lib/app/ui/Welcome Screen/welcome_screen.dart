import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                      fontSize: 13)),
              const Text("Today is Saturday, October 28, 2022 at 8:30 am.",
                  style: TextStyle(
                      color: kBlueColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 13)),
              const SizedBox(height: 70),
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
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kDiscriptionColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 14)),
              const SizedBox(height: 20),
              const Text(
                  "If you have a QR Code, tap on the SCAN button to check-in.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 15)),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width - 95,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFB9F73E),
                  child: const Text("I have QR Code to scan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {
                    Get.toNamed(Routes.qrScannerPage);
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width - 95,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFB9F73E),
                  child: const Text("I know my badge ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {
                    Get.toNamed(Routes.forgotbadgeIdPage);
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text("Otherwise, tap on NEXT button.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 15)),
              const SizedBox(height: 6),
              SizedBox(
                width: Get.width - 95,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                  child: const Text("I am new here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
