import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:warak/model/author_model.dart';
import 'package:warak/model/book_model.dart';

import '../main.dart';

class AuthorScreenController extends GetxController {
  AuthorModel authorModel = Get.arguments;
  Map<String, BookModel> authorBooks = {};

  var getMore = true;
  var isFetching = false;
  ScrollController? scrollController;

  getAuthorsBooks() async {
    isFetching = true;
    // if (authorBooks.isEmpty) {
    for (var i = 0; i < authorModel.myBooks!.length; i++) {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(authorModel.myBooks![i])
          .get()
          .then((value) {
        if (value.exists) {
          authorBooks.addAll({
            value.id: BookModel(
                id: value.id,
                authorName: value["bookAuthorName"],
                authorId: value["bookAuthorID"],
                ratings: value["bookRatings"].toDouble(),
                reads: value["bookReads"],
                title: value["bookTitle"],
                category: value["bookCategory"],
                thumbnail: value["bookThumnail"],
                aboutBook: value["bookAbout"],
                url: value["bookURL"],
                publishingHouse: value["bookPublishingHouse"],
                price: value["bookPrice"].toDouble())
          });
        }
      });
    }

    /////////////
    // await FirebaseFirestore.instance
    //     .collection("books")
    //     .where("bookAuthorID", isEqualTo: authorModel.id)
    //     .limit(9)
    //     .get()
    //     .then((value) {
    //   if (value.docs.isEmpty) {
    //     getMore = false;
    //     print("*******dddddd***********");
    //   }
    //   print(value.docs.length);
    //   print("////////////////////");
    //   for (int index = 0; index < value.docs.length; index++) {
    //     authorBooks.addAll({
    //       value.docs[index].id: BookModel(
    //         id: value.docs[index].id,
    //         authorName: value.docs[index]["bookAuthorName"],
    //         authorId: value.docs[index]["bookAuthorID"],
    //         ratings: value.docs[index]["bookRatings"].toDouble(),
    //         reads: value.docs[index]["bookReads"],
    //         title: value.docs[index]["bookTitle"],
    //         category: value.docs[index]["bookCategory"],
    //         thumbnail: value.docs[index]["bookThumnail"],
    //         aboutBook: value.docs[index]["bookAbout"],
    //         url: value.docs[index]["bookURL"],
    //         publishingHouse: value.docs[index]["bookPublishingHouse"],
    //       )
    //     });
    //   }
    // });
    // }
    //else {
    //   lastauthorBookID = authorBooks.values.last.id;
    //   await FirebaseFirestore.instance
    //       .collection("books")
    //       .where("bookAuthorID", isEqualTo: authorModel.id)
    //       .startAfterDocument(await FirebaseFirestore.instance
    //           .collection("books")
    //           .doc(lastauthorBookID)
    //           .get())
    //       .limit(9)
    //       .get()
    //       .then((value) {
    //     if (value.docs.isEmpty) {
    //       getMore = false;
    //       print("*******dddddd***********");
    //     }
    //     for (int index = 0; index < value.docs.length; index++) {
    //       if (value.docs[index].data().containsKey("moraja3aText")) {
    //         authorBooks.addAll({
    //           value.docs[index].id: BookModel(
    //             id: value.docs[index].id,
    //             authorName: value.docs[index]["bookAuthorName"],
    //             authorId: value.docs[index]["bookAuthorID"],
    //             ratings: value.docs[index]["bookRatings"].toDouble(),
    //             reads: value.docs[index]["bookReads"],
    //             title: value.docs[index]["bookTitle"],
    //             category: value.docs[index]["bookCategory"],
    //             thumbnail: value.docs[index]["bookThumnail"],
    //             aboutBook: value.docs[index]["bookAbout"],
    //             url: value.docs[index]["bookURL"],
    //             publishingHouse: value.docs[index]["bookPublishingHouse"],
    //           )
    //         });
    //       }
    //     }
    //   });
    // }
    isFetching = false;
    update();
  }

  void _scrollListener() async {
    if (getMore) {
      print("object");

      if (scrollController?.position.pixels ==
              scrollController?.position.maxScrollExtent &&
          isFetching == false) {
        isFetching = true;

        // await getMoreSearchedResults();
        isFetching = false;
      }
    }
  }

  @override
  void onInit() {
    print(authorModel.myBooks);
    scrollController = ScrollController()..addListener(_scrollListener);
    getAuthorsBooks();
    super.onInit();
  }
}
