import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../config/constant/font_constant.dart';
import '../../../config/constant/color_constant.dart';

class CommonAppBar extends StatelessWidget {
  final double width;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showLogoutButton;
  final VoidCallback? onLogoutPressed;
  final String text;

  const CommonAppBar({
    Key? key,
    required this.width,
    required this.text,
    this.showBackButton = false,
    this.onBackPressed,
    this.showLogoutButton = false,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          color: kTapColor3,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (showBackButton)
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: onBackPressed ?? () {},
                        child: Container(
                          width: width / 2,
                          height: 80,
                          color: kTapColor,
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(
                                Icons.arrow_back,
                                color: kWhiteColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                text,
                                style: const TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      width: width / 5,
                      color: kTapColor1,
                    ),
                    Container(
                      width: width / 5,
                      color: kTapColor2,
                    ),
                    if (showLogoutButton)
                      Container(
                        height: 80,
                        color: kTapColor3,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: onLogoutPressed ?? () {},
                          child: showLogoutButton == true
                              ? const Row(
                                  children: [
                                    SizedBox(width: 3),
                                    Icon(
                                      Icons.logout_rounded,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "LogOut",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: kCircularStdMedium,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage:
// Replace 'width' with your actual width, and provide callbacks where needed.
// Example usage: 

