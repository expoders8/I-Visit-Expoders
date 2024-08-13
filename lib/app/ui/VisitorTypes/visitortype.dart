import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ivisit/app/ui/Question/question.dart';
import 'package:ivisit/app/ui/TakePhoto/take_photo.dart';
import 'package:ivisit/app/ui/TapYourCard/tap_your_card.dart';

import '../Auth/login.dart';
import '../../routes/app_pages.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../CompanyInfo/company_info.dart';
import '../ProcessFlow/process_flow.dart';
import '../ReviewDocument/review_document.dart';
import '../../../config/constant/constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/visitor_types_controller.dart';

class VisitoTypePage extends StatefulWidget {
  const VisitoTypePage({super.key});

  @override
  State<VisitoTypePage> createState() => _AccessPointPageState();
}

class _AccessPointPageState extends State<VisitoTypePage> {
  final GetAllVisitorTypesController getAllVisitorTypesController =
      Get.put(GetAllVisitorTypesController());
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final double width = Get.width;
  List<String> screensName = [];

  @override
  Widget build(BuildContext context) {
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width > 500 ? 600 : Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const Text(
                    "TAP on the button that best describes your purpose \nfor today's visit.",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: kCircularStdMedium,
                        fontSize: 15),
                    textAlign: TextAlign.center),
                const SizedBox(height: 15),
                Expanded(
                  child: Obx(
                    () {
                      if (getAllVisitorTypesController.isLoading.value) {
                        return Container(
                          color: kBackGroundColor,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kSelectedIconColor,
                            ),
                          ),
                        );
                      } else {
                        if (getAllVisitorTypesController.visitorList.isEmpty) {
                          return Center(
                            child: SizedBox(
                              width: Get.width - 80,
                              child: const Text(
                                "No Visitor Types",
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
                            itemCount: getAllVisitorTypesController
                                .visitorList[0].visitortypes!.length,
                            itemBuilder: (context, index) {
                              var accessPointData = getAllVisitorTypesController
                                  .visitorList[0].visitortypes;

                              if (accessPointData!.isNotEmpty) {
                                var data = accessPointData[index];
                                return buildButtonWidget(data.name.toString(),
                                    data.iD, data.authMethod);
                              } else {
                                return const Center(
                                  child: Text(
                                    "No Visitor Types",
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
        ],
      ),
    );
  }

  void saveListToLocal(List<dynamic> list) {
    getStorage.write('apiList', list);
  }

  buildButtonWidget(String name, id, authMethod) {
    Size size = MediaQuery.of(context).size;

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
            getStorage.write('visitorTypeId', id);
            getAllProcessflowController.fetchAllProcessFlow();

            Future.delayed(const Duration(seconds: 2), () async {
              screensName.clear();
              var processScreens =
                  getAllProcessflowController.processflowList[0].screens ?? [];
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
                var checkAuthenticate = screensName.contains("Authenticate");
                if (checkAuthenticate) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TapYourCardPage(text: authMethod),
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
                      Get.to(() => const CompanyInfoPage(index: 1));
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
          },
          child: Text(
            name,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
                fontFamily: kCircularStdMedium),
          ),
        ),
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
