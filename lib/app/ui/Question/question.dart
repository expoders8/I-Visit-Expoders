import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Auth/login.dart';
import '../../routes/app_pages.dart';
import '../TakePhoto/take_photo.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../CompanyInfo/company_info.dart';
import '../ProcessFlow/process_flow.dart';
import '../TapYourCard/tap_your_card.dart';
import '../../models/processflow_model.dart';
import '../ReviewDocument/review_document.dart';
import '../../../config/constant/constant.dart';
import '../../controller/visiter_controller.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class QuestionPage extends StatefulWidget {
  final ProcessFlowData? accessPointData;
  final String? text;
  final int? index;
  const QuestionPage({super.key, this.accessPointData, this.text, this.index});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedIndex = 3, selectedVaccinatIndex = 3;
  TextEditingController descriptionController = TextEditingController();
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final visitorController = Get.put(VisiterController());
  bool isFormSubmitted = false, valuefirst = false, allUnchecked = true;
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
  String accessPoint = "";
  Map<int, List<bool>> isCheckedMap = {};
  Map<int, String> dropdownValues = {};
  List<Map<String, dynamic>> selectedAnswers = [];

  @override
  void initState() {
    getItemAtIndex();
    var data = getStorage.read('accessPoint') ?? "";
    setState(() {
      accessPoint = data;
    });
    super.initState();
  }

  String getItemAtIndex() {
    var items = getStorage.read<List<dynamic>>('apiList') ?? [];
    int index = widget.index!;
    if (index >= 0 && index < items.length) {
      return items[index];
    } else {
      return 'Index out of range';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd yyyy').format(now);
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
            if (widget.text == "scan") {
              Get.offAll(() => const TapYourCardPage(
                    text: "back",
                  ));
            } else {
              Navigator.of(context).pop();
            }
          },
          showLogoutButton: true,
          onLogoutPressed: () {
            logoutConfirmationDialog();
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
              Text(accessPoint,
                  style: const TextStyle(
                      color: kBlueColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 13)),
              Text("Today is $day, $formattedDate",
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
                                                    data.choice, index, data.iD)
                                                : buildDropdownWidget(
                                                    data.choice,
                                                    index,
                                                    data.iD!)
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
                        if (selectedAnswers.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select value'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          if (dropdownValues.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select value'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (!validateAllQuestions()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select at least one checkbox for each question.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            String selectedItem = getItemAtIndex();
                            var screenIndex = widget.index! + 1;

                            if (selectedItem == "Personal Info") {
                              Get.to(() => ProcessFlowPage(
                                    index: screenIndex,
                                  ));
                            } else if (selectedItem == "Document") {
                              Get.to(
                                  () => ReviewDocumentPage(index: screenIndex));
                            } else if (selectedItem == "Photo") {
                              Get.to(() => TakePhotoPage(index: screenIndex));
                            } else if (selectedItem == "Question") {
                              Get.to(() => QuestionPage(index: screenIndex));
                            } else if (selectedItem == "Company Info") {
                              Get.to(() => CompanyInfoPage(index: screenIndex));
                            } else {
                              if (getAllProcessflowController
                                      .processflowList[0].successMsgData ==
                                  null) {
                                Get.to(() => const ThankyouWidget());
                              } else {
                                Get.toNamed(Routes.thankYouPage);
                              }
                            }
                          }
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

  Widget buildDropdownWidget(dueData, int index, int questionId) {
    List<String> dropDownList = dueData.split(',');
    List<String> uniqueDropDownList = dropDownList.toSet().toList();

    // Adding "Select Value" as the default option
    if (!uniqueDropDownList.contains("Select Value")) {
      uniqueDropDownList.insert(0, "Select Value");
    }

    if (!dropdownValues.containsKey(index) ||
        !uniqueDropDownList.contains(dropdownValues[index])) {
      dropdownValues[index] = "Select Value";
    }

    return SizedBox(
      height: 50,
      child: Container(
        width: Get.width > 500 ? 600 : Get.width - 30,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor),
          borderRadius: BorderRadius.circular(25),
        ),
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 15, right: 15),
          value: dropdownValues[index],
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
              dropdownValues[index] = value!;
              updateSelectedAnswers(questionId, value);
            });
          },
          items:
              uniqueDropDownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  void updateSelectedAnswers(int questionId, String selectedValue) {
    bool found = false;
    for (var answer in selectedAnswers) {
      if (answer['questionId'] == questionId) {
        answer['questionAnswer'] = [selectedValue];
        found = true;
        break;
      }
    }
    if (!found) {
      selectedAnswers.add({
        'questionId': questionId,
        'questionAnswer': [selectedValue],
      });
    }

    selectedAnswers.forEach((answer) {
      print(
          'questionId: ${answer['questionId']}, questionAnswer: ${answer['questionAnswer']}');
    });
    visitorController.saveQue(selectedAnswers);
  }

  Widget buildCheckBoxwidget(dueData, int index, id) {
    List<String> checkBoxList = dueData.split(',');

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
                      // getSelectedCheckBoxes();
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

  getSelectedCheckBoxes() {
    selectedAnswers.clear();
    setState(() {
      allUnchecked = true;
    });

    if (!validateAllQuestions()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content:
      //         Text('Please select at least one checkbox for each question.'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      return;
    }

    isCheckedMap.forEach((index, checkedList) {
      var questionData =
          getAllProcessflowController.processflowList[0].questionsData![index];
      List<String> checkBoxList = questionData.choice!.split(',');
      List<String> selectedNames = [];

      for (int i = 0; i < checkedList.length; i++) {
        if (checkedList[i]) {
          selectedNames.add(checkBoxList[i]);
          setState(() {
            allUnchecked = false;
          });
        }
      }

      if (selectedNames.isNotEmpty) {
        selectedAnswers.add({
          'questionId': questionData.iD,
          'questionAnswer': selectedNames,
        });
      }
    });
    selectedAnswers.forEach((answer) {
      print(
          'questionId: ${answer['questionId']}, questionAnswer: ${answer['questionAnswer']}');
    });
    visitorController.saveQue(selectedAnswers);
  }

  bool validateAllQuestions() {
    bool allValid = true;
    isCheckedMap.forEach((index, checkedList) {
      if (checkedList.every((checked) => !checked)) {
        allValid = false;
      }
    });
    return allValid;
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
