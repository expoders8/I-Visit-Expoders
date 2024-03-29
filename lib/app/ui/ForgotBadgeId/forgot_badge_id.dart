import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../config/constant/constant.dart';
import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class ForgotbadgeIdPage extends StatefulWidget {
  const ForgotbadgeIdPage({super.key});

  @override
  State<ForgotbadgeIdPage> createState() => _ForgotbadgeIdPageState();
}

class _ForgotbadgeIdPageState extends State<ForgotbadgeIdPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController badgeIdController = TextEditingController();
  bool isFormSubmitted = false;
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
                  Text(accessPoint,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 13)),
                  Text("Today is $day, $formattedDate at $formattedTime.",
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 13)),
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
                  const Text("Please provide the following:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kDiscriptionColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      builsTitleWidget("Email"),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: Get.width > 500 ? 600 : Get.width,
                        child: CustomTextFormField(
                          hintText: 'Email',
                          maxLines: 1,
                          ctrl: emailController,
                          name: "email",
                          formSubmitted: isFormSubmitted,
                          validationMsg: 'Email is Required',
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      builsTitleWidget("Badge ID"),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: Get.width > 500 ? 600 : Get.width,
                        child: CustomTextFormField(
                          hintText: 'Badge ID',
                          maxLines: 1,
                          ctrl: badgeIdController,
                          name: "badgeid",
                          formSubmitted: isFormSubmitted,
                          validationMsg: 'Badge ID is Required',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(height: 30),
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
                    Get.toNamed(Routes.processFlowPage);
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
