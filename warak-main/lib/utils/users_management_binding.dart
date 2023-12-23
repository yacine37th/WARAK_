import 'package:get/get.dart';

import '../controller/users_management_controller.dart';
  


class UsersManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UsersManagementController());
  }
}
