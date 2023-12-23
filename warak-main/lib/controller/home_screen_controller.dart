import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warak/Themes/colors.dart';
import 'package:warak/controller/maktabati_controller.dart';
import 'package:warak/controller/max_subscription_controller.dart';
import 'package:warak/controller/sign_in_controller.dart';
import 'package:warak/controller/sign_up_controller.dart';
import 'package:warak/controller/tasnifat_controller.dart';
import 'package:warak/controller/users_management_controller.dart';
import 'package:warak/controller/verify_email_controller.dart';

import '../main.dart';
import 'home_ra2isiya_controller.dart';

class HomeScreenController extends GetxController {
  int _currentBottomBarIndex = 0;

  int currentBottomBarIndex() {
    return _currentBottomBarIndex;
  }

  switchBetweenScreens(index) async {
    _currentBottomBarIndex = index;

    if (index == 0) {
      _currentBottomBarIndex = index;
    }
    if (index == 1) {
      _currentBottomBarIndex = index;

      // Apis.getFirebaseMessagingToken();
    }

    if (index == 2) {
      _currentBottomBarIndex = index;
    }

    update();
  }

  signOutOfAnExistingAccount() async {
    await FirebaseAuth.instance.signOut().then((value) {
      currentUser = null;

      Get.offAllNamed("/SignIn");
    });
  }

  @override
  onInit() async {
    update();

    Get.put(HomeRa2isiyaController());
    Get.put(TasnifatController());
    Get.put(MaktabatiController()); //account controller
    Get.put(MaxSubscriptionController());

    super.onInit();
  }

  Future<void> privatePolicy() async {
    String privacyPolicyURL =
        "https://github.com/warak-team/warak-help/blob/main/PRIVACY-POLICY.md";
    if (!await launchUrl(Uri.parse(privacyPolicyURL),
        mode: LaunchMode.externalApplication)) {
      MainFunctions.somethingWentWrongSnackBar();
    }
  }

  void knowWarak() async {
    String knowWarakURL =
        "https://github.com/warak-team/warak-help/blob/main/WARAK.md";
    if (!await launchUrl(Uri.parse(knowWarakURL),
        mode: LaunchMode.externalApplication)) {
      MainFunctions.somethingWentWrongSnackBar();
    }
  }
}
