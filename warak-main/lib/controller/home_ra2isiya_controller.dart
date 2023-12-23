import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:get/get.dart";
import 'package:warak/model/custom_category_model.dart';
import 'package:warak/model/promo_model.dart';

import '../main.dart';
import '../model/book_model.dart';

class HomeRa2isiyaController extends GetxController {
  Map<String, BookModel> mostRecentBooks = {};
  Map<String, BookModel> topRatedBooks = {};

  Future getMostRecentBooks() async {
    //  .startAfterDocument(await FirebaseFirestore.instance
    //         .collection("books")
    //         .doc(mostRecentBooks.values.last.id)
    //         .get())
    mostRecentBooks.clear();
    await FirebaseFirestore.instance
        .collection("books")
        .orderBy("bookDateAdded", descending: true)
        .limit(9)
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        mostRecentBooks.addAll({
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
    });
    update();
  }

  Future geTopRatedBooks() async {
    await FirebaseFirestore.instance
        .collection("books")
        .orderBy("bookRatings", descending: true)
        .limit(9)
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        topRatedBooks.addAll({
          value.docs[index].id: BookModel(
              id: value.docs[index].id,
              authorName: value.docs[index]["bookAuthorName"],
              authorId: value.docs[index]["bookAuthorID"],
              ratings: value.docs[index]["bookRatings"].toDouble(),
              reads: value.docs[index]["bookReads"],
              title: value.docs[index]["bookTitle"],
              category: value.docs[index]["bookCategory"],
              thumbnail: value.docs[index]["bookThumnail"],
              url: value.docs[index]["bookURL"],
              aboutBook: value.docs[index]["bookAbout"],
              publishingHouse: value.docs[index]["bookPublishingHouse"],
              price: value.docs[index]["bookPrice"].toDouble())
        });
      }
    });

    update();
  }

  qdsdqsdafq() async {
    var x = await FirebaseFirestore.instance.collection("books").doc().id;
///// upldoad f storage path books/x
    ///
    /// apres ktb nrml
    await FirebaseFirestore.instance.collection("books").doc(x).set({});

    print(x);
  }

  Map<String, BookModel> carouselBooks = {};

  getCarouselBooks() async {
    var tempIDList = {};
    await FirebaseFirestore.instance.collection("carousel").get().then((value) {
      for (int index = 0; index < value.docs.length; index++) {
        String? carouselUrl;
        if (value.docs[index].data().containsKey("carouselUrl")) {
          carouselUrl = value.docs[index]["carouselUrl"];
        }
        tempIDList.addAll({
          value.docs[index].id: [
            value.docs[index]["carouselThumbnail"],
            carouselUrl
          ]
        });
      }
    });

    for (int index = 0; index < tempIDList.length; index++) {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(tempIDList.keys.elementAt(index))
          .get()
          .then((value) {
        if (value.exists) {
          carouselBooks.addAll({
            value.id: BookModel(
                id: value.id,
                authorName: value["bookAuthorName"],
                authorId: value["bookAuthorID"],
                ratings: value["bookRatings"].toDouble(),
                reads: value["bookReads"],
                title: value["bookTitle"],
                category: value["bookCategory"],
                thumbnail: tempIDList.values.elementAt(index)[0] != ""
                    ? tempIDList.values.elementAt(index)[0]
                    : value["bookThumnail"],
                url: value["bookURL"],
                aboutBook: value["bookAbout"],
                publishingHouse: value["bookPublishingHouse"],
                price: value["bookPrice"].toDouble(),
                isCarouselBook: true)
          });
        } else {
          carouselBooks.addAll({
            value.id: BookModel(
                id: value.id,
                authorName: "",
                authorId: "",
                ratings: 0,
                reads: 0,
                title: "",
                category: "",
                thumbnail: tempIDList.values.elementAt(index)[0],
                url: tempIDList.values.elementAt(index)[1],
                aboutBook: "",
                publishingHouse: "",
                price: 0,
                isCarouselBook: false)
          });
        }
      });
    }
    print(carouselBooks.length);
    print("*/**************");

    update();
  }

  PromoModel? promoModel;
  getPromo() async {
    await FirebaseFirestore.instance
        .collection("promo")
        .doc("promo")
        .get()
        .then((value) {
      if (value.exists) {
        promoModel = PromoModel(
            text: value.data()!["promoText"],
            percentage:
                double.parse(value.data()!["promoPercentage"].toString())
                    .truncate());
      }
    });

    update();
  }

  Map<String, Map<String, BookModel>> customCategories = {};
  bool isFetching = true;
  getCustomCategories() async {
    customCategories.clear();
    Map<String, CustomCategoryModel> tempCustomCategories = {};
    await FirebaseFirestore.instance
        .collection("customCategories")
        .get()
        .then((value) {
      for (int index = 0; index < value.docs.length; index++) {
        tempCustomCategories.addAll({
          value.docs[index].id: CustomCategoryModel(
              id: value.docs[index].id,
              name: value.docs[index]["customCategoryName"],
              books: value.docs[index]["customCategoryBooksIDs"])
        });
      }
    });

    tempCustomCategories.forEach((key, value) {
      Map<String, BookModel> tempBooks = {};

      value.books?.forEach((element) async {
        await FirebaseFirestore.instance
            .collection("books")
            .doc(element)
            .get()
            .then((value) {
          tempBooks.addAll({
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
        }).whenComplete(() {
          isFetching = false;
        });
        print("*****************");
        customCategories.addAll({value.name!: tempBooks});
      });
    });
    update();
  }
  // FirebaseFirestore.instance
  //       .collection('collectionName')
  //       .where('fieldName', arrayContains: 'searchInput')
  //       .get();

  List keyWordsMaker(String text) {
    List<String> keyWordsList = [];
    String temp = "";
    for (var i = 0; i < text.length; i++) {
      if (text[i] == " ") {
        temp = "";
      } else {
        temp = temp + text[i];
        keyWordsList.add(temp.toLowerCase());
      }
    }
    return keyWordsList;
  }

  @override
  void onInit() {
    getCarouselBooks();

    getPromo();
    getCustomCategories();
    getMostRecentBooks();
    geTopRatedBooks();

    super.onInit();
  }
}
