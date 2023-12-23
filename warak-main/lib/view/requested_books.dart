import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak/controller/requested_books_controller.dart';
import 'package:warak/model/book_model.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';

class RequestedBooks extends StatelessWidget {
  const RequestedBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestedBooksController requestedBooksController = Get.find();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigator!.pop();
              },
              icon: const IconButtonBack()),
          bottom: PreferredSize(
              preferredSize: Size(0, 0),
              child: Container(
                color: orangeColor,
                height: 1,
              )),
          title: ReqBooksAppBarTitle(
            appBarType: requestedBooksController.appBarType,
            categoryName: requestedBooksController.appBarText,
          )),
      body: GetBuilder<RequestedBooksController>(builder: (context) {
        if (requestedBooksController.requestedBooks.isEmpty) {
          return const Center(
            child: Text("لا يوجد كتب"),
          );
        } else {
          return ListView(
            physics: const BouncingScrollPhysics(),
            controller: requestedBooksController.scrollController,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.77),
                itemCount: requestedBooksController.requestedBooks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed("/BookDetails",
                          arguments: requestedBooksController
                              .requestedBooks.values
                              .elementAt(index));
                    },
                    child: BookThumnail(
                        url: requestedBooksController.requestedBooks.values
                            .elementAt(index)
                            .thumbnail!),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  if (requestedBooksController.isFetching) {
                    return Column(
                      children: const [
                        SizedBox(height: 60),
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 60)
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          );
        }
      }),
    );
  }
}

class ReqBooksAppBarTitle extends StatelessWidget {
  const ReqBooksAppBarTitle(
      {super.key, required this.appBarType, this.categoryName});
  final AppBarType appBarType;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    if (appBarType == AppBarType.categoryBooks) {
      return Text(categoryName!);
    } else if (appBarType == AppBarType.favoriteBooks) {
      return const Text("كتبي المفضلة");
    } else if (appBarType == AppBarType.mostRecentBooks) {
      return const Text("أحدث الكتب");
    } else if (appBarType == AppBarType.topRatedBooks) {
      return const Text("الأكثر تقييما");
    } else if (appBarType == AppBarType. maktabati) {
      return const Text("مكتبتي");
    } else {
      return Text(categoryName!);
    }
  }
}
