import 'package:get/get.dart';

import '../controller/requested_books_controller.dart';

class RequestedBooksBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RequestedBooksController());
  }
}
