import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

import '../main.dart';
import '../model/book_model.dart';

class RequestedBooksController extends GetxController {
  AppBarType appBarType = Get.arguments["0"];
  Map<String, BookModel> requestedBooks = Get.arguments["1"];
  String? appBarText = Get.arguments["2"];
  dqs() async {
    for (var i = 0; i < 12; i++) {
      await FirebaseFirestore.instance.collection("books").doc().set({
        "bookAbout": requestedBooks.values.elementAt(0).aboutBook,
        "bookAuthorID": requestedBooks.values.elementAt(0).authorId,
        "bookAuthorName": requestedBooks.values.elementAt(0).authorName,
        "bookCategory": requestedBooks.values.elementAt(0).category,
        "bookCategoryID": requestedBooks.values.elementAt(0).categoryID,
        "bookId": requestedBooks.values.elementAt(0).id,
        "bookPublishingHouse":
            requestedBooks.values.elementAt(0).publishingHouse,
        "bookRatings": requestedBooks.values.elementAt(0).ratings,
        "bookReads": requestedBooks.values.elementAt(0).reads,
        "bookThumnail": requestedBooks.values.elementAt(0).thumbnail,
        "bookTitle": requestedBooks.values.elementAt(0).title,
        "bookURL": requestedBooks.values.elementAt(0).url,
      });
    }
  }


  getRequestedBooks() async {
    isFetching = true;
    if (requestedBooks.isNotEmpty) {
      switch (appBarType) {
        case AppBarType.mostRecentBooks:
          await FirebaseFirestore.instance
              .collection("books")
              .orderBy("bookDateAdded", descending: true)
              .startAfterDocument(await FirebaseFirestore.instance
                  .collection("books")
                  .doc(requestedBooks.values.last.id)
                  .get())
              .limit(9)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              getMore = false;
              print("*******dddddd***********");
            }
            for (int index = 0; index < value.docs.length; index++) {
              requestedBooks.addAll({
                value.docs[index].id: BookModel(
                    id: value.docs[index].id,
                    authorName: value.docs[index]["bookAuthorName"],
                    authorId: value.docs[index]["bookAuthorID"],
                    ratings: value.docs[index]["bookRatings"].toDouble(),
                    reads: value.docs[index]["bookReads"],
                    title: value.docs[index]["bookTitle"],
                    category: value.docs[index]["bookCategory"],
                    thumbnail: value.docs[index]["bookThumnail"],
                    aboutBook: value.docs[index]["bookAbout"],
                    url: value.docs[index]["bookURL"],
                    publishingHouse: value.docs[index]["bookPublishingHouse"],
                    price: value.docs[index]["bookPrice"].toDouble())
              });
            }

            print("AppBarType.mostRecentBooks");
          });
          break;

        case AppBarType.topRatedBooks:
          print("AppBarType.topRatedBooks");
          await FirebaseFirestore.instance
              .collection("books")
              .orderBy("bookRatings", descending: true)
              .startAfterDocument(await FirebaseFirestore.instance
                  .collection("books")
                  .doc(requestedBooks.values.last.id)
                  .get())
              .limit(9)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              getMore = false;
              print("*******dddddd***********");
            }
            print(value.docs.length);
            print("////////////////////");
            for (int index = 0; index < value.docs.length; index++) {
              requestedBooks.addAll({
                value.docs[index].id: BookModel(
                    id: value.docs[index].id,
                    authorName: value.docs[index]["bookAuthorName"],
                    authorId: value.docs[index]["bookAuthorID"],
                    ratings: value.docs[index]["bookRatings"].toDouble(),
                    reads: value.docs[index]["bookReads"],
                    title: value.docs[index]["bookTitle"],
                    category: value.docs[index]["bookCategory"],
                    thumbnail: value.docs[index]["bookThumnail"],
                    aboutBook: value.docs[index]["bookAbout"],
                    url: value.docs[index]["bookURL"],
                    publishingHouse: value.docs[index]["bookPublishingHouse"],
                    price: value.docs[index]["bookPrice"].toDouble())
              });
            }

            print("AppBarType.topRatedBooks");
          });
          break;

        case AppBarType.categoryBooks:
          print(requestedBooks.length);
          print("************");
          await FirebaseFirestore.instance
              .collection("books")
              .startAfterDocument(await FirebaseFirestore.instance
                  .collection("books")
                  .doc(requestedBooks.values.last.id)
                  .get())
              .where("bookCategoryID",
                  isEqualTo: requestedBooks.values.elementAt(0).categoryID)
              .limit(9)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              getMore = false;
              print("*******dddddd***********");
            }
            print(value.docs.length);
            print("////////////////////");
            for (int index = 0; index < value.docs.length; index++) {
              requestedBooks.addAll({
                value.docs[index].id: BookModel(
                    id: value.docs[index].id,
                    authorName: value.docs[index]["bookAuthorName"],
                    authorId: value.docs[index]["bookAuthorID"],
                    ratings: value.docs[index]["bookRatings"].toDouble(),
                    reads: value.docs[index]["bookReads"],
                    title: value.docs[index]["bookTitle"],
                    category: value.docs[index]["bookCategory"],
                    thumbnail: value.docs[index]["bookThumnail"],
                    aboutBook: value.docs[index]["bookAbout"],
                    url: value.docs[index]["bookURL"],
                    publishingHouse: value.docs[index]["bookPublishingHouse"],
                    price: value.docs[index]["bookPrice"].toDouble())
              });
            }

            print("AppBarType.categoryBooks");
          });
          break;
        default:
      }
    }
    isFetching = false;

    update();
  }

  var getMore = true;
  var isFetching = false;

  void _scrollListener() async {
    print("******************");
    if (getMore) {
      if (scrollController?.position.pixels ==
              scrollController?.position.maxScrollExtent &&
          isFetching == false) {
        isFetching = true;
        await getRequestedBooks();
        isFetching = false;
      }
    }
  }

  ScrollController? scrollController;
  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
    print(Get.arguments);
    return super.onStart;
  }

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);

    getRequestedBooks();
    print(requestedBooks.length);

    super.onInit();
  }
}
