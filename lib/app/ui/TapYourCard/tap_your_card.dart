import 'dart:async';

// import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ivisit/app/ui/TapYourCard/thankyou.dart';
import 'package:ivisit/config/constant/color_constant.dart';
import '../../../config/constant/constant.dart';
import '../../services/visiterlog.dart';
import '../Auth/login.dart';

import '../widgets/comman_appbar.dart';

class TapYourCardPage extends StatefulWidget {
  const TapYourCardPage({super.key});

  @override
  State<TapYourCardPage> createState() => _TapYourCardPageState();
}

class _TapYourCardPageState extends State<TapYourCardPage> {
  String usbStatus = "";
  String activeID = "";
  String rederCode = "";
  String usbDisConnectStatus = "";
  TextEditingController redersCodeController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  VisiterService visiterService = VisiterService();
  bool _isOtgConnected = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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

  // Future<void> openKeyboardSettings() async {
  //   const AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.INPUT_METHOD_SETTINGS',
  //   );
  //   await intent.launch();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    return Scaffold(
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
              // CupertinoButton(
              //   onPressed: () {
              //     _connectUSB();
              //   },
              //   child: Text("Connect"),
              // ),
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
                width: 0,
                height: 0,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(25.0), // Border radius
                ),
                child: TextField(
                  maxLines: 2,
                  autofocus: true,
                  controller: redersCodeController,
                  keyboardType: TextInputType.multiline,
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    // FilteringTextInputFormatter.allow(RegExp(r'[^\da-zA-Z]')),
                  ],
                  onChanged: (value) {
                    //Future.delayed(const Duration(seconds: 2), () async {
                    //if (int.tryParse(value) != null) {
                    setState(() {
                      rederCode = redersCodeController.text;
                    });
                    if (_timer?.isActive ?? false) _timer?.cancel();
                    _timer = Timer(const Duration(seconds: 2), () {
                      //if (redersCodeController.text.endsWith('\n')) {
                      String badgeID = redersCodeController.text.trim();
                      visiterService.getVisiterLog(badgeID).then((value) {
                        if (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ThankyouRFIEADSPage(),
                            ),
                          );
                        } else {
                          setState(() {
                            redersCodeController.clear();
                            rederCode = "";
                          });
                        }
                      });
                      //}
                      //}
                    });

                    //});
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(rederCode),
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
