import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';
import '../controller/book_details_controller.dart';
import '../model/book_model.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    final BookDetailsController bookDetailsController = Get.find();
    BookModel bookModel = bookDetailsController.bookModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bookModel.title!,
          style: TextStyle(fontFamily: 'Cairo', fontSize: 15),
        ),
        bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const IconButtonBack()),
      ),
      body: PDF(
              pageSnap: false,
              pageFling: false,
              swipeHorizontal: false,
              onPageChanged: (page, total) {
                print(page);
              },
              nightMode: false)
          .cachedFromUrl(bookModel.url!),
    );
  }
}
