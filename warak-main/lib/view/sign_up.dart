import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';
import '../controller/sign_up_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find();

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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 220, child: WarakLogo()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Form(
                            key: signUpController.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onSaved: (userFirstName) {
                                    userFirstName =
                                        '${userFirstName![0].toUpperCase()}${userFirstName.substring(1).toLowerCase()}';
                                    signUpController.userFirstName =
                                        userFirstName.trim();
                                  },
                                  onChanged: (userFirstName) {
                                    userFirstName =
                                        '${userFirstName[0].toUpperCase()}${userFirstName.substring(1).toLowerCase()}';
                                    signUpController.userFirstName =
                                        userFirstName.trim();
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "من فضلك املأ المعلومات";
                                    } else if (val.length > 20) {
                                      return "يجب ان يكون اقل من 20 حرف";
                                    } else if (val.length < 2) {
                                      return "يجب ان يكون أكثر من حرفين";
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: 'Cairo', color: whiteColor),
                                    hintText: "الإسم",
                                    prefixIcon: ImageIcon(
                                      Svg("assets/icons/full_person_icon.svg"),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  onSaved: (userLastName) {
                                    userLastName =
                                        '${userLastName![0].toUpperCase()}${userLastName.substring(1).toLowerCase()}';
                                    signUpController.userLastName =
                                        userLastName.trim();
                                  },
                                  onChanged: (userLastName) {
                                    userLastName =
                                        '${userLastName[0].toUpperCase()}${userLastName.substring(1).toLowerCase()}';
                                    signUpController.userLastName =
                                        userLastName.trim();
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "من فضلك املأ المعلومات";
                                    } else if (val.length > 20) {
                                      return "يجب ان يكون اقل من 20 حرف";
                                    } else if (val.length < 2) {
                                      return "يجب ان يكون أكثر من حرفين";
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: 'Cairo', color: whiteColor),
                                    hintText: "اللقب",
                                    prefixIcon: ImageIcon(
                                      Svg("assets/icons/full_person_icon.svg"),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
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
                                    signUpController.userEmailAddress =
                                        emailAddress?.trim();
                                  },
                                  onChanged: (emailAddress) {
                                    signUpController.userEmailAddress =
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
                                GetBuilder<SignUpController>(builder: (cntx) {
                                  return TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: signUpController.showPassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "من فضلك املأ كلمة السر";
                                      } else if (value.length > 20) {
                                        return "يجب ان يكون اقل من 20 حرف";
                                      } else if (value.length < 8) {
                                        return "يجب ان يكون أكثر من 8 حروف";
                                      }
                                      return null;
                                    },
                                    onSaved: (password) {
                                      signUpController.userPassword =
                                          password?.trim();
                                    },
                                    onChanged: (password) {
                                      signUpController.userPassword =
                                          password.trim();
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
                                            signUpController
                                                .invertShowPassword();
                                          },
                                          icon: signUpController.showPassword
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off)),
                                      hintText: 'كلمة السر',
                                    ),
                                  );
                                }),
                                const SizedBox(height: 20),
                                TextButton(
                                    onPressed: () {
                                      if (signUpController.formKey.currentState!
                                          .validate()) {
                                        signUpController.formKey.currentState!
                                            .save();
                                        signUpController.createNewUser();
                                      }
                                    },
                                    child: const Text(
                                      "إنشاء حساب",
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: whiteColor),
                                    )),
                                const SizedBox(height: 15),
                              ],
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
                top: 20,
                child: IconButton(
                  onPressed: () {
                    navigator!.pop();
                  },
                  icon: const IconButtonBack(),
                  color: whiteColor,
                )),
          ],
        ),
      ),
    );
  }
}
