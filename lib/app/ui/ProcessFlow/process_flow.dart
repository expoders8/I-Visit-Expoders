import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class ProcessFlowPage extends StatefulWidget {
  const ProcessFlowPage({super.key});

  @override
  State<ProcessFlowPage> createState() => _ProcessFlowPageState();
}

class _ProcessFlowPageState extends State<ProcessFlowPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController badgeIdController = TextEditingController();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> purpose = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
  String purposeValue = "One";
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          builsTitleWidget("Firstname"),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            width: Get.width > 500 ? 600 : Get.width / 2.2,
                            child: CustomTextFormField(
                              hintText: 'Firstname',
                              maxLines: 1,
                              ctrl: emailController,
                              name: "firstname",
                              formSubmitted: isFormSubmitted,
                              validationMsg: 'Firstname is Required',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8.600),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          builsTitleWidget("Lastname"),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            width: Get.width > 500 ? 600 : Get.width / 2.2,
                            child: CustomTextFormField(
                              hintText: 'Lastname',
                              maxLines: 1,
                              ctrl: emailController,
                              name: "lastname",
                              formSubmitted: isFormSubmitted,
                              validationMsg: 'Lastname is Required',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
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
                  builsTitleWidget("Phone number"),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: Get.width > 500 ? 600 : Get.width,
                    child: CustomTextFormField(
                      hintText: 'Phone number',
                      maxLines: 1,
                      ctrl: badgeIdController,
                      name: "phoneno",
                      formSubmitted: isFormSubmitted,
                      validationMsg: 'Phone number is Required',
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  builsTitleWidget("Who are you visiting?"),
                  const SizedBox(height: 5.0),
                  Container(
                    width: Get.width > 500 ? 600 : Get.width - 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: Image.asset(
                        "assets/icons/arrow-bottom-outline.png",
                        color: kIconColor,
                        scale: 1.4,
                      ),
                      style: const TextStyle(color: kPrimaryColor),
                      underline: Container(
                        height: 0,
                      ),
                      padding: const EdgeInsets.fromLTRB(15, 0, 19, 0),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  builsTitleWidget("Purpose of Visit"),
                  const SizedBox(height: 5.0),
                  Container(
                    width: Get.width > 500 ? 600 : Get.width - 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButton<String>(
                      value: purposeValue,
                      isExpanded: true,
                      icon: Image.asset(
                        "assets/icons/arrow-bottom-outline.png",
                        color: kIconColor,
                        scale: 1.4,
                      ),
                      style: const TextStyle(color: kPrimaryColor),
                      underline: Container(
                        height: 0,
                      ),
                      padding: const EdgeInsets.fromLTRB(15, 0, 19, 0),
                      onChanged: (String? value) {
                        setState(() {
                          purposeValue = value!;
                        });
                      },
                      items:
                          purpose.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
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
                  onPressed: () {
                    Get.toNamed(Routes.questionPage);
                  },
                ),
              ),
              const SizedBox(height: 10),
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
