import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/main.dart';

import '../Themes/colors.dart';
import '../controller/sign_in_controller.dart';
import 'widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.find();

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/login_background.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            //  const BackgroundImage(),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 220, child: WarakLogo()),
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Image.asset(
                      "assets/images/login_profil_picture.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Form(
                            key: signInController.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "من فضلك املأ البريد الإلكتروني";
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "من فضلك املأ بريد إلكتروني صحيح";
                                    }

                                    return null;
                                  },
                                  onSaved: (emailAddress) {
                                    signInController.userEmailAddress =
                                        emailAddress;
                                  },
                                  onChanged: (emailAddress) {
                                    signInController.userEmailAddress =
                                        emailAddress.trim();
                                  },
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: 'Cairo', color: whiteColor),
                                    prefixIcon: ImageIcon(
                                      Svg("assets/icons/email_icon.svg"),
                                    ),
                                    hintText: 'البريد الإكتروني',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GetBuilder<SignInController>(builder: (cntx) {
                                  return TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: signInController.showPassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "من فضلك املأ كلمة المرور";
                                      }
                                    },
                                    onSaved: (password) {
                                      signInController.userPassword = password;
                                    },
                                    onChanged: (password) {
                                      signInController.userPassword = password;
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Cairo',
                                          color: whiteColor),
                                      prefixIcon: const ImageIcon(
                                        Svg("assets/icons/lock_icon.svg"),
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            signInController
                                                .invertShowPassword();
                                          },
                                          icon: signInController.showPassword
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off)),
                                      hintText: 'كلمة السر',
                                    ),
                                  );
                                }),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        orangeColor)),
                                            onPressed: () {
                                              if (signInController
                                                  .formKey.currentState!
                                                  .validate()) {
                                                signInController
                                                    .formKey.currentState!
                                                    .save();
                                                signInController.signInAUser();
                                              }
                                            },
                                            child: const Text(
                                              "تسجيل الدخول",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Cairo'),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: SizedBox(
                                          child: TextButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all(RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          side: BorderSide(
                                                              color:
                                                                  orangeColor))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey
                                                              .withOpacity(
                                                                  0.4))),
                                              onPressed: () {
                                                MainFunctions.textDirection =
                                                    TextDirection.rtl;
                                                Get.forceAppUpdate();
                                                Get.toNamed("/SignUp");
                                              },
                                              child: const Text(
                                                "إنشاء حساب",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Cairo'),
                                              ))),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  orangeColor),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  whiteColor.withOpacity(0.5))),
                                      onPressed: () {
                                        Get.toNamed("ForgotPassword");
                                      },
                                      child: const Text(
                                        "نسيت كلمة المرور ؟",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Cairo',
                                            shadows: [
                                              Shadow(
                                                  blurRadius: 10,

                                                  // bottomLeft
                                                  offset: Offset(-1.5, -1.5),
                                                  color: Colors.white70),
                                              Shadow(
                                                  blurRadius: 10,

                                                  // bottomRight
                                                  offset: Offset(1.5, -1.5),
                                                  color: Colors.white70),
                                              Shadow(
                                                  blurRadius: 10,

                                                  // topRight
                                                  offset: Offset(1.5, 1.5),
                                                  color: Colors.white70),
                                              Shadow(
                                                  blurRadius: 10,
                                                  // topLeft
                                                  offset: Offset(-1.5, 1.5),
                                                  color: Colors.white70),
                                            ]),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
