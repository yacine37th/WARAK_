import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/Themes/colors.dart';
import 'package:warak/model/user_model.dart';
import 'package:warak/view/widgets.dart';

import '../controller/maktabati_controller.dart';
import '../main.dart';
import '../model/book_model.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final MaktabatiController maktabatiController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text("حسابي"),
        bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 2),
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
              // background image and bottom contents
              Container(
                  clipBehavior: Clip.none,
                  height: 160.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 200,
                            blurStyle: BlurStyle.solid,
                            color: MainFunctions.generatePresizedColor(
                                currentUserInfos.lastName!.length +
                                    currentUserInfos.firstName!.length),
                            offset: Offset(0, 1))
                      ],
                      color: MainFunctions.generatePresizedColor(
                          currentUserInfos.lastName!.length +
                              currentUserInfos.firstName!.length),
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/account_background.jpg"),
                        fit: BoxFit.fitWidth,
                      )),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  )),
              // Profile image
              Positioned(
                top: 100.0, // (background container size) - (circle height / 2)
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: 130,
                            width: 130,
                            child: CircleAvatar(
                                backgroundColor: currentUserInfos.imageURL == ""
                                    ? whiteColor
                                    : MainFunctions.generatePresizedColor(
                                        currentUserInfos.lastName!.length +
                                            currentUserInfos.firstName!.length),
                                child: Container(
                                    height: 125,
                                    width: 125,
                                    child: GetBuilder<MaktabatiController>(
                                        builder: (context) {
                                      return ProfilePicture();
                                    })))),
                        Text(
                            "${currentUserInfos.firstName!} ${currentUserInfos.lastName!}"),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        maktabatiController.uploadPicture();
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: whiteColor,
                            ),
                            color: orangeColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const ImageIcon(
                          color: whiteColor,
                          size: 22,
                          Svg(
                            "assets/icons/edit_photo_icon.svg",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 100),
          // Divider(
          //   color: orangeColor,
          //   thickness: 2,
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "السيرة الذاتية",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: blackColor,
                                      onChanged: (input) {
                                        maktabatiController.inputAboutMe(input);
                                      },
                                      maxLength: 255,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: greyColor),
                                          focusColor: blackColor,
                                          fillColor: blackColor,
                                          disabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          hintText: "أدخل سيرتك الذاتية"),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              maktabatiController.editAboutMe();

                                              navigator!.pop();
                                            },
                                            child: Text("تأكيد")),
                                        const SizedBox(width: 10),
                                        TextButton(
                                            onPressed: () {
                                              navigator!.pop();
                                            },
                                            child: Text("الغاء"))
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: whiteColor,
                                ),
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const ImageIcon(
                              color: whiteColor,
                              size: 22,
                              Svg("assets/icons/edit_icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                    GetBuilder<MaktabatiController>(builder: (context) {
                      return Text(
                        currentUserInfos.aboutMe != ""
                            ? currentUserInfos.aboutMe!
                            : "لا توجد معلومات",
                        style: TextStyle(color: greyColor, fontSize: 16),
                      );
                    }),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          "مقيم في ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: blackColor,
                                      onChanged: (input) {
                                        maktabatiController.inputI9ama(input);
                                      },
                                      maxLength: 255,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: greyColor),
                                          focusColor: blackColor,
                                          fillColor: blackColor,
                                          disabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          hintText: "أدخل مكان إقامتك"),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              maktabatiController.editI9ama();

                                              navigator!.pop();
                                            },
                                            child: Text("تأكيد")),
                                        const SizedBox(width: 10),
                                        TextButton(
                                            onPressed: () {
                                              navigator!.pop();
                                            },
                                            child: Text("الغاء"))
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: whiteColor,
                                ),
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const ImageIcon(
                              color: whiteColor,
                              size: 22,
                              Svg("assets/icons/edit_icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                    GetBuilder<MaktabatiController>(builder: (context) {
                      return Text(
                        currentUserInfos.i9ama != ""
                            ? currentUserInfos.i9ama!
                            : "لا توجد معلومات",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 16,
                        ),
                      );
                    }),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          "حسابي على الأنستغرام",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: blackColor,
                                      onChanged: (input) {
                                        maktabatiController
                                            .inputInstaAccount(input);
                                      },
                                      maxLength: 255,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: greyColor),
                                          focusColor: blackColor,
                                          fillColor: blackColor,
                                          disabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          hintText: "أدخل حسابك في الأنستغرام"),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              maktabatiController
                                                  .editInstaAccount();

                                              navigator!.pop();
                                            },
                                            child: Text("تأكيد")),
                                        const SizedBox(width: 10),
                                        TextButton(
                                            onPressed: () {
                                              navigator!.pop();
                                            },
                                            child: Text("الغاء"))
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: whiteColor,
                                ),
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const ImageIcon(
                              color: whiteColor,
                              size: 22,
                              Svg("assets/icons/edit_icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                    GetBuilder<MaktabatiController>(builder: (context) {
                      return Text(
                        currentUserInfos.instaAccount != ""
                            ? currentUserInfos.instaAccount!
                            : "لا توجد معلومات",
                        style: TextStyle(color: greyColor, fontSize: 16),
                      );
                    }),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          "حسابي على الفايسبوك",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: blackColor,
                                      onChanged: (input) {
                                        maktabatiController
                                            .inputFacebookAccount(input);
                                      },
                                      maxLength: 255,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: greyColor),
                                          focusColor: blackColor,
                                          fillColor: blackColor,
                                          disabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: greyColor)),
                                          hintText: "أدخل حسابك في الفايسبوك"),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              maktabatiController
                                                  .editFacebookAccount();

                                              navigator!.pop();
                                            },
                                            child: Text("تأكيد")),
                                        const SizedBox(width: 10),
                                        TextButton(
                                            onPressed: () {
                                              navigator!.pop();
                                            },
                                            child: Text("الغاء"))
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          icon: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: whiteColor,
                                ),
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const ImageIcon(
                              color: whiteColor,
                              size: 22,
                              Svg("assets/icons/edit_icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                    GetBuilder<MaktabatiController>(builder: (context) {
                      return Text(
                        currentUserInfos.facebookAccount != ""
                            ? currentUserInfos.facebookAccount!
                            : "لا توجد معلومات",
                        style: TextStyle(color: greyColor, fontSize: 16),
                      );
                    }),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "مكتبتي",
                            style: TextStyle(
                                fontFamily: 'Cairo Bold', fontSize: 18),
                          ),
                          SizedBox(width: 5),
                          ImageIcon(
                            Svg("assets/icons/maktabati_icon.svg"),
                            color: bluePurpleColor,
                          )
                        ],
                      ),
                      TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(transparentColor),
                              iconColor: MaterialStateProperty.all(orangeColor),
                              foregroundColor:
                                  MaterialStateProperty.all(orangeColor)),
                          onPressed: () {
                            Get.toNamed("/RequestedBooks", arguments: {
                              "0": AppBarType.maktabati,
                              "1": maktabatiController.maktabati
                            });
                          },
                          icon: const Text("المزيد",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo')),
                          label: const Icon(Icons.arrow_back_ios_new))
                    ],
                  ),
                ),
                GetBuilder<MaktabatiController>(builder: (context) {
                  if (maktabatiController.maktabati.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "مكتبتي فارغة",
                        style: TextStyle(
                          fontSize: 16,
                          color: greyColor,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 190,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        itemCount: maktabatiController.maktabati.length < 10
                            ? maktabatiController.maktabati.length
                            : 10,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed("/BookDetails",
                                  arguments: maktabatiController
                                      .maktabati.values
                                      .elementAt(index));
                            },
                            child: SizedBox(
                              width: 140,
                              child: BookThumnail(
                                  url: maktabatiController.maktabati.values
                                      .elementAt(index)
                                      .thumbnail!),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(height: 20)
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "كتبي المفضلة",
                            style: TextStyle(
                                fontFamily: 'Cairo Bold', fontSize: 18),
                          ),
                          SizedBox(width: 5),
                          ImageIcon(
                            Svg("assets/icons/heart_icon.svg"),
                            color: redColor,
                          )
                        ],
                      ),
                      //   if (maktabatiController.favoriteBooks.isNotEmpty)
                      TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(transparentColor),
                              iconColor: MaterialStateProperty.all(orangeColor),
                              foregroundColor:
                                  MaterialStateProperty.all(orangeColor)),
                          onPressed: () {
                            Get.toNamed("/RequestedBooks", arguments: {
                              "0": AppBarType.favoriteBooks,
                              "1": maktabatiController.favoriteBooks
                            });
                          },
                          icon: const Text("المزيد",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo')),
                          label: const Icon(Icons.arrow_back_ios_new))
                    ],
                  ),
                ),
                GetBuilder<MaktabatiController>(builder: (context) {
                  if (maktabatiController.favoriteBooks.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "كتبي المفضلة فارغة",
                        style: TextStyle(
                          fontSize: 16,
                          color: greyColor,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 190,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        itemCount: maktabatiController.favoriteBooks.length < 10
                            ? maktabatiController.favoriteBooks.length
                            : 10,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed("/BookDetails",
                                  arguments: maktabatiController
                                      .favoriteBooks.values
                                      .elementAt(index));
                            },
                            child: SizedBox(
                              width: 140,
                              child: BookThumnail(
                                  url: maktabatiController.favoriteBooks.values
                                      .elementAt(index)
                                      .thumbnail!),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(height: 10)
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
