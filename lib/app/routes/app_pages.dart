import 'package:get/get.dart';

import '../ui/Auth/login.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.loginPage;

  static final routes = [
    GetPage(
      name: _Paths.loginPage,
      page: () => const LoginPage(),
    ),
  ];
}
