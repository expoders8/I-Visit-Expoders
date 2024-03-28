import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../controller/sign_in_screen.x.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';
import '../../../config/provider/loader_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final signInController = Get.put(SignInScreenX());
  TextEditingController organizationController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isFormSubmitted = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Form(
        key: _loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    "assets/i-Visits_logo.png",
                    fit: BoxFit.cover,
                    scale: 1.5,
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      builsTitleWidget("Organization ID"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: size.width > 500 ? 600 : size.width,
                        child: CustomTextFormField(
                          hintText: 'Organization ID',
                          maxLines: 1,
                          ctrl: organizationController,
                          name: "otgid",
                          formSubmitted: isFormSubmitted,
                          validationMsg: 'Organization ID is Required',
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      builsTitleWidget("Username"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: size.width > 500 ? 600 : size.width,
                        child: CustomTextFormField(
                          hintText: 'Username',
                          maxLines: 1,
                          ctrl: userNameController,
                          name: "username",
                          formSubmitted: isFormSubmitted,
                          validationMsg: 'Username is Required',
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      builsTitleWidget("Password"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: size.width > 500 ? 600 : size.width,
                        child: CustomTextFormField(
                          hintText: 'Password',
                          maxLines: 1,
                          ctrl: passwordController,
                          name: "password",
                          formSubmitted: isFormSubmitted,
                          validationMsg: 'Password is Required',
                        ),
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: CupertinoButton(
                          onPressed: () {
                            // onLoginButtonPress();
                            Get.toNamed(Routes.accessPointPage);
                          },
                          borderRadius: BorderRadius.circular(25),
                          padding: EdgeInsets.zero,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                  fontFamily: kCircularStdMedium),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80)
                    ],
                  ),
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

  onLoginButtonPress() {
    setState(() {
      isFormSubmitted = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (_loginFormKey.currentState!.validate()) {
        signInController.organizationId(organizationController.text);
        signInController.email(userNameController.text);
        signInController.password(passwordController.text);
        // signInController.fcmToken(fcmToken);
        LoaderX.show(context, 60.0, 60.0);

        signInController.login();
      }
    });
  }
}
