import 'package:get/get.dart';

import '../controller/max_subscription_controller.dart';

class MaxSubscriptionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MaxSubscriptionController());
  }
}
