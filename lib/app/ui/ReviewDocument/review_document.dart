import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../models/processflow_model.dart';
import '../../routes/app_pages.dart';

class ReviewDocumentPage extends StatefulWidget {
  final ProcessFlowData? accessPointData;
  const ReviewDocumentPage({super.key, this.accessPointData});

  @override
  State<ReviewDocumentPage> createState() => _ReviewDocumentPageState();
}

class _ReviewDocumentPageState extends State<ReviewDocumentPage> {
  String accessPoint = "";
  bool signCheck = false;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: kPrimaryColor,
    onDrawStart: () => {
      log('onDrawStart called!'),
    },
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    _controller
      ..addListener(() => setState(
            () {
              signCheck = true;
              log('Value changed');
            },
          ))
      ..onDrawEnd = () => setState(
            () {},
          );
    var data = getStorage.read('accessPoint') ?? "";
    setState(() {
      accessPoint = data;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                              "Back",
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
                          color: kTapColor3,
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
      body: SingleChildScrollView(
        child: Container(
          height: Get.height - 100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(accessPoint,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  Text("Today is $day, $formattedDate at $formattedTime.",
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  const SizedBox(height: 52),
                  Image.asset(
                    "assets/i-Visits_logo.png",
                    fit: BoxFit.cover,
                    scale: 1.5,
                  ),
                  SizedBox(height: Get.width > 500 ? 10 : 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      builsTitleWidget("Read and review the document  below."),
                      SizedBox(height: Get.width > 500 ? 10 : 25),
                      const Text(
                        "Scroll down to sign",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: kCircularStdMedium,
                            fontSize: 14),
                      ),
                      Stack(
                        children: [
                          Signature(
                            key: const Key('signature'),
                            controller: _controller,
                            height: Get.width > 500 ? 200 : 300,
                            width: Get.width > 500 ? 500 : Get.width,
                            backgroundColor: Colors.grey[300]!,
                          ),
                          signCheck
                              ? Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        _controller.clear();
                                        signCheck = false;
                                      });
                                    },
                                  ))
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: Get.width > 500 ? 600 : Get.width - 20,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                  child: const Text("Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {
                    if (widget.accessPointData!.isPhoto == 1) {
                      Get.toNamed(Routes.takePhotoPage);
                    } else {
                      Get.toNamed(Routes.thankYouPage);
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
}
