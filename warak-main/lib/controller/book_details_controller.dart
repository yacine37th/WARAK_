import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:warak/controller/maktabati_controller.dart';
import 'package:warak/model/author_model.dart';
import 'package:warak/model/book_model.dart';
import 'package:warak/model/moraja3a_model.dart';
import 'package:warak/model/order_model.dart';

import '../main.dart';

class BookDetailsController extends GetxController {
  BookModel bookModel = Get.arguments;
  final MaktabatiController _maktabatiController = Get.find();
  Map<String, Moraja3aModel> moraja3at = {};
  AuthorModel? authorModel;
  String? inputMoraja3a;
  double inputRating = 3;
  double? myInitialRating;
  String? myInitialMoraja3a;

  bool canAdd = true; //to favbooks
  bool ratingExists = false;
  bool moraja3aExists = false;

  getBookAuthor() async {
    await FirebaseFirestore.instance
        .collection("authors")
        .doc(bookModel.authorId)
        .get()
        .then((value) {
      authorModel = AuthorModel(
          id: value.id,
          name: value["authorName"],
          myBooks: value["authorBooks"],
          imageURL: value["authorImageURL"],
          aboutAuthor: value["authorAboutMe"]);
    });
    Get.toNamed("/AuthorScreen", arguments: authorModel);
  }

  inputMoraja3aa(String input) {
    inputMoraja3a = input.trim();
    update();
  }

  inputRatingg(double input) {
    inputRating = input;
    print(inputRating);
    update();
  }

