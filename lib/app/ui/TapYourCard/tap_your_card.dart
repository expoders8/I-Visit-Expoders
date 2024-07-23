import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivisit/app/ui/TapYourCard/thankyou.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../Auth/login.dart';
import '../widgets/ble_utils.dart';
import '../Question/question.dart';
import '../../routes/app_pages.dart';
import '../TakePhoto/take_photo.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../AccessPoint/access_point.dart';
import '../ProcessFlow/process_flow.dart';
import '../../services/visiter_service.dart';
import '../ReviewDocument/review_document.dart';
import '../../../config/constant/constant.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';

class TapYourCardPage extends StatefulWidget {
  final String? text;
  const TapYourCardPage({super.key, this.text});

  @override
  State<TapYourCardPage> createState() => _TapYourCardPageState();
}

class _TapYourCardPageState extends State<TapYourCardPage> {
  String usbStatus = "";
  String activeID = "";
  String rederCode = "";
  String usbDisConnectStatus = "";
  TextEditingController redersCodeController = TextEditingController();
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final FocusNode focusNode = FocusNode();
  VisitorService visiterService = VisitorService();
  List<String> screensName = [];
  Timer? _timer;
  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _scanSubscription;

  @override
  void initState() {
    _checkPermission();
    _scanSubscription?.cancel();
    super.initState();
  }

