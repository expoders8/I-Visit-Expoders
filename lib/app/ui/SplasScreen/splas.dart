import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivisit/config/constant/color_constant.dart';

import '../Auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const LoginPage());
    });
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
