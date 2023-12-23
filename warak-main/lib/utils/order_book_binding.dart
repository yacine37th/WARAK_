import 'package:get/get.dart';
import 'package:warak/controller/order_book_controller.dart';

class OrderBookBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderBookController());
  }
}
