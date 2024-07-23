import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../../config/provider/loader_provider.dart';
import '../../controller/processflow_conroller.dart';
import '../../services/visiter_service.dart';
import '../widgets/comman_appbar.dart';
import '../AccessPoint/access_point.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({
    super.key,
  });

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  File? imageFile;
  String accessPoint = "";
  late VideoPlayerController _controller;
  bool showOverlay = false, _isPlaying = false, isBuffering = false;
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  VisitorService visiterService = VisitorService();
  String extension = "";
  double _sliderValue = 0.0;
  @override
  void initState() {
    super.initState();
    String ext = "filePath".split('.').last.toLowerCase();
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
              .processflowList[0].successMsgData!.imageFile
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
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);
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
        ),
      ),
      body: Container(
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
                    fontSize: 14)),
            Text("Today is $day, $formattedDate",
                style: const TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            SizedBox(height: Get.width > 500 ? 15 : 52),
            Image.asset(
              "assets/i-Visits_logo.png",
              fit: BoxFit.cover,
              scale: 1.5,
            ),
            SizedBox(height: Get.width > 500 ? 25 : 80),
            Text(
                getAllProcessflowController
                    .processflowList[0].successMsgData!.text
                    .toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 16)),
            SizedBox(height: Get.width > 500 ? 20 : 120),
            getAllProcessflowController
                        .processflowList[0].successMsgData!.imageFile
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
                              .processflowList[0].successMsgData!.imageFile
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
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width > 500 ? 600 : Get.width - 20,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(25),
                color: kPrimaryColor,
                child: const Text("Done",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kWhiteColor,
                        fontFamily: kCircularStdMedium,
                        fontSize: 14)),
                onPressed: () {
                  LoaderX.show(context, 60.0, 60.0);
                  visiterService
                      .saveVisit(getAllProcessflowController
                          .processflowList[0].processFlowData!.visitorTypeID
                          .toString())
                      .then((value) => {
                            if (value)
                              {
                                LoaderX.hide(),
                                Get.offAll(() => const AccessPointPage())
                              }
                          });
                },
              ),
            ),
          ],
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
}
