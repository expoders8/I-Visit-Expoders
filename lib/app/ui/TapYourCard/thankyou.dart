import 'package:flutter/material.dart';
import 'package:ivisit/config/constant/color_constant.dart';
import 'package:ivisit/config/constant/font_constant.dart';
import 'package:lottie/lottie.dart';

class ThankyouRFIEADSPage extends StatefulWidget {
  const ThankyouRFIEADSPage({super.key});

  @override
  State<ThankyouRFIEADSPage> createState() => _ThankyouRFIEADSPageState();
}

class _ThankyouRFIEADSPageState extends State<ThankyouRFIEADSPage> {
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
