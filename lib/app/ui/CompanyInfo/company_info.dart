import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ivisit/app/ui/Question/question.dart';

import '../Auth/login.dart';
import '../../routes/app_pages.dart';
import '../TakePhoto/take_photo.dart';
import '../widgets/comman_appbar.dart';
import '../widgets/thankyou_widget.dart';
import '../ProcessFlow/process_flow.dart';
import '../widgets/custom_textfield.dart';
import '../TapYourCard/tap_your_card.dart';
import '../ReviewDocument/review_document.dart';
import '../../../config/constant/constant.dart';
import '../../controller/visiter_controller.dart';
import '../../controller/processflow_conroller.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class CompanyInfoPage extends StatefulWidget {
  final String? text;
  final int? index;
  const CompanyInfoPage({super.key, this.text, this.index});

  @override
  State<CompanyInfoPage> createState() => _ProcessFlowPageState();
}

class _ProcessFlowPageState extends State<CompanyInfoPage> {
  final visitorController = Get.put(VisiterController());
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final GetAllProcessflowController getAllProcessflowController =
      Get.put(GetAllProcessflowController());
  final _processFormKey = GlobalKey<FormState>();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> purpose = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = "One";
  bool isFormSubmitted = false, isLoder = true;
  List<String> screensName = [];
  int isPurposeOfVisit = 0, isCompany = 0, isPersonToVisir = 0;

  String accessPoint = "";
  @override
  void initState() {
    autoValueCheck();
    getItemAtIndex();
    getAllProcessflowController.fetchAllProcessFlow();
    var data = getStorage.read('accessPoint') ?? "";
    setState(() {
      accessPoint = data;
    });
    super.initState();
  }

  autoValueCheck() {
    if (widget.text == "scan") {
      setState(() {
        firstNameController.text = visitorController.saveFirstname.value;
        lastNameController.text = visitorController.saveLastname.value;
        emailController.text = visitorController.saveEmail.value;
        titleController.text = visitorController.saveTitle.value;
        phoneNumberController.text = visitorController.savephoneNumber.value;
      });
    }

    Future.delayed(const Duration(seconds: 2), () async {
      screensName.clear();
      var processScreens =
          getAllProcessflowController.processflowList[0].screens ?? [];
      if (processScreens.isNotEmpty) {
        for (var screen in processScreens) {
          if (screen.screenName == "Company Info") {
            setState(() {
              isCompany = screen.fields!.isCompany!;
              isPurposeOfVisit = screen.fields!.isTitle!;
              isPersonToVisir = screen.fields!.isHost!;
              isLoder = false;
            });
          }
        }
      }
    });
  }

