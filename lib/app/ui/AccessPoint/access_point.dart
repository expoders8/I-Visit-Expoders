import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../controller/accesspoint_controller.dart';
import '../../routes/app_pages.dart';

class AccessPointPage extends StatefulWidget {
  const AccessPointPage({super.key});

  @override
  State<AccessPointPage> createState() => _AccessPointPageState();
}

class _AccessPointPageState extends State<AccessPointPage> {
  final GetAllAccessPointController getAllAccessPointController =
      Get.put(GetAllAccessPointController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 130),
            const Text(
                "Tap below on the Access Point this device \nwill be located in.",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 15),
                textAlign: TextAlign.center),
            const SizedBox(height: 50),
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
                    if (getAllAccessPointController.accessPointList.isEmpty) {
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
                            return buildButtonWidget(data.name.toString());
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
    );
  }

  buildButtonWidget(String name) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18.0, top: 10, bottom: 25),
      child: SizedBox(
        width: Get.width - 50,
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
            Get.toNamed(Routes.welcomePage);
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
}
