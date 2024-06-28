import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ivisit/app/ui/TapYourCard/thankyou.dart';
import 'package:ivisit/config/constant/color_constant.dart';

import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../Auth/login.dart';

//tirth
class TapYourCardPage extends StatefulWidget {
  const TapYourCardPage({super.key});

  @override
  State<TapYourCardPage> createState() => _TapYourCardPageState();
}

class _TapYourCardPageState extends State<TapYourCardPage> {
  String usbStatus = "";
  String activeID = "";
  String usbDisConnectStatus = "";
  TextEditingController redersCodeController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void onCodeScanned(String code) {
    redersCodeController.text = code;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ThankyouRFIEADSPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    return Scaffold(
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
                            height: 80,
                            color: kTapColor,
                            child: const Row(
                              children: [
                                SizedBox(width: 15),
                                Icon(
                                  Icons.arrow_back,
                                  color: kWhiteColor,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
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
                          height: 80,
                          color: kTapColor3,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: logoutConfirmationDialog,
                            child: const Row(
                              children: [
                                SizedBox(width: 3),
                                Icon(
                                  Icons.logout_rounded,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "LogOut",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: kCircularStdMedium,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              // Text("USBConnect: $usbStatus"),
              // Text("GetActiveID :$activeID"),
              // Text("USBDisconnect :$usbDisConnectStatus"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CupertinoButton(
              //       onPressed: () {
              //         _connectUSB();
              //       },
              //       child: Text("Connect"),
              //     ),
              //     CupertinoButton(
              //       onPressed: () {
              //         _disConnectUSB();
              //       },
              //       child: Text("DisConnect"),
              //     ),
              //   ],
              // ),
              SizedBox(
                  height: 280, //350
                  width: 280, // 350
                  child: Image.asset("assets/images/rfid2.png")),
              Container(
                  width: size.width > 500 ? 600 : size.width,
                  height: 41,
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(25.0), // Border radius
                  ),
                  child: TextFieldWithNoKeyboard(
                    cursorColor: kPrimaryColor,
                    style: const TextStyle(color: kPrimaryColor),
                    controller: redersCodeController,
                    autofocus: true,
                    onValueUpdated: (value) {
                      onCodeScanned(value);
                    },
                  )),
            ],
          ),
        ),
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

  Function _function = () {
    print("do stuff here After returning back to setting page!");
  };

  static const MethodChannel platform = MethodChannel('com.tnetic.ivisit');

  // Function to call native method
  Future<void> _connectUSB() async {
    try {
      final Map<dynamic, dynamic> result =
          await platform.invokeMethod('connectUSB');
      setState(() {
        if (result['error'] != null) {
          usbStatus = result['error'];
        } else {
          activeID = result['activeID'].toString();
          usbStatus = result['readers'].toString();
        }
      });
      print("usbConnect $usbStatus");
      print("activeID $activeID");
    } on PlatformException catch (e) {
      usbStatus = "Failed to connect to USB: '${e.message}'.";
    }
    print(usbStatus);
  }

  Future<void> _disConnectUSB() async {
    try {
      final String result = await platform.invokeMethod('disConnectUSB');
      setState(() {
        usbDisConnectStatus = result;
      });
      print("usbDisConnectStatus $result");
    } on PlatformException catch (e) {
      usbStatus = "Failed to connect to USB: '${e.message}'.";
    }
    print(usbStatus);
    // setState(() {
    //   _usbStatus = usbStatus;
    // });
    // });
  }
}

class TextFieldWithNoKeyboard extends EditableText {
  TextFieldWithNoKeyboard({
    super.key,
    required TextEditingController controller,
    required TextStyle style,
    required Function onValueUpdated,
    required Color cursorColor,
    bool autofocus = false,
  }) : super(
            controller: controller,
            focusNode: TextfieldFocusNode(),
            style: style,
            cursorColor: cursorColor,
            autofocus: autofocus,
            selectionColor: kRedAccentColor,
            backgroundCursorColor: Colors.black,
            onChanged: (value) {
              onValueUpdated(value);
            });

  @override
  EditableTextState createState() {
    return TextFieldEditableState();
  }
}

//This is to hide keyboard when user tap on textfield.
class TextFieldEditableState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

// This hides keyboard from showing on first focus / autofocus
class TextfieldFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
