import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:warak/controller/author_screen_controller.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';
import '../main.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorScreenController authorScreenController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
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
      ),
      body: ListView(
        controller: authorScreenController.scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 2),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
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
                                authorScreenController
                                    .authorModel.name!.length),
                            offset: Offset(0, 1))
                      ],
                      color: MainFunctions.generatePresizedColor(
                          authorScreenController.authorModel.name!.length),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 92,
                      width: 92,
                      child: CircleAvatar(
                          backgroundColor:
                              authorScreenController.authorModel.imageURL! == ""
                                  ? whiteColor
                                  : MainFunctions.generatePresizedColor(
                                      authorScreenController
                                          .authorModel.name!.length),
                          child: SizedBox(
                              height: 90,
                              width: 90,
                              child: ProfilePictureForOthers(
                                name: authorScreenController.authorModel.name!,
                                photoUrl: authorScreenController
                                    .authorModel.imageURL!,
                              )))),
                  Text(
                    authorScreenController.authorModel.name!,
                    style: const TextStyle(color: whiteColor, shadows: [
                      Shadow(
                          blurRadius: 10,

                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          blurRadius: 10,

                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          blurRadius: 10,

                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black),
                      Shadow(
                          blurRadius: 10,
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black),
                    ]),
                  ),
                ],
              ),
            ],
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
              "عن الكاتب",
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
                  authorScreenController.authorModel.aboutAuthor!.isNotEmpty
                      ? authorScreenController.authorModel.aboutAuthor!
                      : "لا توجد معلومات",
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
              "المؤلفات",
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          GetBuilder<AuthorScreenController>(builder: (context) {
            if (authorScreenController.authorModel.myBooks!.isEmpty &&
                !authorScreenController.isFetching) {
              return Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Text(
                  "لا توجد معلومات",
                  style: TextStyle(fontSize: 17, color: greyColor),
                ),
              );
            } else {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.77),
                itemCount: authorScreenController.authorBooks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed("/BookDetails",
                          arguments: authorScreenController.authorBooks.values
                              .elementAt(index));
                    },
                    child: BookThumnail(
                        url: authorScreenController.authorBooks.values
                            .elementAt(index)
                            .thumbnail!),
                  );
                },
              );
            }
          }),
          GetBuilder<AuthorScreenController>(
            builder: (context) {
              if (authorScreenController.isFetching) {
                return Column(
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 60)
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
