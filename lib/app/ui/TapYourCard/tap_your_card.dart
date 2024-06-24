import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivisit/config/constant/color_constant.dart';

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

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
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
                        Container(
                          width: width / 2,
                          color: kTapColor,
                          child: const Center(
                              child: Text(
                            "I-VISIT",
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Please tap your card on the reader',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
            ),
            Text("USBConnect: $usbStatus"),
            Text("GetActiveID :$activeID"),
            Text("USBDisconnect :$usbDisConnectStatus"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    _connectUSB();
                  },
                  child: Text("Connect"),
                ),
                CupertinoButton(
                  onPressed: () {
                    _disConnectUSB();
                  },
                  child: Text("DisConnect"),
                ),
              ],
            ),
            SizedBox(
                height: 250, //350
                width: 250, // 350
                child: Image.asset("assets/images/rfid2.png")),
          ],
        ),
      ),
    );
  }

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
