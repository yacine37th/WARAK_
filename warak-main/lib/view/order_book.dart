import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/Themes/colors.dart';
import 'package:warak/main.dart';
import 'package:warak/model/order_model.dart';
import 'package:warak/view/widgets.dart';

import '../controller/max_subscription_controller.dart';
import '../controller/order_book_controller.dart';
import '../model/max_subscription_model.dart';
import '../model/wilaya_model.dart';

class OrderBook extends StatelessWidget {
  const OrderBook({super.key});

  @override
  Widget build(BuildContext context) {
    final formKeyPage1 = GlobalKey<FormState>();
    final formKeyPage11 = GlobalKey<FormState>();
    final GlobalKey<FormFieldState> dropDownButton2key =
        GlobalKey<FormFieldState>();

    final OrderBookController orderBookController = Get.find();
    final MaxSubscriptionController maxSubscriptionController = Get.find();
    MaxSubscriptionModel maxSubscriptionModel =
        maxSubscriptionController.maxSubscriptionModel!;

    List steps = [1, 2, 3];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const IconButtonBack()),
        bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              color: orangeColor,
              height: 1,
            )),
        title: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int step in steps)
                      GetBuilder<OrderBookController>(builder: (context) {
                        return Container(
                          alignment: Alignment.center,
                          height:
                              step <= orderBookController.currentStepIndex + 1
                                  ? 26.0
                                  : 26.0,
                          width:
                              step <= orderBookController.currentStepIndex + 1
                                  ? 26.0
                                  : 26.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                step <= orderBookController.currentStepIndex + 1
                                    ? orangeColor
                                    : Colors.grey,
                          ),
                          child: Text(
                            step.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                color: whiteColor,
                                fontFamily: 'Roboto'),
                          ),
                        );
                      })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 55,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6), blurStyle: BlurStyle.inner,
              blurRadius: 2,
              offset: const Offset(0, -1), // Shadow position
            ),
          ]),
          child: GetBuilder<OrderBookController>(builder: (context) {
            return Row(
              children: [
                if (orderBookController.currentStepIndex == 1)
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)))),
                      onPressed: () {
                        orderBookController.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text(
                        "السابق",
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                    ),
                  ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (orderBookController.currentStepIndex == 2) {
                        return TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)))),
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Column(
                                  children: [
                                    const Text(
                                      "تم استلام طلبك، سنقوم بالاتصال بك في أقرب وقت ممكن.",
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
                          },
                          icon: const Text(
                            "تم",
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          label: const Icon(Icons.done),
                        );
                      } else if (orderBookController.currentStepIndex == 1) {
                        return TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                darkBlueColor,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)))),
                          onPressed: () {
                            orderBookController.makeAnOrder();

                        //    orderBookController.chargilyApi();
                          },
                          icon: const Text(
                            "تأكيد الطلب",
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          label: const Icon(Icons.arrow_forward),
                        );
                      } else {
                        return TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                orangeColor,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)))),
                          onPressed: () {
                            if (orderBookController.currentStepIndex == 0 &&
                                formKeyPage1.currentState!.validate()) {
                              if (orderBookController.orderModel!.orderType ==
                                  OrderType.physicalCopie) {
                                if (formKeyPage11.currentState!.validate()) {
                                  orderBookController.next();
                                }
                              } else {
                                orderBookController.next();
                              }
                            }
                          },
                          icon: Text(
                            "التالي",
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          label: Icon(Icons.arrow_forward),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          })),
      body: SafeArea(
        child: SizedBox(
            height: double.maxFinite,
            child: GetBuilder<OrderBookController>(builder: (context) {
              return PageView(
                controller: orderBookController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  orderBookController.changeStepCurrentIndex(value);
                },
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    children: [
                      Form(
                        key: formKeyPage1,
                        child: Column(
                          children: [
                            const Text(
                              "معلومات التواصل",
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              initialValue:
                                  orderBookController.inputClientFirstName,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: greyColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                  labelText: "الإسم",
                                  prefixIcon: ImageIcon(
                                    Svg("assets/icons/full_person_icon.svg"),
                                  ),
                                  prefixIconColor: orangeColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  focusColor: blackColor,
                                  fillColor: blackColor,
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: redColor)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: orangeColor)),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: redColor)),
                                  hintStyle: TextStyle(
                                      color: greyColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                  hintText: "الإسم"),
                              onChanged: (input) {
                                orderBookController.inputFirstName(input);
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "أدخل اسمك";
                                }
                                if (value.isEmpty) {
                                  return "أدخل اسمك";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                initialValue:
                                    orderBookController.inputClientLastName,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                    labelText: "اللقب",
                                    prefixIcon: ImageIcon(
                                      Svg("assets/icons/full_person_icon.svg"),
                                    ),
                                    prefixIconColor: orangeColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    focusColor: blackColor,
                                    fillColor: blackColor,
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: redColor)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greyColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greyColor)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                    errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: redColor)),
                                    hintStyle: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                    hintText: "اللقب"),
                                onChanged: (input) {
                                  orderBookController.inputLastName(input);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "أدخل لقبك";
                                  }
                                  if (value.isEmpty) {
                                    return "أدخل لقبك";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              initialValue: currentUserInfos.email,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: greyColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                  labelText: "البريد الإلكتروني",
                                  prefixIcon: ImageIcon(
                                    Svg("assets/icons/email_icon.svg"),
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
                                      color: greyColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                  hintText: "البريد الإلكتروني"),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                textInputAction:
                                    orderBookController.orderModel!.orderType ==
                                            OrderType.physicalCopie
                                        ? TextInputAction.next
                                        : TextInputAction.done,
                                maxLength: 10,
                                initialValue:
                                    orderBookController.inputClientPhoneNumber,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                    labelText: "رقم الهاتف",
                                    prefixIcon: const ImageIcon(
                                      Svg("assets/icons/phone_icon.svg"),
                                    ),
                                    prefixIconColor: orangeColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    focusColor: blackColor,
                                    fillColor: blackColor,
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greyColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greyColor)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                    errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: redColor)),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: redColor)),
                                    hintStyle: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 15),
                                    hintText: "رقم الهاتف"),
                                onChanged: (input) {
                                  orderBookController.inputPhoneNumber(input);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "أدخل رقم هاتفك";
                                  }
                                  if (value.isEmpty) {
                                    return "أدخل رقم هاتفك";
                                  }
                                  if (!RegExp(r'(^[+]?[0-9]{10,}$)')
                                      .hasMatch(value)) {
                                    return "أدخل رقم هاتف صحيح";
                                  }
                                  return null;
                                })
                          ],
                        ),
                      ),
                      if (orderBookController.orderModel!.orderType ==
                          OrderType.physicalCopie)
                        Form(
                            key: formKeyPage11,
                            child: Column(
                              children: [
                                const Text(
                                  "معلومات التوصيل",
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField(
                                  isDense: false,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 18,
                                      fontFamily: "Cairo"),
                                  decoration: const InputDecoration(
                                      prefixIcon: ImageIcon(Svg(
                                          "assets/icons/location_icon.svg")),
                                      filled: true,
                                      labelStyle: TextStyle(color: blackColor),
                                      prefixIconColor: orangeColor,
                                      hintStyle: TextStyle(
                                          color: blackColor,
                                          fontFamily: 'Cairo'),
                                      hintText: "اختر ولايتك"),
                                  dropdownColor: lightBlueColor,
                                  validator: (value) {
                                    if (value == null) {
                                      return "اختر ولايتك";
                                    }
                                    // if (value == 0) {
                                    //   return "selectAPeriod".tr;
                                    // }
                                    return null;
                                  },
                                  onChanged: (WilayaModel? wilayaModel) {
                                    orderBookController.getBaladiayt(
                                        orderBookController.wilayat
                                            .indexOf(wilayaModel!));

                                    dropDownButton2key.currentState!.reset();
                                  },
                                  onSaved: (WilayaModel? period) {
                                    print("saaaaaaaaaaaaaaaaved");
                                  },
                                  items: orderBookController.wilayat
                                      .map<DropdownMenuItem<WilayaModel>>(
                                          (WilayaModel value) {
                                    return DropdownMenuItem<WilayaModel>(
                                      value: value,
                                      child: Text(
                                        value.wilaya!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.clip),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                //////////////////////////////kkkk
                                const SizedBox(height: 10),
                                DropdownButtonFormField(
                                  key: dropDownButton2key,
                                  isDense: false,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 18,
                                      fontFamily: "Cairo"),
                                  decoration: const InputDecoration(
                                      prefixIcon: ImageIcon(Svg(
                                          "assets/icons/location_icon.svg")),
                                      filled: true,
                                      labelStyle: TextStyle(color: blackColor),
                                      prefixIconColor: orangeColor,
                                      hintStyle: TextStyle(
                                          color: blackColor,
                                          fontFamily: 'Cairo'),
                                      hintText: "اختر بلديتك"),
                                  dropdownColor: lightBlueColor,
                                  validator: (value) {
                                    if (value == null) {
                                      return "اختر بلديتك";
                                    }
                                    // if (value == 0) {
                                    //   return "selectAPeriod".tr;
                                    // }
                                    return null;
                                  },
                                  onChanged: (String? baladiyaName) {
                                    orderBookController
                                        .inputBaladiya(baladiyaName);
                                  },
                                  onSaved: (String? period) {
                                    print("saaaaaaaaaaaaaaaaved");
                                  },
                                  items: (orderBookController
                                                  .indexOfWilayaSelected !=
                                              null
                                          ? orderBookController
                                              .wilayat[orderBookController
                                                  .indexOfWilayaSelected!]
                                              .wilayaBaladiyat
                                          : [])
                                      ?.map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.clip),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                // const SizedBox(height: 10),
                                // TextFormField(
                                //     textInputAction: TextInputAction.next,
                                //     initialValue:
                                //         orderBookController.inputClientWilaya,
                                //     keyboardType: TextInputType.streetAddress,
                                //     style: const TextStyle(color: Colors.black),
                                //     decoration: InputDecoration(
                                //         labelStyle: TextStyle(
                                //             color: greyColor,
                                //             fontFamily: 'Cairo',
                                //             fontSize: 15),
                                //         labelText: "الولاية",
                                //         prefixIcon: const ImageIcon(
                                //           Svg("assets/icons/location_icon.svg"),
                                //         ),
                                //         prefixIconColor: orangeColor,
                                //         contentPadding:
                                //             const EdgeInsets.symmetric(
                                //                 vertical: 5, horizontal: 5),
                                //         focusColor: blackColor,
                                //         fillColor: blackColor,
                                //         disabledBorder: OutlineInputBorder(
                                //             borderSide:
                                //                 BorderSide(color: greyColor)),
                                //         enabledBorder: OutlineInputBorder(
                                //             borderSide:
                                //                 BorderSide(color: greyColor)),
                                //         focusedBorder: const OutlineInputBorder(
                                //             borderSide:
                                //                 BorderSide(color: orangeColor)),
                                //         errorBorder: const OutlineInputBorder(
                                //             borderSide:
                                //                 BorderSide(color: redColor)),
                                //         focusedErrorBorder:
                                //             const OutlineInputBorder(
                                //                 borderSide: BorderSide(
                                //                     color: redColor)),
                                //         hintStyle: TextStyle(
                                //             color: greyColor,
                                //             fontFamily: 'Cairo',
                                //             fontSize: 15),
                                //         hintText: "الولاية"),
                                //     onChanged: (input) {
                                //       orderBookController.inputWilaya(input);
                                //     },
                                //     validator: (value) {
                                //       if (value == null) {
                                //         return "أدخل المعلومات المطلوبة";
                                //       }
                                //       if (value.isEmpty) {
                                //         return "أدخل المعلومات المطلوبة";
                                //       }

                                //       return null;
                                //     }),
                                const SizedBox(height: 10),
                                TextFormField(
                                    textInputAction: TextInputAction.done,
                                    maxLength: 255,
                                    initialValue:
                                        orderBookController.inputClient3onwan,
                                    keyboardType: TextInputType.streetAddress,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: greyColor,
                                            fontFamily: 'Cairo',
                                            fontSize: 15),
                                        labelText: "العنوان",
                                        prefixIcon: const ImageIcon(
                                          Svg("assets/icons/i9ama_icon.svg"),
                                        ),
                                        prefixIconColor: orangeColor,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                        focusColor: blackColor,
                                        fillColor: blackColor,
                                        disabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: greyColor)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: greyColor)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: orangeColor)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: redColor)),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: redColor)),
                                        hintStyle: TextStyle(
                                            color: greyColor,
                                            fontFamily: 'Cairo',
                                            fontSize: 15),
                                        hintText: "العنوان"),
                                    onChanged: (input) {
                                      orderBookController.input3onwan(input);
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "أدخل المعلومات المطلوبة";
                                      }
                                      if (value.isEmpty) {
                                        return "أدخل المعلومات المطلوبة";
                                      }

                                      return null;
                                    })
                              ],
                            ))
                    ],
                  ),
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    children: [
                      const Text(
                        "معلومات الطلب :",
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        if (orderBookController.orderModel!.orderType !=
                            OrderType.maxSubscription) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<OrderBookController>(
                                  builder: (context) {
                                return Container(
                                    height: 196,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: greyColor)),
                                    child: BookThumnail(
                                        url: orderBookController
                                            .bookModel!.thumbnail!));
                              }),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderBookController.bookModel!.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          fontSize: 17),
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
                                            text: orderBookController
                                                .bookModel!.authorName,
                                            style:
                                                TextStyle(color: orangeColor),
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
                                            text: orderBookController
                                                .bookModel!.publishingHouse,
                                            style:
                                                TextStyle(color: orangeColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const ImageIcon(
                                            Svg("assets/icons/money_icon.svg"),
                                            size: 22,
                                            color: Colors.green),
                                        const SizedBox(width: 5),
                                        orderBookController.bookModel!.price !=
                                                0
                                            ? Text(
                                                "${orderBookController.bookModel!.price!.ceil()} دج",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Cairo',
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          );
                        } else {
                          return Column(
                            children: [
                              Card(
                                color: darkBlueColor.withOpacity(0.7),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 25,
                                              color: whiteColor),
                                          children: [
                                            TextSpan(
                                              text: 'إشتراك ورق ',
                                            ),
                                            TextSpan(
                                              text: "ماكس",
                                              style: TextStyle(
                                                  color: orangeColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline),
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
                                              color:
                                                  whiteColor.withOpacity(0.1)),
                                          BoxShadow(
                                              blurRadius: 10,

                                              // bottomRight
                                              offset: Offset(1.5, -1.5),
                                              color:
                                                  whiteColor.withOpacity(0.1)),
                                          BoxShadow(
                                              blurRadius: 10,

                                              // topRight
                                              offset: Offset(1.5, 1.5),
                                              color:
                                                  whiteColor.withOpacity(0.1)),
                                          BoxShadow(
                                              blurRadius: 10,
                                              // topLeft
                                              offset: Offset(-1.5, 1.5),
                                              color:
                                                  whiteColor.withOpacity(0.1)),
                                        ]),
                                        child: const ImageIcon(
                                            Svg("assets/icons/thunder_icon.svg",
                                                scale: 50),
                                            size: 30,
                                            color: orangeColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 20),
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.grey),
                                    //     borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                image: maxSubscriptionModel
                                                            .newPromoPrice ==
                                                        null
                                                    ? null
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/icons/strike_through.png'),
                                                        fit: BoxFit.fitWidth),
                                              ),
                                              child: Text(
                                                  "${maxSubscriptionModel.price!.ceil()} دج",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 27,
                                                      color: orangeColor,
                                                      fontFamily: 'Cairo')),
                                            ),
                                            if (maxSubscriptionModel
                                                    .newPromoPrice !=
                                                null)
                                              Text(
                                                " ${maxSubscriptionModel.newPromoPrice!.ceil()} دج",
                                                style: const TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.w800,
                                                    color: blackColor,
                                                    fontFamily: 'Cairo'),
                                              )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: maxSubscriptionModel
                                              .prosList!.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                    child: Text(
                                                  maxSubscriptionModel
                                                      .prosList![index],
                                                  style: const TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 17),
                                                ))
                                              ],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(height: 20);
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          );
                        }
                      }),
                      const SizedBox(height: 30),
                      const Text(
                        "من فضلك قم بتصوير لقطة شاشة عند الانتهاء من الدفع لرفعها كإثبات دفع في الخطوة الموالية لتسهيل العملية",
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 17),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<OrderBookController>(builder: (context) {
                        if (orderBookController.pickedImage != null) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            height: 300,
                            child: Image.file(
                              orderBookController.pickedImage!,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      TextButton(
                          onPressed: () {
                            orderBookController.uploadSSProof();
                          },
                          child: Text("رفع لقطة شاشة اثبات الدفع")),
                    ],
                  ),
                ],
              );
            })),
      ),
    );
  }
}
