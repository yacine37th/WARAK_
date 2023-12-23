import 'package:get/get.dart';

import '../controller/tasnifat_controller.dart';
 
class TasnifatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TasnifatController());
  }
}
