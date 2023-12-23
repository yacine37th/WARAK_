import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/Themes/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:warak/controller/home_ra2isiya_controller.dart';
import 'package:warak/main.dart';
import 'package:warak/view/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_screen_controller.dart';
import '../model/book_model.dart';

class HomeRa2isiya extends StatelessWidget {
  const HomeRa2isiya({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeRa2isiyaController homeRa2isiyaController = Get.find();
    final HomeScreenController homeScreenController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text("الرئيسية"),
        bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
        actions: [
          TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150))),
                  backgroundColor: MaterialStateProperty.all(transparentColor)),
              onPressed: null,
              child: Row(
                children: [
                  Text(
                    currentUserInfos.isSubbed ? "ماكس" : "مجاني",
                    style: TextStyle(
                        fontFamily: 'ArefRuqaa',
                        fontWeight: FontWeight.bold,
                        color: currentUserInfos.isSubbed
                            ? orangeColor
                            : Colors.green,
                        fontSize: 21),
                  ),
                  currentUserInfos.isSubbed
                      ? const ImageIcon(Svg("assets/icons/thunder_icon.svg"),
                          size: 22, color: orangeColor)
                      : const SizedBox(),
                ],
              ))
        ],
      ),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(
                    "/SearchScreen",
                  );
                },
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: ImageIcon(
                        Svg("assets/icons/search_icon.svg"),
                        size: 20,
                      ),
                      prefixIconColor: orangeColor,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      focusColor: blackColor,
                      fillColor: blackColor,
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      hintStyle: TextStyle(
                          color: greyColor, fontFamily: 'Cairo', fontSize: 15),
                      hintText: "ابحث عن كتاب أو مؤلف"),
                  enabled: false,
                ),
              ),

              // const SizedBox(height: 20),
              // GetBuilder<HomeRa2isiyaController>(builder: (context) {
              //   if (homeRa2isiyaController.promoModel != null) {
              //     return Container(
              //       clipBehavior: Clip.antiAlias,
              //       padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(60),
              //         color: orangeColor,
              //       ),
              //       child: Row(children: [
              //         Expanded(
              //             child: Text(
              //           homeRa2isiyaController.promoModel!.text!,
              //           style: TextStyle(fontSize: 17, color: whiteColor),
              //         )),
              //         const SizedBox(width: 5),
              //         TextButton(
              //             style: ButtonStyle(
              //                 shape: MaterialStateProperty.all(
              //                     RoundedRectangleBorder(
              //                         side: BorderSide(color: whiteColor),
              //                         borderRadius:
              //                             BorderRadius.circular(60))),
              //                 foregroundColor:
              //                     MaterialStateProperty.all(whiteColor),
              //                 backgroundColor:
              //                     MaterialStateProperty.all(orangeColor)),
              //             onPressed: () {},
              //             child: Text("اشترك الآن"))
              //       ]),
              //     );
              //   } else {
              //     return const SizedBox();
              //   }
              // }),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.transparent, Colors.black])
                    .createShader(Rect.fromLTRB(rect.width / 0.9, 0, 0, 0));
              },
              blendMode: BlendMode.colorBurn,
              child: Container(
                height: 200,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image:
                      AssetImage("assets/images/subscribtion_background.jpg"),
                  fit: BoxFit.fitWidth,
                )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 25,
                              color: whiteColor),
                          children: [
                            TextSpan(
                              text: 'ورق ',
                            ),
                            TextSpan(
                              text: "ماكس",
                              style: TextStyle(
                                  color: orangeColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 10,

                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: whiteColor.withOpacity(0.1)),
                          BoxShadow(
                              blurRadius: 10,

                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: whiteColor.withOpacity(0.1)),
                          BoxShadow(
                              blurRadius: 10,

                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: whiteColor.withOpacity(0.1)),
                          BoxShadow(
                              blurRadius: 10,
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: whiteColor.withOpacity(0.1)),
                        ]),
                        child: const ImageIcon(
                            Svg("assets/icons/thunder_icon.svg", scale: 50),
                            size: 30,
                            color: orangeColor),
                      )
                    ],
                  ),
                  const Text(
                    "في كل مكان، بدون أنترنيــت",
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: 25, color: whiteColor),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          foregroundColor:
                              MaterialStateProperty.all(whiteColor),
                          backgroundColor: MaterialStateProperty.all(
                              orangeColor.withOpacity(0.4))),
                      onPressed: () {
                        homeScreenController.switchBetweenScreens(3);
                      },
                      child: const Text(
                        'إشترك الآن',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 22,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
            )
          ],
        ),
        GetBuilder<HomeRa2isiyaController>(builder: (context) {
          if (homeRa2isiyaController.carouselBooks.isEmpty) {
            return const SizedBox();
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                CarouselSlider.builder(
                    itemCount: homeRa2isiyaController.carouselBooks.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: () async {
                          print(homeRa2isiyaController.carouselBooks.values
                              .elementAt(index)
                              .isCarouselBook!);
                          if (homeRa2isiyaController.carouselBooks.values
                              .elementAt(index)
                              .isCarouselBook!) {
                            Get.toNamed("/BookDetails",
                                arguments: homeRa2isiyaController
                                    .carouselBooks.values
                                    .elementAt(index));
                          } else {
                            if (!await launchUrl(
                                Uri.parse(homeRa2isiyaController
                                    .carouselBooks.values
                                    .elementAt(index)
                                    .url!),
                                mode: LaunchMode.externalApplication)) {
                              MainFunctions.somethingWentWrongSnackBar();
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 2, right: 2),
                          width: 2000,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: greyColor,
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      homeRa2isiyaController
                                          .carouselBooks.values
                                          .elementAt(index)
                                          .thumbnail!))),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        enlargeFactor: 0.17,
                        autoPlayInterval: const Duration(seconds: 5),
                        height: 120,
                        enableInfiniteScroll: true
                        // homeRa2isiyaController.carouselBooks.length != 1
                        //     ? true
                        //     : false
                        ,
                        autoPlay: true
                        // homeRa2isiyaController.carouselBooks.length != 1
                        //     ? true
                        //

                        )),
              ],
            );
          }
        }),
        const SizedBox(height: 20),
        Card(
          margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "أحدث الكتب",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo Bold',
                            fontSize: 19),
                      ),
                    ),
                    TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(transparentColor),
                            iconColor: MaterialStateProperty.all(orangeColor),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => orangeColor.withOpacity(0.1)),
                            foregroundColor:
                                MaterialStateProperty.all(orangeColor)),
                        onPressed: () {
                          Get.toNamed("/RequestedBooks", arguments: {
                            "0": AppBarType.mostRecentBooks,
                            "1": homeRa2isiyaController.mostRecentBooks
                          });
                        },
                        icon: const Text("المزيد",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              fontFamily: 'Cairo Bold',
                            )),
                        label: const Icon(Icons.arrow_back_ios_new))
                  ],
                ),
              ),
              SizedBox(
                  height: 190,
                  child: GetBuilder<HomeRa2isiyaController>(builder: (context) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      itemCount:
                          homeRa2isiyaController.mostRecentBooks.length < 10
                              ? homeRa2isiyaController.mostRecentBooks.length
                              : 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/BookDetails",
                                arguments: homeRa2isiyaController
                                    .mostRecentBooks.values
                                    .elementAt(index));
                          },
                          child: SizedBox(
                            width: 140,
                            child: BookThumnail(
                                url: homeRa2isiyaController
                                    .mostRecentBooks.values
                                    .elementAt(index)
                                    .thumbnail!),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                    );
                  })),
              const SizedBox(height: 10),
            ],
          ),
        ),
        //     const SizedBox(height: 10),

        Card(
          margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "الأكثر تقييما",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Cairo',
                            fontSize: 19),
                      ),
                    ),
                    TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(transparentColor),
                            iconColor: MaterialStateProperty.all(orangeColor),
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => orangeColor.withOpacity(0.1)),
                            foregroundColor:
                                MaterialStateProperty.all(orangeColor)),
                        onPressed: () {
                          Get.toNamed("/RequestedBooks", arguments: {
                            "0": AppBarType.topRatedBooks,
                            "1": homeRa2isiyaController.topRatedBooks
                          });
                        },
                        icon: const Text("المزيد",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                fontFamily: 'Cairo')),
                        label: const Icon(Icons.arrow_back_ios_new))
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: GetBuilder<HomeRa2isiyaController>(builder: (context) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    itemCount: homeRa2isiyaController.topRatedBooks.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed("/BookDetails",
                              arguments: homeRa2isiyaController
                                  .topRatedBooks.values
                                  .elementAt(index));
                        },
                        child: SizedBox(
                          width: 140,
                          child: BookThumnail(
                              url: homeRa2isiyaController.topRatedBooks.values
                                  .elementAt(index)
                                  .thumbnail!),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                  );
                }),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        const SizedBox(height: 5),

        // Builder(
        //   builder: (context) {

        //   },
        // ),

        GetBuilder<HomeRa2isiyaController>(builder: (context) {
          if (homeRa2isiyaController.isFetching) {
            return Column(
              children: const [
                SizedBox(height: 35),
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            return Column(
              children: [
                for (var index = 0;
                    index < homeRa2isiyaController.customCategories.length;
                    index++)
                  Card(
                    margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  homeRa2isiyaController.customCategories.keys
                                      .elementAt(index),
                                  style: const TextStyle(
                                      fontFamily: 'Cairo Bold',
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 19),
                                ),
                              ),
                              TextButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all(transparentColor),
                                      iconColor:
                                          MaterialStateProperty.all(
                                              orangeColor),
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) =>
                                                  orangeColor.withOpacity(0.1)),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              orangeColor)),
                                  onPressed: () {
                                    Get.toNamed("/RequestedBooks", arguments: {
                                      "0": AppBarType.somethingElse,
                                      "1": homeRa2isiyaController
                                          .customCategories.values
                                          .elementAt(index),
                                      "2": homeRa2isiyaController
                                          .customCategories.keys
                                          .elementAt(index)
                                    });
                                  },
                                  icon: const Text("المزيد",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          fontFamily: 'Cairo')),
                                  label: const Icon(Icons.arrow_back_ios_new))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 190,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            itemCount: homeRa2isiyaController
                                        .customCategories.values
                                        .elementAt(index)
                                        .length >
                                    9
                                ? 9
                                : homeRa2isiyaController.customCategories.values
                                    .elementAt(index)
                                    .length,
                            itemBuilder: (context, indexx) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed("/BookDetails",
                                      arguments: homeRa2isiyaController
                                          .customCategories.values
                                          .elementAt(index)
                                          .values
                                          .elementAt(indexx));
                                },
                                child: SizedBox(
                                  width: 140,
                                  child: BookThumnail(
                                      url: homeRa2isiyaController
                                          .customCategories.values
                                          .elementAt(index)
                                          .values
                                          .elementAt(indexx)
                                          .thumbnail!),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
              ],
            );
          }
        }),
        const SizedBox(height: 20)
      ]),
    );
  }
}
