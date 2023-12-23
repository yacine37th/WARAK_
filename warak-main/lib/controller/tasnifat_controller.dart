import 'package:cloud_firestore/cloud_firestore.dart';
import "package:get/get.dart";
import 'package:warak/model/category_model.dart';

import '../main.dart';
import '../model/book_model.dart';

class TasnifatController extends GetxController {
  Map<String, CategoryModel> categories = {};
  Map<String, BookModel> books = {};
  geCategories() async {
    categories.clear();
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        categories.addAll({
          value.docs[index].id: CategoryModel(
            id: value.docs[index].id,
            name: value.docs[index]["categoryName"],
            icon: value.docs[index]["categoryIcon"],
          )
        });
      }
    });
    update();
  }

  Future<Map<String, BookModel>> filterByCategory(int index) async {
    books.clear();
    await FirebaseFirestore.instance
        .collection("books")
        .where("bookCategoryID", isEqualTo: categories.keys.elementAt(index))
        .limit(9)
        .get()
        .then((value) {
      for (int index = 0; index < value.docs.length; index++) {
        books.addAll({
          value.docs[index].id: BookModel(
              id: value.docs[index].id,
              authorName: value.docs[index]["bookAuthorName"],
              authorId: value.docs[index]["bookAuthorID"],
              ratings: value.docs[index]["bookRatings"].toDouble(),
              reads: value.docs[index]["bookReads"],
              title: value.docs[index]["bookTitle"],
              category: value.docs[index]["bookCategory"],
              categoryID: value.docs[index]["bookCategoryID"],
              thumbnail: value.docs[index]["bookThumnail"],
              aboutBook: value.docs[index]["bookAbout"],
              url: value.docs[index]["bookURL"],
              publishingHouse: value.docs[index]["bookPublishingHouse"],
              price: value.docs[index]["bookPrice"].toDouble())
        });
      }
    });
    print(books.length);
    return books;
  }

  @override
  void onInit() {
    geCategories();
    super.onInit();
  }
}
