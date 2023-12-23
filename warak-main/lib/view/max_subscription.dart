import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/main.dart';

import '../Themes/colors.dart';
import '../controller/max_subscription_controller.dart';
import '../model/max_subscription_model.dart';
import '../model/order_model.dart';

class MaxSubscription extends StatelessWidget {
  const MaxSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    final MaxSubscriptionController maxSubscriptionController = Get.find();
    MaxSubscriptionModel maxSubscriptionModel =
        maxSubscriptionController.maxSubscriptionModel!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        bottom: PreferredSize(
            preferredSize: const Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
        title: TextButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(transparentColor)),
          icon: const Text(
            "ماكس",
            style: TextStyle(
                fontFamily: 'ArefRuqaa',
                fontWeight: FontWeight.bold,
                color: orangeColor,
                fontSize: 21),
          ),
          label: const ImageIcon(Svg("assets/icons/thunder_icon.svg"),
              size: 22, color: orangeColor),
          onPressed: null,
        ),
      ),
      body: GetBuilder<MaxSubscriptionController>(builder: (context) {
        if (maxSubscriptionController.isFetching) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              children: [
                Text(
                  maxSubscriptionModel.text!,
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 20),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  image: maxSubscriptionModel.newPromoPrice ==
                                          null
                                      ? null
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/icons/strike_through.png'),
                                          fit: BoxFit.fitWidth),
                                ),
                                child: Text(
                                    "${maxSubscriptionModel.price!.ceil()} دج",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 27,
                                        color: orangeColor,
                                        fontFamily: 'Cairo')),
                              ),
                              if (maxSubscriptionModel.newPromoPrice != null)
                                Text(
                                  " ${maxSubscriptionModel.newPromoPrice!.ceil()} دج",
                                  style: const TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w800,
                                      color: blackColor,
                                      fontFamily: 'Cairo'),
                                )
                            ],
                          ),
                          const SizedBox(height: 5),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: maxSubscriptionModel.prosList!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                      child: Text(
                                    maxSubscriptionModel.prosList![index],
                                    style: const TextStyle(
                                        fontFamily: 'Cairo', fontSize: 17),
                                  ))
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 20);
                            },
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                if (currentUserInfos.isSubbed)
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                                style: const TextStyle(
                                    fontFamily: 'Cairo', fontSize: 21),
                                TextSpan(children: [
                                  const TextSpan(
                                      text: "تاريخ الإشتراك : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: currentUserInfos.subStartingDay),
                                ])),
                            Text.rich(
                                style: const TextStyle(
                                    fontFamily: 'Cairo', fontSize: 21),
                                TextSpan(children: [
                                  const TextSpan(
                                      text: "تاريخ نهاية الإشتراك : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: currentUserInfos.subEndingingDay),
                                ])),
                            const SizedBox(height: 5),
                          ],
                        )),
                  ),
                const SizedBox(height: 30),
                currentUserInfos.isSubbed
                    ? TextButton.icon(
                        onPressed: null,
                        label: Container(
                            height: 40,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,

                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: lightBlueColor.withOpacity(0.2)),
                              BoxShadow(
                                  blurRadius: 20,

                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: lightBlueColor.withOpacity(0.2)),
                              BoxShadow(
                                  blurRadius: 20,

                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: lightBlueColor.withOpacity(0.2)),
                              BoxShadow(
                                  blurRadius: 20,
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: lightBlueColor.withOpacity(0.2)),
                            ]),
                            child: ImageIcon(
                                Svg("assets/icons/thunder_outer_icon.svg"))),
                        icon: Text("أنت ماكس",
                            style: TextStyle(fontFamily: 'Cairo')))
                    : TextButton(
                        onPressed: () {
                          Get.toNamed("/OrderBook", arguments: {
                            "1": OrderType
                                .maxSubscription, //////////////////////////
                            "2": maxSubscriptionModel,
                          });
                        },
                        child: const Text(
                          "إشترك الان",
                          style: TextStyle(fontFamily: 'Cairo'),
                        ))
              ]);
        }
      }),
    );
  }
}
