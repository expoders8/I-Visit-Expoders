import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ivisit/app/ui/TapYourCard/tap_your_card.dart';

import '../../controller/processflow_conroller.dart';
import '../../routes/app_pages.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../controller/accesspoint_controller.dart';
import '../Auth/login.dart';
import '../widgets/thankyou_widget.dart';

class AccessPointPage extends StatefulWidget {
  const AccessPointPage({super.key});

  @override
  State<AccessPointPage> createState() => _AccessPointPageState();
}

class _AccessPointPageState extends State<AccessPointPage> {
  final GetAllAccessPointController getAllAccessPointController =
      Get.put(GetAllAccessPointController());
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final double width = Get.width;

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
                const SizedBox(height: 15),
                const Text(
                    "Tap below on the Access Point this device \nwill be located in.",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: kCircularStdMedium,
                        fontSize: 15),
                    textAlign: TextAlign.center),
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
                                "No AccessPoint",
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
                              var accessPointData = getAllAccessPointController
                                  .accessPointList[0].accesspoints;

                              if (accessPointData!.isNotEmpty) {
                                var data = accessPointData[index];
                                return buildButtonWidget(
                                    data.name.toString(), data.iD);
                              } else {
                                return const Center(
                                  child: Text(
                                    "No AccessPoint",
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
                // buildButtonWidget("FRONT DESK"),
                // const SizedBox(height: 25),
                // buildButtonWidget("SECURITY DESK"),
                // const SizedBox(height: 25),
                // buildButtonWidget("DELIVERY LOBBY")
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildButtonWidget(String name, id) {
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
            getStorage.write('accessPoint', name);
            getStorage.write('accessPointId', id);
            getAllProcessflowController.fetchAllProcessFlow();
            Future.delayed(const Duration(seconds: 2), () async {
              var accessPoint = getStorage.read("IsAuthenticate") ?? 0;
              if (accessPoint == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TapYourCardPage(),
                  ),
                );
              } else if (getAllProcessflowController
                      .processflowList[0].welcomeMsgData ==
                  null) {
                if (getAllProcessflowController
                            .processflowList[0].processFlowData!.isName ==
                        0 &&
                    getAllProcessflowController
                            .processflowList[0].processFlowData!.isCompany ==
                        0 &&
                    getAllProcessflowController
                            .processflowList[0].processFlowData!.isEmail ==
                        0 &&
                    getAllProcessflowController
                            .processflowList[0].processFlowData!.isPhone ==
                        0 &&
                    getAllProcessflowController
                            .processflowList[0].processFlowData!.isTitle ==
                        0) {
                  if (getAllProcessflowController
                          .processflowList[0].successMsgData ==
                      null) {
                    Get.to(() => const ThankyouWidget());
                  } else {
                    Get.toNamed(Routes.thankYouPage);
                  }
                } else {
                  Get.toNamed(Routes.processFlowPage);
                }
              } else {
                Get.toNamed(Routes.welcomePage);
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
