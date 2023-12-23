import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../model/book_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MaktabatiController extends GetxController {
  Map<String, BookModel> favoriteBooks = {};
  Map<String, BookModel> maktabati = {};
  getMaktabatiBooks() {
    maktabati = {};
    currentUserInfos.maktabati?.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(element)
          .get()
          .then((value) {
        maktabati.addAll({
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
      });
    });
    update();
  }

  getFavBooks() {
    favoriteBooks = {};
    currentUserInfos.favoriteBooks?.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(element)
          .get()
          .then((value) {
        favoriteBooks.addAll({
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
      });
    });
    update();
  }

  @override
  void onInit() {
    getMaktabatiBooks();
    getFavBooks();
    super.onInit();
  }

  String? inputAboutMee;
  inputAboutMe(input) {
    inputAboutMee = input;

    update();
  }

  editAboutMe() async {
    currentUserInfos.aboutMe = inputAboutMee?.trim();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"userAboutMe": currentUserInfos.aboutMe});
    update();
  }

  UploadTask? uploadTask;

  uploadPicture() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      Get.defaultDialog(
        title: "اسمح للتطبيق باستعمال الصلاحيات اللازمة",
        content: TextButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 45))),
            onPressed: () {
              openAppSettings();
            },
            child: Text("افتح اعدادات التطبيق")),
      );
    } else if (status.isGranted) {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 85);
        if (image == null) return;
        MainFunctions.pickedImage = File(image.path);

        var size = MainFunctions.pickedImage?.readAsBytesSync().lengthInBytes;
        if (size! <= 2097152) {
          try {
            Get.defaultDialog(
                onWillPop: () {
                  return Future.value();
                },
                barrierDismissible: false,
                title: "يرجى الانتظار",
                content: const CircularProgressIndicator());
            var path = 'users/${currentUser!.uid}';
            var file = MainFunctions.pickedImage!;
            //FirebaseStorage
            final ref = FirebaseStorage.instance.ref().child(path);
            uploadTask = ref.putFile(file);

            final snapshot = await uploadTask!.whenComplete(() {});
            // The link to the profil image ///////////////////////////////////////////////
            final urldownload = await snapshot.ref.getDownloadURL();

            //////////////////////////////////////---------------------URL --------------------------////////////////////////////////////
            print('Download Link of the profil image: $urldownload');
            currentUserInfos.imageURL = urldownload;
            await FirebaseFirestore.instance
                .collection("users")
                .doc(currentUser!.uid)
                .update({"userImageURL": currentUserInfos.imageURL});
            Get.back();
          } catch (e) {
            Get.back();
            print(e);
          }
        } else {
          MainFunctions.somethingWentWrongSnackBar("حجم الصورة كبير");
        }
      } catch (e) {
        MainFunctions.somethingWentWrongSnackBar("هناك مشكلة ما");
      }
    }
    Get.forceAppUpdate();

    update();
  }

  String? inputInstaAccountt;
  inputInstaAccount(String input) {
    inputInstaAccountt = input;

    update();
  }

  editInstaAccount() async {
    currentUserInfos.instaAccount = inputInstaAccountt?.trim();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"userInstaAccount": currentUserInfos.instaAccount});
    update();
  }

  String? inputFacebookAccountt;

  inputFacebookAccount(String input) {
    inputFacebookAccountt = input;
    update();
  }

  editFacebookAccount() async {
    currentUserInfos.facebookAccount = inputFacebookAccountt?.trim();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"userFacebookAccount": currentUserInfos.facebookAccount});
    update();
  }

  String? inputI9amaa;

  void inputI9ama(String input) {
    inputI9amaa = input;
    update();
  }

  Future<void> editI9ama() async {
    currentUserInfos.i9ama = inputI9amaa?.trim();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"userI9ama": currentUserInfos.i9ama});
    update();
  }
}
