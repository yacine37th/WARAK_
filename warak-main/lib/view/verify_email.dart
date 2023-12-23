import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:warak/view/widgets.dart';

import '../controller/verify_email_controller.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailVerificationController emailVerificationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const IconButtonBack()),
        title: const Text("تأكيد بواسطة البريد الإلكتروني"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("تم إرسال بريد إلكتروني للتحقق إلى بريدك الإلكتروني",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    emailVerificationController.resendVerificationEmail();
                  },
                  child: const Text("إعادة الإرسال",
                      style: TextStyle(
                        fontSize: 20,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
