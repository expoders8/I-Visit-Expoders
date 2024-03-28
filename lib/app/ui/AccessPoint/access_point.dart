import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../routes/app_pages.dart';

class AccessPointPage extends StatefulWidget {
  const AccessPointPage({super.key});

  @override
  State<AccessPointPage> createState() => _AccessPointPageState();
}

class _AccessPointPageState extends State<AccessPointPage> {
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
            const Text(
                "Tap below on the Access Point this device \nwill be located in.",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 15),
                textAlign: TextAlign.center),
            const SizedBox(height: 50),
            buildButtonWidget("FRONT DESK"),
            const SizedBox(height: 25),
            buildButtonWidget("SECURITY DESK"),
            const SizedBox(height: 25),
            buildButtonWidget("DELIVERY LOBBY")
          ],
        ),
      ),
    );
  }

  buildButtonWidget(String name) {
    return SizedBox(
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
    );
  }
}