  addMoraja3a() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator());
    Moraja3aModel moraja3aModel = Moraja3aModel(
        id: currentUser!.uid,
        moraja3aUser:
            "${currentUserInfos.firstName!} ${currentUserInfos.lastName!}",
        moraja3aUserImage: currentUserInfos.imageURL,
        moraja3aText: inputMoraja3a);
    await FirebaseFirestore.instance
        .collection("books")
        .doc(bookModel.id)
        .collection("Moraja3atAndRatings")
        .doc(moraja3aModel.id)
        .set({
      "moraja3aUserID": currentUser!.uid,
      "moraja3aText": moraja3aModel.moraja3aText,
      "moraja3aUser": moraja3aModel.moraja3aUser,
      "moraja3aUserImage": moraja3aModel.moraja3aUserImage,
    }, SetOptions(merge: true));
    myInitialMoraja3a = inputMoraja3a;

    moraja3at.addAll({
      moraja3aModel.id!: Moraja3aModel(
        id: moraja3aModel.id!,
        moraja3aText: moraja3aModel.moraja3aText,
        moraja3aUser: moraja3aModel.moraja3aUser,
        moraja3aUserID: currentUser!.uid,
        moraja3aUserImage: moraja3aModel.moraja3aUserImage,
      )
    });
    navigator!.pop();
    navigator!.pop();

    update();
  }

  getAlreadyBookRatingAndMoraja3a() async {
    await FirebaseFirestore.instance
        .collection("books")
        .doc(bookModel.id)
        .collection("Moraja3atAndRatings")
        .doc(currentUser?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        if (value.data()!.containsKey("moraja3aText")) {
          myInitialMoraja3a = value.get("moraja3aText");
        }
        if (myInitialMoraja3a != null) {
          moraja3aExists = true;
        }

        if (value.data()!.containsKey("rating")) {
          myInitialRating = value.get("rating");
          inputRating = myInitialRating!;
          ratingExists = true;
        }
        // if (myInitialRating != null) {
        //   inputRating = myInitialRating!;
        //   ratingExists = true;
        // }
      }
    });
    update();
  }

  addRating() async {
    double bookRating = bookModel.ratings!;
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection("books")
        .doc(bookModel.id)
        .collection("Moraja3atAndRatings")
        .get();
    //////////////update bookRating math
    int bookRatingUsersCount = query.docs.length;
    bookRating = bookRating * bookRatingUsersCount;
    print(ratingExists);
    if (ratingExists) {
      print(bookRatingUsersCount);
      bookRating = bookRating - myInitialRating!.toInt();

      bookRating = bookRating + inputRating.toInt();
      bookRating = bookRating / bookRatingUsersCount;
      bookModel.ratings = bookRating;
    } else {
      bookRatingUsersCount++;
      bookRating = bookRating + inputRating.toInt();
      bookRating = bookRating / bookRatingUsersCount;
      bookModel.ratings = bookRating;
    }
    myInitialRating = inputRating;
    //////////////update bookRating math
    Get.defaultDialog(
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator());
    Moraja3aModel moraja3aModel =
        Moraja3aModel(id: currentUser!.uid, rating: inputRating);
    await FirebaseFirestore.instance
        .collection("books")
        .doc(bookModel.id)
        .collection("Moraja3atAndRatings")
        .doc(moraja3aModel.id)
        .set({
      "userID": currentUser!.uid,
      "rating": moraja3aModel.rating,
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection("books")
        .doc(bookModel.id)
        .update({"bookRatings": bookRating});
    navigator!.pop();
    navigator!.pop();

    update();
  }


  addToFavBooks() async {
    if (canAdd) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "يرجى الانتظار",
          content: const CircularProgressIndicator());
      currentUserInfos.favoriteBooks?.add(bookModel.id);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({"userFavoriteBooks": currentUserInfos. favoriteBooks});
      Get.back();
      MainFunctions.successSnackBar("تمت العملية بنجاح");
    } else {
      MainFunctions.somethingWentWrongSnackBar();
    }
    canAdd = false;
    _maktabatiController.getFavBooks();

    update();
  }

  removeFromFavBooks() async {
 
    Get.defaultDialog(
        barrierDismissible: false,
        title: "يرجى الانتظار",
        content: const CircularProgressIndicator());
    currentUserInfos. favoriteBooks?.removeWhere((element) {
      return element == bookModel.id;
    });
     await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"userFavoriteBooks": currentUserInfos. favoriteBooks});
    Get.back();
    MainFunctions.successSnackBar("تمت الازالة بنجاح");
    canAdd = true;
    _maktabatiController.getFavBooks ();
    Get.forceAppUpdate();
    update();
  }

  getMoraja3at() async {
    isFetching = true;
    String? lastMoraja3aID;
    if (moraja3at.isNotEmpty) {
      lastMoraja3aID = moraja3at.values.last.id;
      await FirebaseFirestore.instance
          .collection("books")
          .doc(bookModel.id)
          .collection("Moraja3atAndRatings")
          .startAfterDocument(await FirebaseFirestore.instance
              .collection("books")
              .doc(bookModel.id)
              .collection("Moraja3atAndRatings")
              .doc(lastMoraja3aID)
              .get())
          .limit(9)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          getMore = false;
          print("*******dddddd***********");
        }
        for (int index = 0; index < value.docs.length; index++) {
          if (value.docs[index].data().containsKey("moraja3aText")) {
            moraja3at.addAll({
              value.docs[index].id: Moraja3aModel(
                id: value.docs[index].id,
                moraja3aText: value.docs[index]["moraja3aText"],
                moraja3aUser: value.docs[index]["moraja3aUser"],
                //    rating: value.docs[index]["rating"].toDouble(),
                moraja3aUserImage: value.docs[index]["moraja3aUserImage"],
                moraja3aUserID: value.docs[index]["moraja3aUserID"],
              )
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(bookModel.id)
          .collection("Moraja3atAndRatings")
          .limit(9)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          getMore = false;
          print("*******dddddd***********");
        }
        for (int index = 0; index < value.docs.length; index++) {
          if (value.docs[index].data().containsKey("moraja3aText")) {
            moraja3at.addAll({
              value.docs[index].id: Moraja3aModel(
                id: value.docs[index].id,
                moraja3aText: value.docs[index]["moraja3aText"],
                moraja3aUser: value.docs[index]["moraja3aUser"],
                //   rating: value.docs[index]["rating"].toDouble(),
                moraja3aUserImage: value.docs[index]["moraja3aUserImage"],
                moraja3aUserID: value.docs[index]["moraja3aUserID"],
              )
            });
          }
        }
      });
    }

    isFetching = false;

    update();
  }

  var getMore = true;
  var isFetching = false;

  void _scrollListener() async {
    if (getMore) {
      if (scrollController?.position.pixels ==
              scrollController?.position.maxScrollExtent &&
          isFetching == false) {
        isFetching = true;
        await getMoraja3at();
        isFetching = false;
      }
    }
  }

  ScrollController? scrollController;
  @override
  void onInit() {
    getAlreadyBookRatingAndMoraja3a();

    scrollController = ScrollController()..addListener(_scrollListener);
    getMoraja3at();

    currentUserInfos.favoriteBooks?.forEach((element) {
      if (element == bookModel.id) {
        canAdd = false;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    print(bookModel);
    super.onReady();
  }
}
