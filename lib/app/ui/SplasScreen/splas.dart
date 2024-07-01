import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ivisit/config/constant/color_constant.dart';

import '../Auth/login.dart';
import '../AccessPoint/access_point.dart';
import '../../../config/constant/constant.dart';
import '../../controller/accesspoint_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetAllAccessPointController getAllAccessPointController =
      Get.put(GetAllAccessPointController());
  @override
  void initState() {
    var isviewed = getStorage.read('onBoard') ?? 0;
    getAllAccessPointController.fetchAllAccessPoint();
    var data = getStorage.read('user');
    if (data != null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (isviewed == 0) {
          Get.offAll(() => const LoginPage());
        } else {
          // if (orgId == "RFIDEAS") {
          //   Get.offAll(() => const TapYourCardPage());
          // } else {
          Get.offAll(() => const AccessPointPage());
          // }
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const LoginPage());
      });
    }

    // Future.delayed(const Duration(seconds: 2), () {
    //   if (isviewed == 0) {
    //     Get.offAll(() => const LoginPage());
    //   } else {
    //     if (orgId == "RFIDEAS") {
    //       Get.offAll(() => const TapYourCardPage());
    //     } else {
    //       Get.offAll(() => const AccessPointPage());
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundColor,
        body: Center(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 1.0, end: 1.5),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Image.asset(
              "assets/i-Visits_logo.png",
              fit: BoxFit.cover,
              scale: 2,
            ),
          ),
        ));
  }
}
