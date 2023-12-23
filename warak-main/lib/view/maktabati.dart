import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak/controller/maktabati_controller.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';

class Maktabati extends StatelessWidget {
  const Maktabati({super.key});

  @override
  Widget build(BuildContext context) {
    final MaktabatiController maktabatiController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
        title: const Text("مكتبتي"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.77),
        itemCount: maktabatiController.favoriteBooks.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed("/BookDetails",
                  arguments:
                      maktabatiController.favoriteBooks.values.elementAt(index));
            },
            child: BookThumnail(
                url: maktabatiController.favoriteBooks.values
                    .elementAt(index)
                    .thumbnail!),
          );
        },
      ),
    );
  }
}
