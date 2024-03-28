part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const loginPage = _Paths.loginPage;
  static const welcomePage = _Paths.welcomePage;
  static const questionPage = _Paths.questionPage;
  static const thankYouPage = _Paths.thankYouPage;
  static const takePhotoPage = _Paths.takePhotoPage;
  static const qrScannerPage = _Paths.qrScannerPage;
  static const accessPointPage = _Paths.accessPointPage;
  static const processFlowPage = _Paths.processFlowPage;
  static const forgotbadgeIdPage = _Paths.forgotbadgeIdPage;
  static const reviewDocumentPage = _Paths.reviewDocumentPage;
}

abstract class _Paths {
  static const loginPage = '/loginPage';
  static const welcomePage = '/welcomePage';
  static const questionPage = '/questionPage';
  static const thankYouPage = '/thankYouPage';
  static const takePhotoPage = '/takePhotoPage';
  static const qrScannerPage = '/qrScannerPage';
  static const accessPointPage = '/accessPointPage';
  static const processFlowPage = '/processFlowPage';
  static const forgotbadgeIdPage = '/forgotbadgeIdPage';
  static const reviewDocumentPage = '/reviewDocumentPage';
}