  String getItemAtIndex() {
    var items = getStorage.read<List<dynamic>>('apiList') ?? [];
    int index = widget.index!;
    if (index >= 0 && index < items.length) {
      return items[index];
    } else {
      return 'Index out of range';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd yyyy').format(now);
    String day = DateFormat('EEEE').format(now);
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CommonAppBar(
          width: MediaQuery.of(context).size.width,
          showBackButton: true,
          text: "Back",
          onBackPressed: () {
            if (widget.text == "scan") {
              Get.offAll(() => const TapYourCardPage(
                    text: "back",
                  ));
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: Get.width,
          child: SingleChildScrollView(
            child: Form(
              key: _processFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(accessPoint,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 13)),
                  Text("Today is $day, $formattedDate",
                      style: const TextStyle(
                          color: kBlueColor,
                          fontFamily: kCircularStdMedium,
                          fontSize: 13)),
                  const SizedBox(height: 15),
                  Image.asset(
                    "assets/i-Visits_logo.png",
                    fit: BoxFit.cover,
                    scale: 1.5,
                  ),
                  const SizedBox(height: 25),
                  isLoder
                      ? Container(
                          color: kBackGroundColor,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kSelectedIconColor,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isCompany == 0
                                    ? Container()
                                    : builsTitleWidget("Company Name"),
                                isCompany == 0
                                    ? Container()
                                    : const SizedBox(height: 5.0),
                                isCompany == 0
                                    ? Container()
                                    : SizedBox(
                                        width:
                                            Get.width > 500 ? 600 : Get.width,
                                        child: CustomTextFormField(
                                          hintText: 'Company Name',
                                          maxLines: 1,
                                          ctrl: companyController,
                                          name: "Companyname",
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Company Name is Required',
                                        ),
                                      ),
                                isCompany == 0
                                    ? Container()
                                    : const SizedBox(height: 8.0),
                                isPurposeOfVisit == 0
                                    ? Container()
                                    : builsTitleWidget("Purpose Of Visit"),
                                isPurposeOfVisit == 0
                                    ? Container()
                                    : const SizedBox(height: 5.0),
                                isPurposeOfVisit == 0
                                    ? Container()
                                    : SizedBox(
                                        width:
                                            Get.width > 500 ? 600 : Get.width,
                                        child: CustomTextFormField(
                                          hintText: 'Purpose Of Visit',
                                          maxLines: 1,
                                          ctrl: titleController,
                                          name: "title",
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Purpose Of Visit is Required',
                                        ),
                                      ),
                                isPurposeOfVisit == 0
                                    ? Container()
                                    : const SizedBox(height: 8.0),
                                isPersonToVisir == 0
                                    ? Container()
                                    : builsTitleWidget("Person To Visit"),
                                isPersonToVisir == 0
                                    ? Container()
                                    : const SizedBox(height: 5.0),
                                isPersonToVisir == 0
                                    ? Container()
                                    : SizedBox(
                                        width:
                                            Get.width > 500 ? 600 : Get.width,
                                        child: CustomTextFormField(
                                          hintText: 'Person To Visit',
                                          maxLines: 1,
                                          ctrl: hostController,
                                          name: "host",
                                          formSubmitted: isFormSubmitted,
                                          validationMsg:
                                              'Person To Visit is Required',
                                        ),
                                      ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: Get.width > 500 ? 600 : Get.width - 20,
                                  child: CupertinoButton(
                                    borderRadius: BorderRadius.circular(25),
                                    color: kPrimaryColor,
                                    child: const Text("Next",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontFamily: kCircularStdMedium,
                                            fontSize: 14)),
                                    onPressed: () {
                                      setState(() {
                                        isFormSubmitted = true;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () async {
                                        if (_processFormKey.currentState!
                                            .validate()) {
                                          visitorController.saveCompanyInfo(
                                              companyController.text,
                                              titleController.text,
                                              hostController.text);
                                          String selectedItem =
                                              getItemAtIndex();
                                          var screenIndex = widget.index! + 1;

                                          if (selectedItem == "Personal Info") {
                                            Get.to(() => ProcessFlowPage(
                                                  index: screenIndex,
                                                ));
                                          } else if (selectedItem ==
                                              "Document") {
                                            Get.to(() => ReviewDocumentPage(
                                                index: screenIndex));
                                          } else if (selectedItem == "Photo") {
                                            Get.to(() => TakePhotoPage(
                                                index: screenIndex));
                                          } else if (selectedItem ==
                                              "Question") {
                                            Get.to(() => QuestionPage(
                                                index: screenIndex));
                                          } else if (selectedItem ==
                                              "Company Info") {
                                            Get.to(() => CompanyInfoPage(
                                                index: screenIndex));
                                          } else {
                                            if (getAllProcessflowController
                                                    .processflowList[0]
                                                    .successMsgData ==
                                                null) {
                                              Get.to(
                                                  () => const ThankyouWidget());
                                            } else {
                                              Get.toNamed(Routes.thankYouPage);
                                            }
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  builsTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        title,
        style: const TextStyle(
            color: kPrimaryColor, fontFamily: kCircularStdMedium, fontSize: 14),
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
}
