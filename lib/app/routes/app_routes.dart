part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const loginPage = _Paths.loginPage;
  static const welcomePage = _Paths.welcomePage;
  static const qrScannerPage = _Paths.qrScannerPage;
  static const accessPointPage = _Paths.accessPointPage;
  static const forgotbadgeIdPage = _Paths.forgotbadgeIdPage;
}

abstract class _Paths {
  static const loginPage = '/loginPage';
  static const welcomePage = '/welcomePage';
  static const qrScannerPage = '/qrScannerPage';
  static const accessPointPage = '/accessPointPage';
  static const forgotbadgeIdPage = '/forgotbadgeIdPage';
}
