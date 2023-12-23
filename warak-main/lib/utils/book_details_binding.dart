import 'package:get/get.dart';

import '../controller/book_details_controller.dart';
import '../controller/order_book_controller.dart';

class BookDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BookDetailsController());
 //   Get.put(OrderBookController());
  }
}
