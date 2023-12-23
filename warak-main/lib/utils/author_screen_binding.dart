import 'package:get/get.dart';

import '../controller/author_screen_controller.dart';
import '../controller/users_management_controller.dart';

class AuthorScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthorScreenController());
  }
}
