import 'package:cloud_firestore/cloud_firestore.dart';
import "package:get/get.dart";
import 'package:warak/model/max_subscription_model.dart';

import '../main.dart';

class MaxSubscriptionController extends GetxController {
  MaxSubscriptionModel? maxSubscriptionModel;
  getSubscriptionDetails() async {
    isFetching = true;
    await FirebaseFirestore.instance
        .collection("subscription")
        .doc("subscription")
        .get()
        .then((value) {
      if (value.exists) {
        maxSubscriptionModel = MaxSubscriptionModel(
          id: value.id,
          text: value["subscriptionText"],
          price: value["subscriptionPrice"].toDouble(),
          newPromoPrice: value["subscriptionNewPromoPrice"] != null
              ? value["subscriptionNewPromoPrice"].toDouble()
              : null,
          prosList: value["subscriptionProsList"],
        );
      }
    });
    isFetching = false;
    update();
  }

  bool isFetching = true;
  @override
  void onInit() {
    getSubscriptionDetails();
    super.onInit();
  }
}
