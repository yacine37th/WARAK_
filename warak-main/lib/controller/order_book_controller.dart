import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:get/get.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import '../model/book_model.dart';
import '../model/max_subscription_model.dart';
import '../model/order_model.dart';
import '../model/wilaya_model.dart';

class OrderBookController extends GetxController {
  int currentStepIndex = 0;
  BookModel? bookModel = Get.arguments['0'];
  MaxSubscriptionModel? maxSubscriptionModel = Get.arguments['2'];

  OrderModel? orderModel;
  String? inputClientFirstName = currentUserInfos.firstName;
  String? inputClientLastName = currentUserInfos.lastName;
  String? inputClientPhoneNumber;
  String? inputClient3onwan;
  String? inputClientWilaya = currentUserInfos.i9ama;

  List<WilayaModel> wilayat = [];
  List<String> wilayaBaladiyat = [];

  PageController pageController = PageController(
    keepPage: true,
  );
  changeStepCurrentIndex(int value) {
    currentStepIndex = value;
    update();
  }

  next() async {
    if (currentStepIndex < 2) {
      currentStepIndex++;
      pageController.animateToPage(currentStepIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
    update();
  }

  chargilyApi() async {
    var url = Uri.parse('http://epay.chargily.com.dz/api/invoice');

    var headers = {
      'X-Authorization':
          'api_p2YZRTFP7AX9Vvc5t0aJt9YUkxVjg7owp5yxU7h54Vjc39lTQZCuZLt9UAZekBIU',
      'Accept': 'application/json'
    };

    var body = {
      'client': "${orderModel!.clientFirstName} ${orderModel!.clientLastName}",
      'client_email': orderModel!.clientEmail,
      'invoice_number': orderModel?.id!,
      'amount': orderModel!.price.toString(),
      'discount': '0',
      'back_url': 'https://google.com',
      'webhook_url': 'https://google.com',
      'mode': 'EDAHABIA',
      'comment': 'Purchase'
    };

    var response = await http.post(url, headers: headers, body: body);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (!await launchUrl(Uri.parse(responseBody["checkout_url"]),
          mode: LaunchMode.externalApplication)) {
        MainFunctions.somethingWentWrongSnackBar();
      }

      next();
    } else {
      MainFunctions.somethingWentWrongSnackBar();
    }
  }

  back() async {
    if (currentStepIndex > 0) {
      currentStepIndex--;
      pageController.animateToPage(currentStepIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }

    update();
  }

  inputFirstName(String input) {
    inputClientFirstName = input;
    orderModel!.clientFirstName = input;
    update();
  }

  inputLastName(String input) {
    inputClientLastName = input;
    orderModel!.clientLastName = input;

    update();
  }

  inputPhoneNumber(String input) {
    inputClientPhoneNumber = input;
    orderModel!.clientPhoneNumber = input;

    update();
  }

  initOrderModel() {
    if (Get.arguments['1'] == OrderType.electronicCopie ||
        Get.arguments['1'] == OrderType.physicalCopie) {
      orderModel = OrderModel(
        qunatity: 1,
        bookID: bookModel?.id,
        bookTitle: bookModel?.title,
        orderType: Get.arguments['1'],
        clientID: currentUser!.uid,
        clientImageURL: currentUserInfos.imageURL,
        clientEmail: currentUserInfos.email,
        clientFirstName: currentUserInfos.firstName,
        clientLastName: currentUserInfos.lastName,
        price: bookModel?.price,
        id: null,
        clientPhoneNumber: null,
        isPayed: false,
        proofImageURL: "",
      );
    } else if (Get.arguments['1'] == OrderType.maxSubscription) {
      orderModel = OrderModel(
        qunatity: 1,
        bookID: null,
        bookTitle: null,
        orderType: Get.arguments['1'],
        clientID: currentUser!.uid,
        clientImageURL: currentUserInfos.imageURL,
        clientEmail: currentUserInfos.email,
        clientFirstName: currentUserInfos.firstName,
        clientLastName: currentUserInfos.lastName,
        price:
            maxSubscriptionModel?.newPromoPrice ?? maxSubscriptionModel?.price,
        id: null,
        clientPhoneNumber: null,
        isPayed: false,
        proofImageURL: "",
      );
    }
  }

  getwilayat() async {
    await FirebaseFirestore.instance.collection("wilayat").get().then((value) {
      for (int index = 0; index < value.docs.length; index++) {
        wilayat.add(WilayaModel(
            wilaya: value.docs[index]["wilayaName"],
            wilayaBaladiyat:
                List<String>.from(value.docs[index]["wilayaBaladiyat"])));
      }
    });

    wilayat.sort(
      (a, b) {
        return a.wilaya!.toLowerCase().compareTo(b.wilaya!.toLowerCase());
      },
    );

    update();
  }

  int? indexOfWilayaSelected;
  getBaladiayt(int index) {
    //input wilaya too
    orderModel?.clientWilaya = wilayat[index].wilaya;
    wilayaBaladiyat.clear();
    wilayaBaladiyat = wilayat[index].wilayaBaladiyat!;
    print(wilayaBaladiyat.length);
    indexOfWilayaSelected = index;

    print(orderModel?.clientWilaya);
    update();
  }

  inputBaladiya(input) {
    orderModel?.clienBaladiya = input;
    print(orderModel?.clienBaladiya);

    update();
  }

  makeAnOrder() async {
    String orderType;

    if (orderModel!.orderType == OrderType.electronicCopie) {
      DocumentReference orderRef =
          FirebaseFirestore.instance.collection('ordersElectronic').doc();
      orderModel!.id = orderRef.id;
      orderType = "نسخة الكترونية";
      await FirebaseFirestore.instance
          .collection("ordersElectronic")
          .doc(orderRef.id)
          .set({
        "orderID": orderRef.id,
        "orderClientEmail": orderModel!.clientEmail,
        "orderClientFirstName": orderModel!.clientFirstName,
        "orderClientLastName": orderModel!.clientLastName,
        "orderBookID": orderModel!.bookID,
        "orderProofImageURL": orderModel!.proofImageURL,
        "orderBookTitle": orderModel!.bookTitle,
        "orderOrderType": orderType,
        "orderPhoneNumber": orderModel!.clientPhoneNumber,
        "orderPayed?": orderModel!.isPayed,
        "orderPrice": orderModel!.price,
        "orderDate": FieldValue.serverTimestamp(),
      }).whenComplete(() async {
        orderModel!.id = orderRef.id;

        currentUserInfos.ordersElectronicBooks!.add(orderModel!.bookID);
        if (orderModel!.orderType == OrderType.electronicCopie) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.uid)
              .update({
            "userOrdersElectronicBooks": currentUserInfos.ordersElectronicBooks!
          });
        }
      });
    } else if (orderModel!.orderType == OrderType.physicalCopie) {
      DocumentReference orderRef =
          FirebaseFirestore.instance.collection('ordersPhysical').doc();
      orderModel!.id = orderRef.id;
      orderType = "نسخة ورقية";
      await FirebaseFirestore.instance
          .collection("ordersPhysical")
          .doc(orderRef.id)
          .set({
        "orderID": orderRef.id,
        "orderClientEmail": orderModel!.clientEmail,
        "orderClientFirstName": orderModel!.clientFirstName,
        "orderClientLastName": orderModel!.clientLastName,
        "orderBookID": orderModel!.bookID,
        "orderProofImageURL": orderModel!.proofImageURL,
        "orderBookTitle": orderModel!.bookTitle,
        "orderOrderType": orderType,
        "orderPhoneNumber": orderModel!.clientPhoneNumber,
        "orderPayed?": orderModel!.isPayed,
        "orderPrice": orderModel!.price,
        "orderDate": FieldValue.serverTimestamp(),
        "orderWilaya": orderModel?.clientWilaya,
        "orderBaladiya": orderModel?.clienBaladiya,
        "order3onwan": orderModel?.client3onwan,
      }).whenComplete(() async {
        orderModel!.id = orderRef.id;
      });
    } else if (orderModel!.orderType == OrderType.maxSubscription) {
      DocumentReference orderRef =
          FirebaseFirestore.instance.collection('orderMaxSubscriptions').doc();
      orderModel!.id = orderRef.id;
      orderType = "إشتراك ماكس";
      await FirebaseFirestore.instance
          .collection("orderMaxSubscriptions")
          .doc(orderRef.id)
          .set({
        "orderID": orderRef.id,
        "orderClientEmail": orderModel!.clientEmail,
        "orderClientFirstName": orderModel!.clientFirstName,
        "orderClientLastName": orderModel!.clientLastName,
        "orderProofImageURL": orderModel!.proofImageURL,
        "orderOrderType": orderType,
        "orderPhoneNumber": orderModel!.clientPhoneNumber,
        "orderPayed?": orderModel!.isPayed,
        "orderPrice": orderModel!.price,
        "orderDate": FieldValue.serverTimestamp(),
      }).whenComplete(() async {
        orderModel!.id = orderRef.id;
      });
    }

    chargilyApi();

    update();
  }

