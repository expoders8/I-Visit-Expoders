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

  void saveProcessFlow(String firstname, String lastName, String email,
      String title, String company, String phoneNumber, String host) {
    saveFirstname.value = firstname;
    saveLastname.value = lastName;
    saveEmail.value = email;
    saveTitle.value = title;
    saveCompany.value = company;
    savephoneNumber.value = phoneNumber;
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
