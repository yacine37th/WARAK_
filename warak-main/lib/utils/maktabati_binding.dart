import 'package:get/get.dart';

import '../controller/maktabati_controller.dart';
import '../controller/users_management_controller.dart';

class MaktabatiBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MaktabatiController());
  }
}