  @override
  void onInit() {
    getwilayat();
    initOrderModel();
    super.onInit();
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    bool success = false;

    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = await EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = true;
      }).catchError((error) {
        print(error);
      });
    }).catchError((err) {
      print(err);
    });

    return success;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void input3onwan(String input) {
    inputClient3onwan = input;
    orderModel!.client3onwan = input;

    update();
  }

  void inputWilaya(String input) {
    inputClientWilaya = input;
    orderModel!.clientWilaya = input;

    update();
  }

  UploadTask? uploadTask;
  File? pickedImage;
  uploadSSProof() async {
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
            child: const Text("افتح اعدادات التطبيق")),
      );
    } else if (status.isGranted) {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 85);
        if (image == null) return;
        pickedImage = File(image.path);

        var size = pickedImage?.readAsBytesSync().lengthInBytes;
        if (size! <= 2097152) {
          try {
            Get.defaultDialog(
                onWillPop: () {
                  return Future.value();
                },
                barrierDismissible: false,
                title: "يرجى الانتظار",
                content: const CircularProgressIndicator());
            var path = 'orders_screen_shots/${orderModel!.id}';
            var file = pickedImage!;
            //FirebaseStorage
            final ref = FirebaseStorage.instance.ref().child(path);
            uploadTask = ref.putFile(file);

            final snapshot = await uploadTask!.whenComplete(() {});
            // The link to the profil image ///////////////////////////////////////////////
            final urldownload = await snapshot.ref.getDownloadURL();

            //////////////////////////////////////---------------------URL --------------------------////////////////////////////////////
            print('Download Link of the profil image: $urldownload');
            orderModel!.proofImageURL = urldownload;
            if (orderModel!.orderType == OrderType.electronicCopie) {
              await FirebaseFirestore.instance
                  .collection("ordersElectronic")
                  .doc(orderModel!.id)
                  .update({"orderProofImageURL": orderModel!.proofImageURL});
            } else if (orderModel!.orderType == OrderType.physicalCopie) {
              await FirebaseFirestore.instance
                  .collection("ordersPhysical")
                  .doc(orderModel!.id)
                  .update({"orderProofImageURL": orderModel!.proofImageURL});
            }

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

    update();
  }
}
