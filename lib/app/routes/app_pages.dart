import 'package:get/get.dart';

import '../ui/AccessPoint/access_point.dart';
import '../ui/Auth/login.dart';
import '../ui/ForgotBadgeId/forgot_badge_id.dart';
import '../ui/ProcessFlow/process_flow.dart';
import '../ui/QR Scanner/qr_scanner.dart';
import '../ui/Question/question.dart';
import '../ui/ReviewDocument/review_document.dart';
import '../ui/TakePhoto/take_photo.dart';
import '../ui/ThankYou/thank_you.dart';
import '../ui/Welcome Screen/welcome_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.loginPage;

  static final routes = [
    GetPage(
      name: _Paths.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: _Paths.accessPointPage,
      page: () => const AccessPointPage(),
    ),
    GetPage(
      name: _Paths.welcomePage,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: _Paths.qrScannerPage,
      page: () => const QrScannerPage(),
    ),
    GetPage(
      name: _Paths.forgotbadgeIdPage,
      page: () => const ForgotbadgeIdPage(),
    ),
    GetPage(
      name: _Paths.questionPage,
      page: () => const QuestionPage(),
    ),
    GetPage(
      name: _Paths.processFlowPage,
      page: () => const ProcessFlowPage(),
    ),
    GetPage(
      name: _Paths.reviewDocumentPage,
      page: () => const ReviewDocumentPage(),
    ),
    GetPage(
      name: _Paths.takePhotoPage,
      page: () => const TakePhotoPage(),
    ),
    GetPage(
      name: _Paths.thankYouPage,
      page: () => const ThankYouPage(),
    ),
  ];
}
