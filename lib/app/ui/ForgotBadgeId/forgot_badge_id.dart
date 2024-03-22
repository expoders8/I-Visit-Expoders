import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
              const Text("i-Visit.",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 16)),
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
                  onPressed: () {},
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
