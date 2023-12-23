import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak/Themes/colors.dart';

import '../controller/tasnifat_controller.dart';
import '../model/book_model.dart';

class Tasnifat extends StatelessWidget {
  const Tasnifat({super.key});

  @override
  Widget build(BuildContext context) {
    final TasnifatController tasnifatController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
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
        title: const Text("التصنيفات"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1),
        itemCount: tasnifatController.categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => orangeColor.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () async {
              await tasnifatController.filterByCategory(index);
              Get.toNamed("/RequestedBooks", arguments: {
                "0": AppBarType.categoryBooks,
                "1": tasnifatController.books,
                "2": tasnifatController.categories.values.elementAt(index).name
              });
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: orangeColor, width: 2)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenWidth * 0.17,
                    width: screenWidth * 0.17,
                    child: CachedNetworkImage(
                        imageUrl: tasnifatController.categories.values
                            .elementAt(index)
                            .icon!,
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Text(
                      tasnifatController.categories.values
                          .elementAt(index)
                          .name!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cairo'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
