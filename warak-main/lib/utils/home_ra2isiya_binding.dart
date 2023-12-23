import 'package:get/get.dart';
import 'package:warak/controller/home_ra2isiya_controller.dart';

class HomeRa2isiyaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeRa2isiyaController());
  }
}
