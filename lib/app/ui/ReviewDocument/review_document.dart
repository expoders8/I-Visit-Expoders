import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:signature/signature.dart';

import '../Auth/login.dart';
import '../Question/question.dart';
import '../../routes/app_pages.dart';
import '../TakePhoto/take_photo.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../ProcessFlow/process_flow.dart';
import '../TapYourCard/tap_your_card.dart';
import '../../models/processflow_model.dart';
import '../../../config/constant/constant.dart';
import '../../controller/visiter_controller.dart';
import '../../../config/constant/font_constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/color_constant.dart';

class ReviewDocumentPage extends StatefulWidget {
  final ProcessFlowData? accessPointData;
  final String? text;
  final int? index;
  const ReviewDocumentPage(
      {super.key, this.accessPointData, this.text, this.index});

  @override
  State<ReviewDocumentPage> createState() => _ReviewDocumentPageState();
}

class _ReviewDocumentPageState extends State<ReviewDocumentPage> {
  String accessPoint = "";
  bool signCheck = false;
  final visitorController = Get.put(VisiterController());
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
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
    getItemAtIndex();
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

  String getItemAtIndex() {
    var items = getStorage.read<List<dynamic>>('apiList') ?? [];
    int index = widget.index!;
    if (index >= 0 && index < items.length) {
      return items[index];
    } else {
      return 'Index out of range';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd yyyy').format(now);
    String day = DateFormat('EEEE').format(now);
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CommonAppBar(
          width: MediaQuery.of(context).size.width,
          showBackButton: true,
          text: "Back",
          onBackPressed: () {
            if (widget.text == "scan") {
              Get.offAll(() => const TapYourCardPage(
                    text: "back",
                  ));
            } else {
              Navigator.of(context).pop();
            }
          },
          showLogoutButton: true,
          onLogoutPressed: () {
            logoutConfirmationDialog();
          },
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
                  Text("Today is $day, $formattedDate",
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  const SizedBox(height: 15),
                  Image.asset(
                    "assets/i-Visits_logo.png",
                    fit: BoxFit.cover,
                    scale: 1.5,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(
                        height: 5,
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
                                  right: Get.width > 500 ? 240 : 0,
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
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final Uint8List? data = await _controller.toPngBytes();
                      if (data != null) {
                        final String base64Signature = base64Encode(data);
                        // Save the signature to your desired location
                        visitorController.saveDoc(base64Signature);
                        String selectedItem = getItemAtIndex();
                        var screenIndex = widget.index! + 1;

                        if (selectedItem == "Basic Info") {
                          Get.to(() => ProcessFlowPage(
                                index: screenIndex,
                              ));
                        } else if (selectedItem == "Document") {
                          Get.to(() => ReviewDocumentPage(index: screenIndex));
                        } else if (selectedItem == "Photo") {
                          Get.to(() => TakePhotoPage(index: screenIndex));
                        } else if (selectedItem == "Question") {
                          Get.to(() => QuestionPage(index: screenIndex));
                        } else {
                          if (getAllProcessflowController
                                  .processflowList[0].successMsgData ==
                              null) {
                            Get.to(() => const ThankyouWidget());
                          } else {
                            Get.toNamed(Routes.thankYouPage);
                          }
                        }
                      }
                    } else {
                      // Show a message to the user indicating that the signature is required
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Signature Required'),
                              Text(
                                  'Please provide a signature before proceeding'),
                            ],
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
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
