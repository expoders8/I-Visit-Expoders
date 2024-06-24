import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face_camera/face_camera.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'config/constant/constant.dart';
import 'config/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await FaceCamera.initialize();

  if (getStorage.read('firstTimeLaunch') == null) {
    getStorage.erase();
    getStorage.remove('user');
    getStorage.remove('authToken');
    getStorage.write('firstTimeLaunch', true);
    getStorage.write('onBoard', 0);
  }
  return runApp(
    ChangeNotifierProvider<ThemeProvider>(
      child: const MyApp(),
      create: (BuildContext context) {
        const isDark = false;
        return ThemeProvider(isDark);
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Provider.of<ThemeProvider>(context, listen: false).getTheme(),
      initialRoute: Routes.splashScreen,
      getPages: AppPages.routes,
    );
  }
}
