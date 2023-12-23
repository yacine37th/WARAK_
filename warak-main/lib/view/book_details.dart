import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import 'package:warak/Themes/colors.dart';
import 'package:warak/controller/book_details_controller.dart';
import 'package:warak/controller/home_screen_controller.dart';
import 'package:warak/main.dart';
import 'package:warak/model/order_model.dart';
import 'package:warak/view/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/book_model.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final BookDetailsController bookDetailsController = Get.find();
    BookModel bookModel = bookDetailsController.bookModel;
    GlobalKey<FormState> moraja3aKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigator!.pop();
              },
              icon: const IconButtonBack())),
      body: ListView(
          controller: bookDetailsController.scrollController,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<HomeScreenController>(builder: (context) {
                        return Container(
                            height: 196,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: greyColor)),
                            child: BookThumnail(url: bookModel.thumbnail!));
                      }),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookModel.title!,
                              style: const TextStyle(
                                  fontFamily: 'Cairo Bold', fontSize: 17),
                            ),
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                    fontFamily: 'Cairo', fontSize: 15),
                                children: [
                                  const TextSpan(
                                    text: 'تأليف ',
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await bookDetailsController
                                            .getBookAuthor();
                                      },
                                    text: bookModel.authorName,
                                    style: TextStyle(color: orangeColor),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                    fontFamily: 'Cairo', fontSize: 15),
                                children: [
                                  const TextSpan(
                                    text: 'دار النشر : ',
                                  ),
                                  TextSpan(
                                    text: bookModel.publishingHouse,
                                    style: TextStyle(color: orangeColor),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const ImageIcon(
                                    Svg("assets/icons/star_icon.svg"),
                                    size: 20,
                                    color: Colors.amber),
                                const SizedBox(width: 5),
                                GetBuilder<BookDetailsController>(
                                    builder: (context) {
                                  return Text(
                                    bookModel.ratings != 0
                                        ? bookModel.ratings!
                                                    .toStringAsFixed(1)
                                                    .substring(2, 3) ==
                                                "0"
                                            ? bookModel.ratings!
                                                .floor()
                                                .toString()
                                            : bookModel.ratings!
                                                .toStringAsFixed(1)
                                        : "لا يوجد تقييم",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Cairo Bold',
                                      color: Colors.amber,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Row(
                              children: [
                                const ImageIcon(
                                    Svg("assets/icons/money_icon.svg"),
                                    size: 22,
                                    color: Colors.green),
                                const SizedBox(width: 5),
                                bookModel.price != 0
                                    ? Text(
                                        "${bookModel.price!.ceil()} دج",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Cairo Bold',
                                          color: Colors.green,
                                        ),
                                      )
                                    : const Text(
                                        "مجاني",
                                        style: TextStyle(
                                            fontFamily: 'ArefRuqaa',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 17),
                                      ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.maxFinite,
                      child: TextButton(
                          onPressed: () {
                            if (bookModel.price == 0) {
                              ///// free book everyone can read
                              Get.toNamed("/BookContent");
                            } else {
                              if (currentUserInfos
                                      .isSubbed || ////// subbed user can read every book
                                  currentUserInfos
                                      .maktabati! ////// user owns this book
                                      .contains(bookModel.id)) {
                                Get.toNamed("/BookContent");
                              } else if (currentUserInfos
                                  .ordersElectronicBooks! //// users ordered this book but didnt got the pass yet
                                  .contains(bookModel.id)) {
                                Get.defaultDialog(
                                    title: "",
                                    content: Column(
                                      children: [
                                        const Text(
                                          "لقد قمت مسبقا بطلب النسخة الإلكترونية لهذا الكتاب و تم إستلام طلبك، سنقوم بتلبيته في أقرب وقت ممكن، شكرا لإنتظارك.",
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: blackColor),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "لأي استفسار يمكنك التواصل معنا عبر : warak.teamsupprt@gmail.com",
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: blackColor),
                                        ),
                                        const SizedBox(height: 25),
                                        TextButton(
                                            onPressed: () {
                                              navigator!.pop();
                                            },
                                            child: const Text(
                                              "حسنا",
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                              ),
                                            ))
                                      ],
                                    ));
                              } else {
                                ////go to buy this book
                                Get.toNamed("/OrderBook", arguments: {
                                  "0": bookModel,
                                  "1": OrderType
                                      .electronicCopie //////////////////////////
                                });
                              }
                            }
                          },
                          child: Text(
                            (currentUserInfos.isSubbed || bookModel.price == 0)
                                ? "إقرأ الكتاب"
                                : currentUserInfos.maktabati!
                                        .contains(bookModel.id)
                                    ? "إقرأ الكتاب"
                                    : "اطلب نسختك الاكترونية",
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                            ),
                          ))),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.maxFinite,
                      child: TextButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(orangeColor),
                              backgroundColor:
                                  MaterialStateProperty.all(transparentColor),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => orangeColor.withOpacity(0.1)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: orangeColor)))),
                          onPressed: () {
                            Get.toNamed("/OrderBook", arguments: {
                              "0": bookModel,
                              "1": OrderType
                                  .physicalCopie //////////////////////////wdqDQSDQSDSQD
                            });
                          },
                          child: const Text(
                            "اطلب نسختك الورقية",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                            ),
                          ))),
                  const SizedBox(height: 20),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.amber.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              Get.defaultDialog(
                                  title: "",
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: bookDetailsController
                                                .myInitialRating ??
                                            3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        glowColor: orangeColor,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) =>
                                            const ImageIcon(
                                                Svg("assets/icons/star_icon.svg"),
                                                color: Colors.amber),
                                        onRatingUpdate: (rating) {
                                          bookDetailsController
                                              .inputRatingg(rating);
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                bookDetailsController
                                                    .addRating();
                                              },
                                              child: Text(
                                                bookDetailsController
                                                            .myInitialRating ==
                                                        null
                                                    ? "أضف تقييم"
                                                    : 'عدل التقييم',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo'),
                                              )),
                                          const SizedBox(width: 10),
                                          TextButton(
                                              onPressed: () {
                                                navigator!.pop();
                                              },
                                              child: const Text(
                                                "الغاء",
                                                style: TextStyle(
                                                    fontFamily: 'Cairo'),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ));
                            },
                            child: Column(
                              children: [
                                const ImageIcon(
                                    Svg("assets/icons/star_icon.svg"),
                                    color: Colors.amber),
                                GetBuilder<BookDetailsController>(
                                    builder: (context) {
                                  return Text(
                                    bookDetailsController.myInitialRating ==
                                            null
                                        ? "أضف تقييم"
                                        : "تقييمي",
                                    style: const TextStyle(
                                        fontFamily: 'Cairo', fontSize: 16),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: blackColor,
                        ),
                        Expanded(
                          child: InkWell(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => bluePurpleColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              Get.defaultDialog(
                                  title:
                                      bookDetailsController.myInitialMoraja3a ==
                                              null
                                          ? "أضف مراجعة للكتاب"
                                          : "عدل مراجعتك للكتاب",
                                  titleStyle:
                                      const TextStyle(fontFamily: 'Cairo'),
                                  content: Column(
                                    children: [
                                      Form(
                                        key: moraja3aKey,
                                        child: TextFormField(
                                          initialValue: bookDetailsController
                                              .myInitialMoraja3a,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          cursorColor: blackColor,
                                          onChanged: (input) {
                                            bookDetailsController
                                                .inputMoraja3aa(input.trim());
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return "يرجى كتابة مراجعة";
                                            }
                                            if (value.isEmpty) {
                                              return "يرجى كتابة مراجعة";
                                            }
                                          },
                                          maxLines: 5,
                                          maxLength: 255,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextStyle(color: greyColor),
                                              focusColor: blackColor,
                                              fillColor: blackColor,
                                              errorStyle: const TextStyle(
                                                  color: redColor),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: greyColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greyColor)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greyColor)),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: redColor)),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: redColor)),
                                              hintText: "نص المراجعة"),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                if (moraja3aKey.currentState!
                                                    .validate()) {
                                                  moraja3aKey.currentState!
                                                      .save();
                                                  if (bookDetailsController
                                                          .inputMoraja3a !=
                                                      null) {
                                                    bookDetailsController
                                                        .addMoraja3a();
                                                  }
                                                }
                                              },
                                              child: Text(
                                                bookDetailsController
                                                            .myInitialMoraja3a ==
                                                        null
                                                    ? "أضف مراجعة"
                                                    : "عدل المراجعة",
                                                style: const TextStyle(
                                                    fontFamily: 'Cairo'),
                                              )),
                                          const SizedBox(width: 10),
                                          TextButton(
                                              onPressed: () {
                                                navigator!.pop();
                                              },
                                              child: const Text(
                                                "الغاء",
                                                style: TextStyle(
                                                    fontFamily: 'Cairo'),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ));
                            },
                            child: Column(
                              children: [
                                const ImageIcon(
                                  Svg("assets/icons/addmoraja3a_icon.svg"),
                                  color: bluePurpleColor,
                                ),
                                GetBuilder<BookDetailsController>(
                                    builder: (context) {
                                  return Text(
                                    bookDetailsController.myInitialMoraja3a ==
                                            null
                                        ? "أضف مراجعة"
                                        : "عدل المراجعة",
                                    style: const TextStyle(
                                        fontFamily: 'Cairo', fontSize: 16),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: blackColor,
                        ),
                        Expanded(
                          child: InkWell(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => redColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              bookDetailsController.canAdd
                                  ? bookDetailsController.addToFavBooks()
                                  : bookDetailsController.removeFromFavBooks();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<BookDetailsController>(
                                    builder: (context) {
                                  return ImageIcon(
                                    Svg(bookDetailsController.canAdd
                                        ? "assets/icons/heart_add_icon.svg"
                                        : "assets/icons/heart_remove_icon.svg"),
                                    color: redColor,
                                  );
                                }),
                                GetBuilder<BookDetailsController>(
                                    builder: (context) {
                                  return Text(
                                    bookDetailsController.canAdd
                                        ? "أضف للمفضلة"
                                        : "حذف من المفضلة",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'Cairo', fontSize: 16),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
              color: Colors.grey.withOpacity(0.2),
            ),
            Container(
              alignment: Alignment.center,
              height: 55,
              decoration: const BoxDecoration(color: whiteColor, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Shadow position
                ),
              ]),
              child: const Text(
                "عن الكتاب",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ExpandableText(
                    bookModel.aboutBook!,
                    trimLines: 3,
                  )),
            ),
            Container(
              alignment: Alignment.center,
              height: 55,
              decoration: const BoxDecoration(color: whiteColor, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Shadow position
                ),
              ]),
              child: const Text(
                "مراجعات القراء",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            GetBuilder<BookDetailsController>(builder: (context) {
              if (bookDetailsController.moraja3at.isEmpty &&
                  !bookDetailsController.isFetching) {
                return Container(
                  color: Colors.grey.withOpacity(0.2),
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  alignment: Alignment.center,
                  child: Text(
                    "لا توجد مراجعات لهذا الكتاب",
                    style: TextStyle(fontSize: 18, color: greyColor),
                  ),
                );
              } else {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookDetailsController.moraja3at.values.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        color: Colors.grey.withOpacity(0.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: ProfilePictureForOthers(
                                photoUrl: bookDetailsController.moraja3at.values
                                    .elementAt(index)
                                    .moraja3aUserImage!,
                                name: bookDetailsController.moraja3at.values
                                    .elementAt(index)
                                    .moraja3aUser!,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.15),
                                    border: Border.all(
                                        color: blackColor.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookDetailsController.moraja3at.values
                                          .elementAt(index)
                                          .moraja3aUser!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      bookDetailsController.moraja3at.values
                                          .elementAt(index)
                                          .moraja3aText!,
                                      style: const TextStyle(fontSize: 17),
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    });
              }
            }),
            GetBuilder<BookDetailsController>(
              builder: (context) {
                if (bookDetailsController.isFetching) {
                  return Column(
                    children: const [
                      SizedBox(height: 60),
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 60)
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ]),
    );
  }
}
