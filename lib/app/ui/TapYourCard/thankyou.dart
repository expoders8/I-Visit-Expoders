import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivisit/app/ui/TapYourCard/tap_your_card.dart';
import 'package:ivisit/config/constant/color_constant.dart';
import 'package:ivisit/config/constant/font_constant.dart';
import 'package:lottie/lottie.dart';

class ThankyouRFIEADSPage extends StatefulWidget {
  final String? code;
  const ThankyouRFIEADSPage({super.key, this.code});

  @override
  State<ThankyouRFIEADSPage> createState() => _ThankyouRFIEADSPageState();
}

class _ThankyouRFIEADSPageState extends State<ThankyouRFIEADSPage> {
  @override
  void initState() {
    autoNavigateScreen();
    super.initState();
  }

  autoNavigateScreen() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TapYourCardPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/checkjson.json',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Thank You!",
            style: TextStyle(
                color: kPrimaryColor,
                fontFamily: kCircularStdMedium,
                fontSize: 28),
          ),
          const Text(
            "You have successfully registered your visit!!",
            style: TextStyle(
                color: kSecondaryPrimaryColor,
                fontFamily: kCircularStdNormal,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
