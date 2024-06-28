import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ivisit/app/ui/ReviewDocument/review_document.dart';

import '../../../config/constant/constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../models/processflow_model.dart';
import '../../routes/app_pages.dart';
import '../Auth/login.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class QuestionPage extends StatefulWidget {
  final ProcessFlowData? accessPointData;
  const QuestionPage({super.key, this.accessPointData});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedIndex = 3, selectedVaccinatIndex = 3;
  TextEditingController emailController = TextEditingController();
  TextEditingController badgeIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  bool isFormSubmitted = false, valuefirst = false;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
  String accessPoint = "";
  Map<int, List<bool>> isCheckedMap = {};

  @override
  void initState() {
    var ttt = widget.accessPointData;
    print(ttt);
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
    var processFlowData =
        getAllProcessflowController.processflowList[0].processFlowData;
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
                            height: 80,
                            color: kTapColor,
                            child: const Row(
                              children: [
                                SizedBox(width: 15),
                                Icon(
                                  Icons.arrow_back,
                                  color: kWhiteColor,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
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
                          height: 80,
                          color: kTapColor3,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: logoutConfirmationDialog,
                            child: const Row(
                              children: [
                                SizedBox(width: 3),
                                Icon(
                                  Icons.logout_rounded,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "LogOut",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: kCircularStdMedium,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
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
      body: SingleChildScrollView(
        child: Container(
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
                      fontSize: 13)),
              Text("Today is $day, $formattedDate at $formattedTime.",
                  style: const TextStyle(
                      color: kBlueColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 13)),
              const SizedBox(height: 15),
              Image.asset(
                "assets/i-Visits_logo.png",
                fit: BoxFit.cover,
                scale: 1.5,
              ),
              const SizedBox(height: 25),
              Column(
                children: [
                  SizedBox(
                    height: Get.height - 300,
                    width: Get.width > 500 ? 600 : Get.width,
                    child: Obx(
                      () {
                        if (getAllProcessflowController.isLoading.value) {
                          return Container(
                            color: kBackGroundColor,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kSelectedIconColor,
                              ),
                            ),
                          );
                        } else {
                          if (getAllProcessflowController
                              .processflowList.isEmpty) {
                            return Center(
                              child: SizedBox(
                                width: Get.width - 80,
                                child: const Text(
                                  "No ProcessFlow",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontFamily: kCircularStdMedium),
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: getAllProcessflowController
                                  .processflowList[0].questionsData!.length,
                              itemBuilder: (context, index) {
                                var accessPointData =
                                    getAllProcessflowController
                                        .processflowList[0].questionsData;
                                if (accessPointData!.isNotEmpty) {
                                  var data = accessPointData[index];
                                  return Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5.0),
                                            builsTitleWidget(
                                                data.questionText.toString()),
                                            const SizedBox(height: 5.0),
                                            data.inputType == "checkbox"
                                                ? buildCheckBoxwidget(
                                                    data.choice, index)
                                                : buildDropdownwidget(
                                                    data.choice)
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      "No ProcessFlow",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 15,
                                          fontFamily: kCircularStdMedium),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.width > 500 ? 600 : Get.width - 20,
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
                        if (processFlowData!.isDocument == 1) {
                          Get.to(() => ReviewDocumentPage(
                                accessPointData: processFlowData,
                              ));
                        } else if (processFlowData.isPhoto == 1) {
                          Get.toNamed(Routes.takePhotoPage);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownwidget(dueData) {
    List<String> dropDownList = dueData.split(',');
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          if (dropDownList.isNotEmpty) {
            List<String> uniqueDropDownList = dropDownList.toSet().toList();
            if (!uniqueDropDownList.contains(dropdownValue)) {
              dropdownValue = uniqueDropDownList.first;
            }
            return Container(
              width: Get.width > 500 ? 600 : Get.width - 30,
              decoration: BoxDecoration(
                border: Border.all(color: kBorderColor),
                borderRadius: BorderRadius.circular(25),
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 15, right: 15),
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
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: uniqueDropDownList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "No dropdown",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                    fontFamily: kCircularStdMedium),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildCheckBoxwidget(dueData, int index) {
    List<String> checkBoxList = dueData.split(',');

    // Initialize isCheckedList for the specific index if not already initialized
    if (!isCheckedMap.containsKey(index)) {
      isCheckedMap[index] = List<bool>.filled(checkBoxList.length, false);
    }

    // late List<String> checkBoxList;
    // late List<bool> isCheckedList;

    // checkBoxList = dueData.split(',');
    // isCheckedList = List<bool>.filled(checkBoxList.length, false);

    // List<String> checkBoxList = dueData.split(',');
    // //List<bool> isCheckedList = [];
    // List<bool> isCheckedList = List<bool>.filled(checkBoxList.length, false);
    // // isCheckedList = List<bool>.filled(checkBoxList.length, false);

    return SizedBox(
        height: 50,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: checkBoxList.length,
          itemBuilder: (context, checkBoxIndex) {
            if (checkBoxList.isNotEmpty) {
              return Row(
                children: [
                  Checkbox(
                    value: isCheckedMap[index]![checkBoxIndex],
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        isCheckedMap[index]![checkBoxIndex] = value ?? false;
                      });
                    },
                  ),
                  Text(
                    checkBoxList[checkBoxIndex],
                    style: const TextStyle(
                        fontSize: 14.0, fontFamily: kCircularStdNormal),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "No dropdown",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontFamily: kCircularStdMedium),
                ),
              );
            }
          },
        ));
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
