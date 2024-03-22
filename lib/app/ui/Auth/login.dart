import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController organizationController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isFormSubmitted = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'I-Visit',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontFamily: kCircularStdMedium),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    builsTitleWidget("Branch Code"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      width: size.width > 500 ? 600 : size.width,
                      child: CustomTextFormField(
                        hintText: 'Branch Code',
                        maxLines: 1,
                        ctrl: organizationController,
                        name: "branch",
                        formSubmitted: isFormSubmitted,
                        validationMsg: 'Branch Code is Required',
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
}
