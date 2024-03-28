import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedIndex = 3, selectedVaccinatIndex = 3;
  TextEditingController emailController = TextEditingController();
  TextEditingController badgeIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isFormSubmitted = false;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
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
                  const SizedBox(height: 12.0),
                  builsTitleWidget(
                      "Do you have any of the following symptoms?"),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      buildradiosymptomsWidget("Headache", 0),
                      const SizedBox(width: 10),
                      buildradiosymptomsWidget("Flu", 1),
                      const SizedBox(width: 10),
                      buildradiosymptomsWidget("Cough", 2),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  builsTitleWidget("Are you vaccinated?"),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      buildradioVaccinatedWidget("Partially", 0),
                      const SizedBox(width: 10),
                      buildradioVaccinatedWidget("Fully", 1),
                      const SizedBox(width: 10),
                      buildradioVaccinatedWidget("No", 2),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  builsTitleWidget("When you got vaccinated?"),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: Get.width > 500 ? 600 : Get.width,
                    child: CustomTextFormField(
                      hintText: 'When you got vaccinated?',
                      maxLines: 1,
                      ctrl: emailController,
                      name: "vaccinated",
                      formSubmitted: isFormSubmitted,
                      validationMsg: 'Vaccinated is Required',
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
                  builsTitleWidget("Describe about yourself"),
                  const SizedBox(height: 5.0),
                  TextFormField(
                    style: const TextStyle(color: kPrimaryColor, fontSize: 15),
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Describe about yourself',
                      filled: true,
                      fillColor: kTransparentColor,
                      contentPadding: const EdgeInsets.fromLTRB(18, 25, 10, 0),
                      hintStyle: const TextStyle(color: kGreyColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFD8DFEB),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kErrorColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      errorStyle: const TextStyle(color: kErrorColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFD8DFEB),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFD8DFEB),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description is Required';
                      }
                      return null;
                    },
                    maxLines: 4,
                    onSaved: (value) {},
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
                  onPressed: () {
                    Get.toNamed(Routes.reviewDocumentPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildradiosymptomsWidget(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(25)),
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index ? kPrimaryColor : kWhiteColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontFamily: kCircularStdNormal),
          )
        ],
      ),
    );
  }

  buildradioVaccinatedWidget(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVaccinatIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(25)),
            child: Container(
              decoration: BoxDecoration(
                color: selectedVaccinatIndex == index
                    ? kPrimaryColor
                    : kWhiteColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontFamily: kCircularStdNormal),
          )
        ],
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
