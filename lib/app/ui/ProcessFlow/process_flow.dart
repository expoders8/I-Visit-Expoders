import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ivisit/app/ui/Question/question.dart';

import '../../../config/constant/constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../routes/app_pages.dart';
import '../Auth/login.dart';
import '../widgets/comman_appbar.dart';
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
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> purpose = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
  String purposeValue = "One";
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
    final double width = Get.width;
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
              SizedBox(
                height: Get.height,
                width: Get.width,
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
                      if (getAllProcessflowController.processflowList.isEmpty) {
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
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            var accessPointData = getAllProcessflowController
                                .processflowList[0].processFlowData;
                            var queData = getAllProcessflowController
                                .processflowList[0].questionsData;

                            if (queData!.isNotEmpty) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      accessPointData!.isName == 1
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    builsTitleWidget(
                                                        "Firstname"),
                                                    const SizedBox(height: 5.0),
                                                    SizedBox(
                                                      width: Get.width > 500
                                                          ? 300
                                                          : Get.width / 2.2,
                                                      child:
                                                          CustomTextFormField(
                                                        hintText: 'Firstname',
                                                        maxLines: 1,
                                                        ctrl: emailController,
                                                        name: "firstname",
                                                        formSubmitted:
                                                            isFormSubmitted,
                                                        validationMsg:
                                                            'Firstname is Required',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 8.600),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    builsTitleWidget(
                                                        "Lastname"),
                                                    const SizedBox(height: 5.0),
                                                    SizedBox(
                                                      width: Get.width > 500
                                                          ? 300
                                                          : Get.width / 2.2,
                                                      child:
                                                          CustomTextFormField(
                                                        hintText: 'Lastname',
                                                        maxLines: 1,
                                                        ctrl: emailController,
                                                        name: "lastname",
                                                        formSubmitted:
                                                            isFormSubmitted,
                                                        validationMsg:
                                                            'Lastname is Required',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      accessPointData.isEmail == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isEmail == 1
                                          ? builsTitleWidget("Email")
                                          : Container(),
                                      accessPointData.isEmail == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isEmail == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Email',
                                                maxLines: 1,
                                                ctrl: emailController,
                                                name: "email",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Email is Required',
                                              ),
                                            )
                                          : Container(),
                                      accessPointData.isCompany == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isCompany == 1
                                          ? builsTitleWidget("Company")
                                          : Container(),
                                      accessPointData.isCompany == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isCompany == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Company Name',
                                                maxLines: 1,
                                                ctrl: emailController,
                                                name: "Companyname",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Company Name is Required',
                                              ),
                                            )
                                          : Container(),
                                      accessPointData.isPhone == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isPhone == 1
                                          ? builsTitleWidget("Phone number")
                                          : Container(),
                                      accessPointData.isPhone == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isPhone == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Phone number',
                                                maxLines: 1,
                                                ctrl: badgeIdController,
                                                name: "phoneno",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Phone number is Required',
                                              ),
                                            )
                                          : Container(),
                                      accessPointData.isTitle == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isTitle == 1
                                          ? builsTitleWidget("Title")
                                          : Container(),
                                      accessPointData.isTitle == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isTitle == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Title',
                                                maxLines: 1,
                                                ctrl: badgeIdController,
                                                name: "title",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Title is Required',
                                              ),
                                            )
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? builsTitleWidget("Host")
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Host',
                                                maxLines: 1,
                                                ctrl: badgeIdController,
                                                name: "host",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Host is Required',
                                              ),
                                            )
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? const SizedBox(height: 12.0)
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? builsTitleWidget("Host")
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? const SizedBox(height: 5.0)
                                          : Container(),
                                      accessPointData.isHost == 1
                                          ? SizedBox(
                                              width: Get.width > 500
                                                  ? 600
                                                  : Get.width,
                                              child: CustomTextFormField(
                                                hintText: 'Host',
                                                maxLines: 1,
                                                ctrl: badgeIdController,
                                                name: "host",
                                                formSubmitted: isFormSubmitted,
                                                validationMsg:
                                                    'Host is Required',
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        width: Get.width > 500
                                            ? 600
                                            : Get.width - 20,
                                        child: CupertinoButton(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: kPrimaryColor,
                                          child: const Text("Next",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontFamily:
                                                      kCircularStdMedium,
                                                  fontSize: 14)),
                                          onPressed: () {
                                            if (accessPointData.isQuestion ==
                                                1) {
                                              Get.to(() => QuestionPage(
                                                  accessPointData:
                                                      accessPointData));
                                            } else if (accessPointData
                                                    .isDocument ==
                                                1) {
                                              Get.toNamed(
                                                  Routes.reviewDocumentPage);
                                            } else if (accessPointData
                                                    .isPhoto ==
                                                1) {
                                              Get.toNamed(Routes.takePhotoPage);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
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
