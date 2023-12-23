import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:warak/controller/search_controller.dart';
import 'package:warak/view/widgets.dart';

import '../Themes/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 40,
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const IconButtonBack()),
        title: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          textInputAction: TextInputAction.go,
          cursorColor: blackColor,
          decoration: InputDecoration(
              prefixIcon: const ImageIcon(
                Svg("assets/icons/search_icon.svg"),
                size: 20,
              ),
              prefixIconColor: orangeColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              focusColor: blackColor,
              fillColor: blackColor,
              disabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
              hintStyle: TextStyle(
                  color: greyColor, fontFamily: 'Cairo', fontSize: 15),
              hintText: "ابحث عن كتاب أو مؤلف"),
          onChanged: (input) {
            searchController.getInputSearch(input);
          },
          onEditingComplete: () {
            if (searchController.inputSearch!.isNotEmpty) {
              searchController
                  .getSearched(searchController.inputSearch!.trim());
            }
          },
          onSubmitted: (inputSearch) {
            if (inputSearch.isNotEmpty) {
              searchController.getSearched(inputSearch.trim());
            }
          },
        ),
        bottom: PreferredSize(
            preferredSize: const Size(0, 55),
            child: Column(
              children: [
                Container(
                  color: orangeColor,
                  height: 1,
                ),
                TabBar(
                    physics: const BouncingScrollPhysics(),
                    controller: searchController.tabController,
                    labelColor: orangeColor,
                    indicatorColor: orangeColor,
                    unselectedLabelColor: greyColor,
                    tabs: const [
                      Tab(
                          icon: Text(
                        "كتاب",
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 18),
                      )),
                      Tab(
                          icon: Text(
                        "كاتب",
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 18),
                      )),
                      
                    ])
              ],
            )),
      ),
      body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: searchController.tabController,
          children: [
            GetBuilder<SearchController>(builder: (context) {
              if (searchController.inputSearch!.isEmpty) {
                return const Center(
                  child: Text(
                    "ابحث عن كتاب",
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                );
              } else if (searchController.searchedBooks.isEmpty &&
                  searchController.inputSearch!.isNotEmpty) {
                if (!searchController.isFetching) {
                  return const Center(
                    child: Text(
                      "لا توجد نتيجة للبحث",
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return ListView(
                  controller: searchController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchController.searchedBooks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/BookDetails",
                                arguments: searchController.searchedBooks.values
                                    .elementAt(index));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 196,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: greyColor)),
                                    child: BookThumnail(
                                        url: searchController
                                            .searchedBooks.values
                                            .elementAt(index)
                                            .thumbnail!)),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchController.searchedBooks.values
                                            .elementAt(index)
                                            .title!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                            fontSize: 17),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 15),
                                          children: [
                                            const TextSpan(
                                              text: 'تأليف ',
                                            ),
                                            TextSpan(
                                              text: searchController
                                                  .searchedBooks.values
                                                  .elementAt(index)
                                                  .authorName!,
                                              style:
                                                  TextStyle(color: orangeColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 15),
                                          children: [
                                            const TextSpan(
                                              text: 'دار النشر : ',
                                            ),
                                            TextSpan(
                                              text: searchController
                                                  .searchedBooks.values
                                                  .elementAt(index)
                                                  .publishingHouse!,
                                              style:
                                                  TextStyle(color: orangeColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const ImageIcon(
                                              Svg("assets/icons/star_icon.svg"),
                                              size: 20,
                                              color: Colors.amber),
                                          const SizedBox(width: 5),
                                          Text(
                                            searchController
                                                        .searchedBooks.values
                                                        .elementAt(index)
                                                        .ratings!
                                                        .toStringAsFixed(1)
                                                        .substring(2, 3) ==
                                                    "0"
                                                ? searchController
                                                    .searchedBooks.values
                                                    .elementAt(index)
                                                    .ratings!
                                                    .floor()
                                                    .toString()
                                                : searchController
                                                    .searchedBooks.values
                                                    .elementAt(index)
                                                    .ratings!
                                                    .toStringAsFixed(1),
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.amber),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                    ),
                    GetBuilder<SearchController>(
                      builder: (context) {
                        if (searchController.isFetching) {
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
                  ],
                );
              }
            }),

            /////////////
            GetBuilder<SearchController>(builder: (context) {
              if (searchController.isFetching) {
                return Center(child: CircularProgressIndicator());
              } else if (searchController.inputSearch!.isEmpty) {
                return const Center(
                  child: Text(
                    "ابحث عن كاتب",
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                );
              } else if (searchController.searchedAuthors.isEmpty &&
                  searchController.inputSearch!.isNotEmpty) {
                if (!searchController.isFetching) {
                  return const Center(
                    child: Text(
                      "لا توجد نتيجة للبحث",
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return ListView(
                  controller: searchController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchController.searchedAuthors.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/AuthorScreen",
                                arguments: searchController
                                    .searchedAuthors.values
                                    .elementAt(index));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: ProfilePictureForOthers(
                                        photoUrl: searchController
                                            .searchedAuthors.values
                                            .elementAt(index)
                                            .imageURL!,
                                        name: searchController
                                            .searchedAuthors.values
                                            .elementAt(index)
                                            .name!)),
                                const SizedBox(width: 10),
                                Text(
                                  searchController.searchedAuthors.values
                                      .elementAt(index)
                                      .name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                    ),
                    GetBuilder<SearchController>(
                      builder: (context) {
                        if (searchController.isFetching) {
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
                  ],
                );
              }
            }),

            /////////////
 
          ]),
    );
  }
}
