import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../Auth/login.dart';
import '../Question/question.dart';
import '../../routes/app_pages.dart';
import '../TakePhoto/take_photo.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../ProcessFlow/process_flow.dart';
import '../../../config/constant/constant.dart';
import '../ReviewDocument/review_document.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String accessPoint = "";
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  late VideoPlayerController _controller;
  bool showOverlay = false, _isPlaying = false, isBuffering = false;
  double _sliderValue = 0.0;
  String extension = "";
  @override
  void initState() {
    String ext = getAllProcessflowController
        .processflowList[0].welcomeMsgData!.imageFile
        .toString()
        .split('.')
        .last
        .toLowerCase();
    var data = getStorage.read('accessPoint') ?? "";
    setState(() {
      accessPoint = data;
      extension = ext;
    });
    if (extension != "jpg") {
      Future.delayed(const Duration(milliseconds: 180), () async {
        showOverlay = false;
        _isPlaying = true;
      });
      _controller = VideoPlayerController.networkUrl(Uri.parse(
          getAllProcessflowController
              .processflowList[0].welcomeMsgData!.imageFile
              .toString()))
        ..initialize().then((_) {
          setState(() {});
        });
      _controller.addListener(() {
        if (_controller.value.isPlaying) {
          setState(() {
            _sliderValue = _controller.value.position.inMilliseconds.toDouble();
          });
        }
      });
      _controller.play();
      Future.delayed(const Duration(milliseconds: 180), () async {
        showOverlay = false;
        _isPlaying = true;
      });
    }
    super.initState();
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
            Navigator.of(context).pop();
          },
          showLogoutButton: true,
          onLogoutPressed: () {
            logoutConfirmationDialog();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(accessPoint,
                  style: const TextStyle(
                      color: kBlueColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 13)),
              Text("Today is $day, $formattedDate",
                  style: const TextStyle(
                      color: kBlueColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 13)),
              const SizedBox(height: 15),
              Image.asset(
                "assets/i-Visits_logo.png",
                fit: BoxFit.cover,
                scale: 1.5,
              ),
              const SizedBox(height: 25),
              Text(
                  getAllProcessflowController
                      .processflowList[0].welcomeMsgData!.text
                      .toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontFamily: kCircularStdMedium,
                      fontSize: 16)),
              const SizedBox(height: 25),
              getAllProcessflowController
                          .processflowList[0].welcomeMsgData!.imageFile
                          .toString() ==
                      ""
                  ? Container()
                  : extension == "jpg" ||
                          extension == "png" ||
                          extension == "jpeg"
                      ? SizedBox(
                          width: Get.width > 500 ? 600 : Get.width,
                          height: 220,
                          child: Image.network(
                            getAllProcessflowController
                                .processflowList[0].welcomeMsgData!.imageFile
                                .toString(),
                            scale: 2,
                          ),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: Get.width > 500 ? 600 : Get.width,
                              height: 220,
                              child: Center(
                                child: _controller.value.isInitialized
                                    ? VideoPlayer(_controller)
                                    : Container(),
                              ),
                            ),
                            SizedBox(
                                width: Get.width > 500 ? 600 : Get.width,
                                height: 220,
                                child: _buildControls()),
                          ],
                        ),
              // const SizedBox(height: 10),
              // const Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: kDiscriptionColor,
              //         fontFamily: kCircularStdMedium,
              //         fontSize: 14)),
              // const Text(
              //     "If you have a QR Code, tap on the SCAN button to check-in.",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: kPrimaryColor,
              //         fontFamily: kCircularStdMedium,
              //         fontSize: 15)),
              const SizedBox(height: 20),
              // SizedBox(
              //   width: Get.width > 500 ? 600 : Get.width - 95,
              //   child: CupertinoButton(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     borderRadius: BorderRadius.circular(25),
              //     color: const Color(0xFFB9F73E),
              //     child: const Text("I have QR Code to scan",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: kPrimaryColor,
              //             fontFamily: kCircularStdMedium,
              //             fontSize: 14)),
              //     onPressed: () {
              //       Get.toNamed(Routes.qrScannerPage);
              //     },
              //   ),
              // ),
              // const SizedBox(height: 10),
              // SizedBox(
              //   width: Get.width > 500 ? 600 : Get.width - 95,
              //   child: CupertinoButton(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     borderRadius: BorderRadius.circular(25),
              //     color: const Color(0xFFB9F73E),
              //     child: const Text("I know my badge ID",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: kPrimaryColor,
              //             fontFamily: kCircularStdMedium,
              //             fontSize: 14)),
              //     onPressed: () {
              //       Get.toNamed(Routes.forgotbadgeIdPage);
              //     },
              //   ),
              // ),
              // const SizedBox(height: 30),
              // const Text("Otherwise, tap on NEXT button.",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: kPrimaryColor,
              //         fontFamily: kCircularStdMedium,
              //         fontSize: 15)),
              // const SizedBox(height: 6),
              SizedBox(
                width: Get.width > 500 ? 600 : Get.width - 95,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(25),
                  color: kPrimaryColor,
                  child: const Text("Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 14)),
                  onPressed: () {
                    var screenList =
                        getStorage.read<List<dynamic>>('apiList') ?? [];
                    var screenIndex = screenList[0];
                    if (screenIndex == "Basic Info") {
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
                    } else {
                      if (getAllProcessflowController
                              .processflowList[0].successMsgData ==
                          null) {
                        Get.to(() => const ThankyouWidget());
                      } else {
                        Get.toNamed(Routes.thankYouPage);
                      }
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

  Widget _buildControls() {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          showOverlay = !showOverlay;
        });
      },
      child: AnimatedOpacity(
        opacity: showOverlay ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.only(bottom: 8, left: 11, right: 10),
          color: const Color(0xFF121330).withOpacity(0.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(25),
                        color: kWhiteColor,
                        child: SizedBox(
                          width: size.width > 500 ? 50 : 40,
                          height: size.width > 500 ? 50 : 40,
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: kPrimaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (showOverlay) {
                            setState(() {
                              _isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                              _isPlaying = !_isPlaying;
                              showOverlay = !showOverlay;
                            });
                            Future.delayed(const Duration(milliseconds: 2000),
                                () async {
                              showOverlay = !showOverlay;
                            });
                          } else {
                            setState(() {
                              showOverlay = !showOverlay;
                            });
                          }
                        }),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/icons/varticalline.png",
                    color: kTextSecondaryColor,
                    fit: BoxFit.cover,
                    height: 29,
                    width: 1.2,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _formatDuration(_controller.value.position),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: kCircularStdNormal),
                  ),
                  SizedBox(
                    width: 462,
                    height: 20,
                    child: Slider(
                      activeColor: const Color(0xFF3D8DF5),
                      inactiveColor: kWhiteColor,
                      value: _sliderValue,
                      min: 0.0,
                      max: _controller.value.duration.inMilliseconds.toDouble(),
                      onChanged: _onSliderChange,
                    ),
                  ),
                  Text(
                    _formatDuration(_controller.value.duration),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: kCircularStdNormal),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  void _onSliderChange(double value) {
    if (showOverlay) {
      setState(() {
        _sliderValue = value;
        _controller.seekTo(Duration(milliseconds: value.toInt()));
        _isPlaying = true;
        _controller.play();
      });
      Future.delayed(const Duration(milliseconds: 5000), () async {
        setState(() {
          showOverlay = !showOverlay;
        });
      });
    } else {
      setState(() {
        showOverlay = !showOverlay;
      });
    }
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
