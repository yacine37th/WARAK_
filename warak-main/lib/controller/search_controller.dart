import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:warak/model/author_model.dart';

import '../main.dart';
import '../model/book_model.dart';

class SearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SearchType searchType = SearchType.bookType;
  Map<String, BookModel> searchedBooks = {};
  Map<String, AuthorModel> searchedAuthors = {};
  late TabController tabController;

  String? inputSearch = "";
  getInputSearch(input) {
    inputSearch = input;
    // update();
  }

  getSearched(String? inputSearch) async {
    inputSearch = inputSearch!.toLowerCase();
    isFetching = true;
    getMore = true;

    switch (searchType) {
      case SearchType.bookType:
        searchedBooks.clear();
        await FirebaseFirestore.instance
            .collection("books")
            .where('bookKeyWords', arrayContains: inputSearch)
            .limit(9)
            .get()
            .then((value) {
          for (int index = 0; index < value.docs.length; index++) {
            searchedBooks.addAll({
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
        }).whenComplete(() => isFetching = false);

        break;

      case SearchType.authorType:
        print("ssssssssssssssssssssssss");

        searchedAuthors.clear();
        await FirebaseFirestore.instance
            .collection("authors")
            .where('authorKeyWords', arrayContains: inputSearch)
            .limit(9)
            .get()
            .then((value) {
          for (int index = 0; index < value.docs.length; index++) {
            searchedAuthors.addAll({
              value.docs[index].id: AuthorModel(
                  id: value.docs[index].id,
                  imageURL: value.docs[index]["authorImageURL"],
                  name: value.docs[index]["authorName"],
                  myBooks: value.docs[index]["authorBooks"],
                  aboutAuthor: value.docs[index]["authorAboutMe"])
            });
          }
        }).whenComplete(() => isFetching = false);

        break;
      default:
    }

    update();
  }

  getMoreSearchedResults() async {
    isFetching = true;

    switch (searchType) {
      case SearchType.bookType:
        await FirebaseFirestore.instance
            .collection("books")
            .where('bookKeyWords', arrayContains: inputSearch)
            .startAfterDocument(await FirebaseFirestore.instance
                .collection("books")
                .doc(searchedBooks.values.last.id)
                .get())
            .limit(9)
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            getMore = false;
          } else {
            for (int index = 0; index < value.docs.length; index++) {
              searchedBooks.addAll({
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
          }
        }).whenComplete(() => isFetching = false);

        break;

      case SearchType.authorType:
        await FirebaseFirestore.instance
            .collection("authors")
            .where('authorKeyWords', arrayContains: inputSearch)
            .startAfterDocument(await FirebaseFirestore.instance
                .collection("authors")
                .doc(searchedAuthors.values.last.id)
                .get())
            .limit(9)
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            getMore = false;
          } else {
            for (int index = 0; index < value.docs.length; index++) {
              searchedAuthors.addAll({
                value.docs[index].id: AuthorModel(
                    id: value.docs[index].id,
                    imageURL: value.docs[index]["authorImageURL"],
                    name: value.docs[index]["authorName"],
                    myBooks: value.docs[index]["authorBooks"],
                    aboutAuthor: value.docs[index]["authorAboutMe"])
              });
            }
          }
        }).whenComplete(() => isFetching = false);

        break;
      default:
    }

    update();
  }

  var getMore = true;
  var isFetching = false;
  ScrollController? scrollController;

  void _scrollListener() async {
    if (getMore) {
      if (scrollController?.position.pixels ==
              scrollController?.position.maxScrollExtent &&
          isFetching == false) {
        isFetching = true;

        await getMoreSearchedResults();
   //     isFetching = false;
      }
    }
  }

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    tabController = TabController(vsync: this, length: 2);
    tabController.animation?.addListener(() {
      // print(tabController.index);
      // if (tabController.index == 0) {
      //   searchType = SearchType.bookType;
      //   getSearched(inputSearch);
      // } else if (tabController.index == 1) {
      //   searchType = SearchType.authorType;
      //   getSearched(inputSearch);
      // }

      if (tabController.indexIsChanging) {
        searchType = SearchType.values[tabController.index];
        if (inputSearch != null && inputSearch!.isNotEmpty) {
          getSearched(inputSearch);
        }
      }
    });

    super.onInit();
  }
}

enum SearchType { bookType, authorType, publishingHouseType }
