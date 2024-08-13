import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../controller/processflow_conroller.dart';
import '../../controller/visitor_types_controller.dart';
import '../Auth/login.dart';
import '../../routes/app_pages.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/accesspoint_controller.dart';
import '../CompanyInfo/company_info.dart';
import '../ProcessFlow/process_flow.dart';
import '../Question/question.dart';
import '../ReviewDocument/review_document.dart';
import '../TakePhoto/take_photo.dart';
import '../TapYourCard/tap_your_card.dart';
import '../widgets/thankyou_widget.dart';

class AccessPointPage extends StatefulWidget {
  const AccessPointPage({super.key});

  @override
  State<AccessPointPage> createState() => _AccessPointPageState();
}

class _AccessPointPageState extends State<AccessPointPage> {
  final GetAllAccessPointController getAllAccessPointController =
      Get.put(GetAllAccessPointController());
  final GetAllVisitorTypesController getAllVisitorTypesController =
      Get.put(GetAllVisitorTypesController());
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final double width = Get.width;
  List<String> screensName = [];
  bool checkData = false;
  @override
  void initState() {
    super.initState();
    ever(getAllAccessPointController.accessPointList, (_) {
      setState(() {
        checkData = getAllAccessPointController.accessPointList.isNotEmpty &&
            getAllAccessPointController
                .accessPointList[0].accesspoints!.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            color: kTapColor,
                            child: const Center(
                                child: Text(
                              "i-Visits",
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width > 500 ? 600 : Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: checkData ? 15 : 0),
                checkData
                    ? const Text(
                        "Tap below on the Access Point this device \nwill be located in.",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: kCircularStdMedium,
                            fontSize: 15),
                        textAlign: TextAlign.center)
                    : Container(),
                const SizedBox(height: 15),
                Expanded(
                  child: Obx(
                    () {
                      if (getAllAccessPointController.isLoading.value) {
                        return Container(
                          color: kBackGroundColor,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kSelectedIconColor,
                            ),
                          ),
                        );
                      } else {
                        if (getAllAccessPointController
                            .accessPointList.isEmpty) {
                          return Center(
                            child: SizedBox(
                              width: Get.width - 80,
                              child: const Text(
                                "There are NO active Access Points available. Please consult with your i-Visits Administrator.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                    fontFamily: kCircularStdMedium),
                              ),
                            ),
                          );
                        } else {
                          if (getAllAccessPointController
                              .accessPointList[0].accesspoints!.isEmpty) {
                            return Center(
                              child: SizedBox(
                                width: Get.width - 80,
                                child: const Text(
                                  "There are NO active Access Points available. Please consult with your i-Visits Administrator.",
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
                              itemCount: getAllAccessPointController
                                  .accessPointList[0].accesspoints!.length,
                              itemBuilder: (context, index) {
                                var accessPointData =
                                    getAllAccessPointController
                                        .accessPointList[0].accesspoints;

                                if (accessPointData!.isNotEmpty) {
                                  var data = accessPointData[index];

                                  return buildButtonWidget(
                                      data.name.toString(), data.iD);
                                } else {
                                  return const Center(
                                    child: Text(
                                      "There are NO active Access Points available. Please consult with your i-Visits Administrator.",
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
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void saveListToLocal(List<dynamic> list) {
    getStorage.write('apiList', list);
  }

  buildButtonWidget(String name, id) {
    Size size = MediaQuery.of(context).size;
    checkData = true;
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18.0, top: 10, bottom: 25),
      child: SizedBox(
          width: size.width > 500 ? 100 : Get.width - 50,
          height: 70,
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              getStorage.write('accessPoint', name);
              getStorage.write('accessPointId', id);
              getAllVisitorTypesController.fetchAllVisitorTypes();
              Future.delayed(const Duration(seconds: 2), () async {
                var visitorTypes =
                    getAllVisitorTypesController.visitorList[0].visitortypes;
                if (visitorTypes!.length > 1) {
                  Get.toNamed(Routes.visitoTypePage);
                } else {
                  getStorage.write('visitorTypeId', visitorTypes[0].iD);
                  getAllProcessflowController.fetchAllProcessFlow();

                  Future.delayed(const Duration(seconds: 2), () async {
                    screensName.clear();
                    var processScreens = getAllProcessflowController
                            .processflowList[0].screens ??
                        [];
                    if (processScreens.isNotEmpty) {
                      for (var screen in processScreens) {
                        screensName.add(screen.screenName.toString());
                      }
                    }

                    if (processScreens.isEmpty) {
                      if (getAllProcessflowController
                              .processflowList[0].welcomeMsgData ==
                          null) {
                        if (getAllProcessflowController
                                .processflowList[0].successMsgData ==
                            null) {
                          Get.to(() => const ThankyouWidget());
                        } else {
                          Get.toNamed(Routes.thankYouPage);
                        }
                      } else {
                        Get.toNamed(Routes.welcomePage);
                      }
                    } else {
                      var checkAuthenticate =
                          screensName.contains("Authenticate");
                      if (checkAuthenticate) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TapYourCardPage(
                                text: visitorTypes[0].authMethod),
                          ),
                        );
                      } else {
                        saveListToLocal(screensName);
                        var screenIndex = screensName[0];
                        if (getAllProcessflowController
                                .processflowList[0].welcomeMsgData ==
                            null) {
                          if (screenIndex == "Personal Info") {
                            Get.to(() => const ProcessFlowPage(
                                  index: 1,
                                ));
                          } else if (screenIndex == "Document") {
                            Get.to(() => const ReviewDocumentPage(
                                  index: 1,
                                ));
                          } else if (screenIndex == "Photo") {
                            Get.to(() => const TakePhotoPage(
                                  index: 1,
                                ));
                          } else if (screenIndex == "Question") {
                            Get.to(() => const QuestionPage(
                                  index: 1,
                                ));
                          } else if (screenIndex == "Company Info") {
                            Get.to(() => const CompanyInfoPage(
                                  index: 1,
                                ));
                          } else {
                            if (getAllProcessflowController
                                    .processflowList[0].successMsgData ==
                                null) {
                              Get.to(() => const ThankyouWidget());
                            } else {
                              Get.toNamed(Routes.thankYouPage);
                            }
                          }
                        } else {
                          Get.toNamed(Routes.welcomePage);
                        }
                      }
                    }
                  });
                }
              });
            },
            child: Text(
              name,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                  fontFamily: kCircularStdMedium),
            ),
          )),
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
