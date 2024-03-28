import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  File? imageFile;
  late VideoPlayerController _controller;
  bool showOverlay = false, _isPlaying = false, isBuffering = false;
  double _sliderValue = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 180), () async {
      showOverlay = false;
      _isPlaying = true;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8'))
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leadingWidth: 100,
        leading: CupertinoButton(
          child: const Text(
            "BACK",
            style: TextStyle(
                color: kWhiteColor,
                fontFamily: kCircularStdMedium,
                fontSize: 14),
          ),
          onPressed: () {
            Get.back();
          },
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
            const Text("FRONT DESK",
                style: TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            const Text("Today is Saturday, October 28, 2022 at 8:30 am.",
                style: TextStyle(
                    color: kBlueColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 14)),
            const SizedBox(height: 52),
            Image.asset(
              "assets/i-Visits_logo.png",
              fit: BoxFit.cover,
              scale: 1.5,
            ),
            const SizedBox(height: 80),
            const Text("You have checked-in! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 16)),
            const Text("Thank you!  (customizable screen)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: kCircularStdMedium,
                    fontSize: 16)),
            const SizedBox(height: 120),
            Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  height: 220,
                  child: Center(
                    child: _controller.value.isInitialized
                        ? VideoPlayer(_controller)
                        : Container(),
                  ),
                ),
                SizedBox(
                    width: Get.width, height: 220, child: _buildControls()),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width - 20,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(25),
                color: kPrimaryColor,
                child: const Text("Done",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kWhiteColor,
                        fontFamily: kCircularStdMedium,
                        fontSize: 14)),
                onPressed: () {},
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
                    width: 184,
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
