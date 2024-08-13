import 'package:get/get.dart';

class VisiterController extends GetxController {
  RxString saveFirstname = "".obs;
  RxString saveLastname = "".obs;
  RxString saveTitle = "".obs;
  RxString saveEmail = "".obs;
  RxString saveCompany = "".obs;
  RxString savephoneNumber = "".obs;
  RxString saveHost = "".obs;
  RxString saveDoc = "".obs;
  RxString saveImagePath = "".obs;
  RxList saveQue = [].obs;

  void saveProcessFlow(
      String firstname, String lastName, String email, String phoneNumber) {
    saveFirstname.value = firstname;
    saveLastname.value = lastName;
    saveEmail.value = email;
    savephoneNumber.value = phoneNumber;
  }

  void saveCompanyInfo(String company, String title, String host) {
    saveCompany.value = company;
    saveTitle.value = title;
    saveHost.value = host;
  }

  void saveQueData(List que) {
    saveQue.value = que;
  }

  void saveDocData(String doc) {
    saveDoc.value = doc;
  }

  void saveImageData(String image) {
    saveImagePath.value = image;
  }
}