  Future<void> _checkPermission() async {
    if (!(await BleUtils.checkBluetoothPermission())) {
      return;
    }

    if (!(await BleUtils.checkLocationPermissions())) {
      return;
    }
    _scanSubscription = flutterReactiveBle
        .scanForDevices(
            requireLocationServicesEnabled: false,
            withServices: [],
            scanMode: ScanMode.lowLatency)
        .listen((scanResult) async {
      setState(() {
        usbStatus = scanResult.name;
      });
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    _timer?.cancel();
    setState(() {
      usbStatus = "1";
    });
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

  // Future<void> openKeyboardSettings() async {
  //   const AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.INPUT_METHOD_SETTINGS',
  //   );
  //   await intent.launch();
  // }

  @override
  Widget build(BuildContext context) {
    // if (usbStatus == "") {
    //   SystemChannels.textInput.invokeMethod('TextInput.hide');
    // }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CommonAppBar(
          width: MediaQuery.of(context).size.width,
          showBackButton: true,
          text: "Back",
          onBackPressed: () {
            if (widget.text == "back") {
              Get.offAll(() => const AccessPointPage());
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              // Text("usbStatus: $usbStatus"),
              // Text("GetActiveID :$activeID"),
              // Text("USBDisconnect :$usbDisConnectStatus"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              // CupertinoButton(
              //   onPressed: () async {
              //     var ddd = flutterReactiveBle
              //         .scanForDevices(
              //             requireLocationServicesEnabled: false,
              //             withServices: [],
              //             scanMode: ScanMode.lowLatency)
              //         .listen((scanResult) async {
              //       setState(() {
              //         usbStatus = scanResult.name;
              //       });
              //       debugger();
              //     }, onDone: () {
              //       debugPrint("BLE-5 onDone");
              //       debugPrint("BLE-6");
              //     }, onError: (e) {}, cancelOnError: true);
              //   },
              //   child: Text("Connect"),
              // ),
              // CupertinoButton(
              //   onPressed: () async {
              //     getAllProcessflowController.fetchAllProcessFlow();
              //     screensName.clear();
              //     var processScreens =
              //         getAllProcessflowController.processflowList[0].screens;
              //     if (processScreens!.isNotEmpty) {
              //       for (var screen in processScreens) {
              //         if (screen.screenName.toString() != "Authenticate") {
              //           screensName.add(screen.screenName.toString());
              //         }
              //       }
              //     }
              //     await visiterService
              //         .getVisiterLog("161373710746373")
              //         .then((value) async {
              //       saveListToLocal(screensName);
              //       var screenIndex = screensName[0];
              //       if (value) {
              //         await visiterService
              //             .getVisitorByBadgeId("161373710746373")
              //             .then((val) => {
              //                   if (val)
              //                     {
              //                       if (processScreens.isEmpty)
              //                         {
              //                           LoaderX.hide(),
              //                           if (getAllProcessflowController
              //                                   .processflowList[0]
              //                                   .successMsgData ==
              //                               null)
              //                             {Get.to(() => const ThankyouWidget())}
              //                           else
              //                             {Get.toNamed(Routes.thankYouPage)}
              //                         }
              //                       else
              //                         {
              //                           if (getAllProcessflowController
              //                                   .processflowList[0]
              //                                   .welcomeMsgData ==
              //                               null)
              //                             {
              //                               if (screenIndex == "Basic Info")
              //                                 {
              //                                   LoaderX.hide(),
              //                                   Get.offAll(
              //                                       () => const ProcessFlowPage(
              //                                             index: 1,
              //                                             text: "scan",
              //                                           ))
              //                                 }
              //                               else if (screenIndex == "Document")
              //                                 {
              //                                   LoaderX.hide(),
              //                                   Get.offAll(() =>
              //                                       const ReviewDocumentPage(
              //                                         index: 1,
              //                                         text: "scan",
              //                                       ))
              //                                 }
              //                               else if (screenIndex == "Photo")
              //                                 {
              //                                   LoaderX.hide(),
              //                                   Get.offAll(
              //                                       () => const TakePhotoPage(
              //                                             index: 1,
              //                                             text: "scan",
              //                                           )),
              //                                 }
              //                               else if (screenIndex == "Question")
              //                                 {
              //                                   LoaderX.hide(),
              //                                   Get.offAll(
              //                                       () => const QuestionPage(
              //                                             index: 1,
              //                                             text: "scan",
              //                                           )),
              //                                 }
              //                               else
              //                                 {
              //                                   LoaderX.hide(),
              //                                   if (getAllProcessflowController
              //                                           .processflowList[0]
              //                                           .successMsgData ==
              //                                       null)
              //                                     {
              //                                       Get.to(() =>
              //                                           const ThankyouWidget())
              //                                     }
              //                                   else
              //                                     {
              //                                       Get.toNamed(
              //                                           Routes.thankYouPage)
              //                                     }
              //                                 }
              //                             }
              //                           else
              //                             {
              //                               LoaderX.hide(),
              //                               Get.toNamed(Routes.welcomePage)
              //                             }
              //                         }
              //                     }
              //                 });
              //       } else {
              //         setState(() {
              //           redersCodeController.clear();
              //           rederCode = "";
              //         });
              //       }
              //     });
              //   },
              //   child: Text("DisConnect"),
              // ),
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
                  // maxLines: 2,
                  autofocus: true,
                  focusNode: FocusNode(),
                  controller: redersCodeController,
                  onChanged: (value) {
                    setState(() {
                      rederCode = redersCodeController.text;
                    });
                    if (_timer?.isActive ?? false) _timer?.cancel();
                    _timer = Timer(const Duration(seconds: 2), () async {
                      String badgeID = redersCodeController.text.trim();
                      LoaderX.show(context, 60.0, 60.0);
                      getAllProcessflowController.fetchAllProcessFlow();
                      screensName.clear();
                      var processScreens = getAllProcessflowController
                          .processflowList[0].screens;
                      for (var screen in processScreens!) {
                        if (screen.screenName.toString() != "Authenticate") {
                          screensName.add(screen.screenName.toString());
                        }
                      }
                      await visiterService
                          .getVisiterLog(badgeID)
                          .then((value) async {
                        saveListToLocal(screensName);
                        var screenIndex = screensName[0];
                        if (value) {
                          await visiterService
                              .getVisitorByBadgeId(badgeID)
                              .then((val) => {
                                    if (val)
                                      {
                                        if (processScreens.isEmpty)
                                          {
                                            LoaderX.hide(),
                                            if (getAllProcessflowController
                                                    .processflowList[0]
                                                    .successMsgData ==
                                                null)
                                              {
                                                Get.to(() =>
                                                    const ThankyouWidget())
                                              }
                                            else
                                              {Get.toNamed(Routes.thankYouPage)}
                                          }
                                        else
                                          {
                                            if (getAllProcessflowController
                                                    .processflowList[0]
                                                    .welcomeMsgData ==
                                                null)
                                              {
                                                if (screenIndex == "Basic Info")
                                                  {
                                                    LoaderX.hide(),
                                                    Get.offAll(() =>
                                                        const ProcessFlowPage(
                                                          index: 1,
                                                          text: "scan",
                                                        ))
                                                  }
                                                else if (screenIndex ==
                                                    "Document")
                                                  {
                                                    LoaderX.hide(),
                                                    Get.offAll(() =>
                                                        const ReviewDocumentPage(
                                                          index: 1,
                                                          text: "scan",
                                                        ))
                                                  }
                                                else if (screenIndex == "Photo")
                                                  {
                                                    LoaderX.hide(),
                                                    Get.offAll(() =>
                                                        const TakePhotoPage(
                                                          index: 1,
                                                          text: "scan",
                                                        )),
                                                  }
                                                else if (screenIndex ==
                                                    "Question")
                                                  {
                                                    LoaderX.hide(),
                                                    Get.offAll(() =>
                                                        const QuestionPage(
                                                          index: 1,
                                                          text: "scan",
                                                        )),
                                                  }
                                                else
                                                  {
                                                    LoaderX.hide(),
                                                    if (getAllProcessflowController
                                                            .processflowList[0]
                                                            .successMsgData ==
                                                        null)
                                                      {
                                                        Get.to(() =>
                                                            const ThankyouWidget())
                                                      }
                                                    else
                                                      {
                                                        Get.toNamed(
                                                            Routes.thankYouPage)
                                                      }
                                                  }
                                              }
                                            else
                                              {
                                                LoaderX.hide(),
                                                Get.toNamed(Routes.welcomePage)
                                              }
                                          }
                                      }
                                  });
                        } else {
                          setState(() {
                            redersCodeController.clear();
                            rederCode = "";
                          });
                        }
                      });
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(rederCode),
            ],
          ),
        ),
      ),
    );
  }

  void saveListToLocal(List<dynamic> list) {
    getStorage.write('apiList', list);
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

  static const MethodChannel platform = MethodChannel('com.tnetic.ivisit');

  // Function to call native method
  Future<void> connectUSB() async {
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
    } on PlatformException catch (e) {
      usbStatus = "Failed to connect to USB: '${e.message}'.";
    }
  }

  Future<void> disConnectUSB() async {
    try {
      final String result = await platform.invokeMethod('disConnectUSB');
      setState(() {
        usbDisConnectStatus = result;
      });
    } on PlatformException catch (e) {
      usbStatus = "Failed to connect to USB: '${e.message}'.";
    }
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
