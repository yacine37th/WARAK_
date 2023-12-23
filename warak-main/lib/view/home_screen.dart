import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/controller/sign_in_controller.dart';
import 'package:warak/controller/sign_up_controller.dart';
import 'package:warak/controller/verify_email_controller.dart';
import 'package:warak/view/maktabati.dart';
import 'package:warak/view/sign_in.dart';
import 'package:warak/view/sign_up.dart';
import 'package:warak/view/verify_email.dart';

import '../Themes/colors.dart';
import '../controller/home_screen_controller.dart';
import '../controller/maktabati_controller.dart';
import '../main.dart';
import '../model/book_model.dart';
import 'book_details.dart';
import 'home_ra2isiya.dart';
import 'max_subscription.dart';
import 'my_account.dart';
import 'tasnifat.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController = Get.find();
    final MaktabatiController maktabatiController = Get.find();

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [
      const BottomNavigationBarItem(
        label: "الرئيسية",
        icon: ImageIcon(
          Svg("assets/icons/home_icon.svg"),
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(Svg("assets/icons/home_icon.svg")),
        ),
      ),
      const BottomNavigationBarItem(
        label: "التصنيفات",
        icon: ImageIcon(
          Svg("assets/icons/category_icon.svg"),
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(Svg("assets/icons/category_icon.svg")),
        ),
      ),
      const BottomNavigationBarItem(
        label: "حسابي",
        icon: ImageIcon(
          Svg("assets/icons/myaccount_icon.svg"),
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: ImageIcon(Svg("assets/icons/myaccount_icon.svg")),
        ),
      ),
      BottomNavigationBarItem(
        label: "ماكس",
        icon: const ImageIcon(
          Svg("assets/icons/thunder_outer_icon.svg"),
        ),
        activeIcon: ActiveBottomBarIcon(
          widgetIcon: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 20,

                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: lightBlueColor.withOpacity(0.4)),
                BoxShadow(
                    blurRadius: 20,

                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: lightBlueColor.withOpacity(0.4)),
                BoxShadow(
                    blurRadius: 20,

                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: lightBlueColor.withOpacity(0.4)),
                BoxShadow(
                    blurRadius: 20,
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: lightBlueColor.withOpacity(0.4)),
              ]),
              child: ImageIcon(Svg("assets/icons/thunder_outer_icon.svg"))),
        ),
      ),
    ];

    const List<Widget> bottomNavigationBarScreensList = [
      HomeRa2isiya(),
      Tasnifat(),
      MyAccount(),
      MaxSubscription()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
            child: Row(children: [
              Container(
                width: 50,
                height: 50,
                child: ProfilePicture(),
              ),
              const SizedBox(width: 5),
              Text(
                "${currentUserInfos.firstName!} ${currentUserInfos.lastName!}",
                style: TextStyle(color: whiteColor),
              ),
            ]),
          ),
          const Divider(
            color: whiteColor,
          ),

          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
            horizontalTitleGap: 1,
            dense: true,
            title: const Text(
              "الرئيسية",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: ImageIcon(Svg("assets/icons/home_icon.svg")),
            onTap: () {
              homeScreenController.switchBetweenScreens(0);
              Get.back();
            },
          ),
          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            onTap: () {
              homeScreenController.switchBetweenScreens(1);
              Get.back();
            },
            title: const Text(
              "التصنيفات",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/category_icon.svg")),
          ), //////////////////

          //////////////////
          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            title: const Text(
              "الصفحة الشخصية",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/myaccount_icon.svg")),
            onTap: () {
              homeScreenController.switchBetweenScreens(2);
              Get.back();
            },
          ),

          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            onTap: () {
              Get.toNamed("/RequestedBooks", arguments: {
                "0": AppBarType.maktabati,
                "1": maktabatiController.maktabati
              });
            },
            title: const Text(
              "مكتبتي",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/maktabati_icon.svg")),
          ),
          //////////////////

          // const ListTile(
          //   tileColor: transparentColor,
          //   textColor: whiteColor,
          //   iconColor: whiteColor,
          //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          //   contentPadding:
          //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          //   horizontalTitleGap: 1,
          //   dense: true,
          //   title: Text(
          //     "مكتبتي",
          //     style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
          //   ),
          //   leading: Icon(Icons.account_circle_outlined),
          // ),
          //////////////////
          // const ListTile(
          //   tileColor: transparentColor,
          //   textColor: whiteColor,
          //   iconColor: whiteColor,
          //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          //   contentPadding:
          //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          //   horizontalTitleGap: 1,
          //   dense: true,
          //   title: Text(
          //     "كيف احصل على كتابي ؟",
          //     style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
          //   ),
          //   leading: Icon(Icons.info_outline),
          // ),
          ListTileTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            tileColor: transparentColor,
            horizontalTitleGap: -7,
            child: ExpansionTile(
              collapsedIconColor: whiteColor,
              collapsedTextColor: whiteColor,
              leading: const ImageIcon(
                  Svg("assets/icons/message_question_icon.svg")),
              //   textColor: whiteColor,
              tilePadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),

              title: const Text(
                "كيف احصل على كتابي ؟",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Cairo'),
              ),
              children: [
                InkWell(
                  onTap: () {
                    homeScreenController.switchBetweenScreens(3);
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const ListTile(
                      onTap: null,
                      tileColor: transparentColor,
                      textColor: whiteColor,
                      iconColor: whiteColor,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      horizontalTitleGap: 1,
                      dense: true,
                      title: Text(
                        "إشتراك ورق ماكس",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Cairo'),
                      ),
                      leading:
                          ImageIcon(Svg("assets/icons/thunder_outer_icon.svg")),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          children: [
                            const Text(
                              "يمكن طلب نسخة الكترونية أو ورقية للكتاب االذي ترغب بقراءته",
                              style: TextStyle(
                                  fontFamily: 'Cairo', color: blackColor),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                navigator!.pop();
                              },
                              child: const Text(
                                "حسنا",
                                style: TextStyle(fontFamily: 'Cairo'),
                              ),
                            )
                          ],
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const ListTile(
                      onTap: null,
                      tileColor: transparentColor,
                      textColor: whiteColor,
                      iconColor: whiteColor,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      horizontalTitleGap: 1,
                      dense: true,
                      title: Text(
                        "شراء نسخة ورقية أو إلكترونية",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Cairo'),
                      ),
                      leading: ImageIcon(Svg("assets/icons/money_icon.svg")),
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
          //////////////////
          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            title: const Text(
              "تسجيل الخروج",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/logout_icon.svg")),
            onTap: () {
              homeScreenController.signOutOfAnExistingAccount();
            },
          ),
          /////////////
          const Spacer(),
          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            title: const Text(
              "تعرف على ورق",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/info_circle_icon.svg")),
            onTap: () {
              homeScreenController.knowWarak();
            },
          ),
          ListTile(
            tileColor: transparentColor,
            textColor: whiteColor,
            iconColor: whiteColor,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            horizontalTitleGap: 1,
            dense: true,
            title: const Text(
              "سياسة الخصوصية",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Cairo'),
            ),
            leading: const ImageIcon(Svg("assets/icons/lock.svg")),
            onTap: () {
              homeScreenController.privatePolicy();
            },
          ),
          const SizedBox(height: 20),
        ]),
      ),
      bottomNavigationBar: GetBuilder<HomeScreenController>(builder: (context) {
        return BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontFamily: 'Cairo', color: blackColor),
          unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
          selectedItemColor: orangeColor,
          unselectedItemColor: greyColor,
          items: bottomNavigationBarItemList,
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: whiteColor),
          elevation: 0,
          currentIndex: homeScreenController.currentBottomBarIndex(),
          onTap: (index) {
            homeScreenController.switchBetweenScreens(index);
          },
        );
      }),
      body: GetBuilder<HomeScreenController>(builder: (context) {
        return bottomNavigationBarScreensList[
            homeScreenController.currentBottomBarIndex()];
      }),
    );
  }
}
