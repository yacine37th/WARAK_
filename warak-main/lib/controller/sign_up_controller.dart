import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak/model/user_model.dart';

import '../main.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;

  String? userFirstName;
  String? userLastName;
  String? userEmailAddress;
  String? userPassword;

  invertShowPassword() {
    showPassword = !showPassword;
    update();
  }

  createNewUser() async {
    Get.defaultDialog(
        title: "يرجى الانتظار", content: const CircularProgressIndicator());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailAddress!,
        password: userPassword!,
      );

      FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set({
        "userID": credential.user!.uid,
        "userEmail": userEmailAddress,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userAboutMe": "",
        "userImageURL": "",
        "userMaktabati": [],
        "userFavoriteBooks": [],
        "userIsSubbed": false,
        "userFacebookAccount": "",
        "userI9ama": "",
        "userInstaAccount": "",
        "userOrdersElectronicBooks": [],
      });
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Get.back();
      Get.toNamed("/EmailVerification");
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "كلمة السر ضعيف، يرجى تغييرها",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: "يوجد حساب يستعمل هذا البريد الإكتروني",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
        title: "يوجد خطأ ما",
        content: const Icon(
          Icons.report_problem,
          color: Colors.red,
        ),
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  // qsd() async {
  //   Get.defaultDialog(
  //       title: "Please wait", content: const CircularProgressIndicator());
  //   // try {
  //   //   final credential =
  //   //       await FirebaseAuth.instance.signInWithPhoneNumber(

  //   //   );

  //   final AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _otpcode,
  //     smsCode: val,
  //   );
  //   currentUser!.linkWithCredential(credential);

  //   FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(credential.user!.uid)
  //       .set({
  //     "UID": credential.user!.uid,
  //     "Email": userEmailAddress,
  //     "UserName": userName,
  //     "ImageURL":""
  //   });
  //   await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  //   Get.back();

  //   Get.toNamed("/EmailVerification");
  // } on FirebaseAuthException catch (e) {
  //   Get.back();

  //   if (e.code == 'weak-password') {
  //     Get.defaultDialog(
  //       title: "The password provided is too weak.",
  //       content: const Icon(
  //         Icons.report_problem,
  //         color: Colors.red,
  //       ),
  //       onConfirm: () {
  //         Get.back();
  //       },
  //     );
  //   } else if (e.code == 'email-already-in-use') {
  //     Get.defaultDialog(
  //       title: "The account already exists for that email.",
  //       content: const Icon(
  //         Icons.report_problem,
  //         color: Colors.red,
  //       ),
  //       onConfirm: () {
  //         Get.back();
  //       },
  //     );
  //   }
  // } catch (e) {
  //   Get.back();
  //  }
//  }
}
