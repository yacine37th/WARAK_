import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak/firebase_options.dart';
import 'package:warak/utils/author_screen_binding.dart';
import 'package:warak/utils/book_details_binding.dart';
import 'package:warak/utils/requested_books_binding.dart';
import 'package:warak/utils/searcht_binding.dart';
import 'Themes/colors.dart';
import 'Themes/themes.dart';
import 'middleware/auth_middleware.dart';
import 'model/user_model.dart';
import 'utils/forgot_password_binding.dart';
import 'utils/home_screen_binding.dart';
import 'utils/order_book_binding.dart';
import 'utils/sign_in_bindning.dart';
import 'utils/sign_up_bindning.dart';
import 'utils/tasnifat_binding.dart';
import 'utils/verify_email_binding.dart';
import 'view/author_screen.dart';
import 'view/book_content.dart';
import 'view/book_details.dart';
import 'view/forgot_password.dart';
import 'view/home_screen.dart';
import 'view/order_book.dart';
import 'view/requested_books.dart';
import 'view/search_screen.dart';
import 'view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view/sign_up.dart';
import 'view/tasnifat.dart';
import 'view/verify_email.dart';
import 'package:intl/intl.dart' as intl;

User? currentUser = FirebaseAuth.instance.currentUser;
UserModel currentUserInfos = UserModel(
    uID: "",
    email: "",
    firstName: " ",
    lastName: " ",
    imageURL: "",
    aboutMe: "",
    facebookAccount: "",
    i9ama: "",
    instaAccount: "",
    favoriteBooks: [],
    maktabati: [],
    ordersElectronicBooks: []);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    await MainFunctions.getcurrentUserInfos();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warak',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: Themes.customLightTheme,
      textDirection: MainFunctions.textDirection,
      getPages: [
        GetPage(
          name: "/SignUp",
          page: () => const SignUp(),
          binding: SignUpBinding(),
        ),
        GetPage(
            name: "/SignIn",
            page: () => const SignIn(),
            binding: SignInBinding(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: "/EmailVerification",
            page: () => const EmailVerification(),
            binding: EmailVerificationBinding()),
        GetPage(
          name: "/ForgotPassword",
          page: () => const ForgotPassword(),
          binding: ForgotPasswordBinding(),
        ),
        GetPage(
          name: "/HomeScreen",
          page: () => const HomeScreen(),
          binding: HomeScreenBinding(),
        ),
        GetPage(
          name: "/Tasnifat",
          page: () => const Tasnifat(),
          binding: TasnifatBinding(),
        ),
        GetPage(
          name: "/BookDetails",
          page: () => const BookDetails(),
          binding: BookDetailsBinding(),
        ),
        GetPage(
          name: "/BookContent",
          page: () => const BookContent(),
        ),
        GetPage(
          name: "/RequestedBooks",
          page: () => const RequestedBooks(),
          binding: RequestedBooksBinding(),
        ),
        GetPage(
          name: "/SearchScreen",
          page: () => const SearchScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 250),
          binding: SearchBinding(),
        ),
        GetPage(
          name: "/AuthorScreen",
          page: () => const AuthorScreen(),
          binding: AuthorScreenBinding(),
        ),
        GetPage(
          name: "/OrderBook",
          page: () => const OrderBook(),
          binding: OrderBookBinding(),
        ),
      ],
      initialRoute: "/SignIn",
    );
  }
}

class MainFunctions {
  static intl.DateFormat dateFormat = intl.DateFormat('yyyy-MM-dd');
  //String? ddd = MainFunctions.dateFormat.format(DateTime.now());

  static TextDirection? textDirection = TextDirection.rtl;
  static File? pickedImage;
  static Color generatePresizedColor(int namelength) {
    return profilColors[((namelength - 3) % 8).floor()];
  }

  static getcurrentUserInfos() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .get()
        .then(
      (value) async {
        bool tempIsSubbed = false;
        print(value["userMaktabati"]);
        currentUserInfos = UserModel(
          uID: value["userID"],
          email: value["userEmail"],
          firstName: value["userFirstName"],
          lastName: value["userLastName"],
          aboutMe: value["userAboutMe"],
          imageURL: value["userImageURL"],
          favoriteBooks: value["userFavoriteBooks"],
          maktabati: value["userMaktabati"],
          facebookAccount: value["userFacebookAccount"],
          i9ama: value["userI9ama"],
          instaAccount: value["userInstaAccount"],
          ordersElectronicBooks: value["userOrdersElectronicBooks"],
        );
        if (value.data()!.containsKey("userIsSubbed")) {
          currentUserInfos.isSubbed = value["userIsSubbed"];
          if (currentUserInfos.isSubbed) {
            print(value["userSubEndingingDay"]);
            currentUserInfos.subStartingDay = dateFormat.format(DateTime.parse(
                value["userSubStartingDay"].toDate().toString()));
            currentUserInfos.subEndingingDay = dateFormat.format(DateTime.parse(
                value["userSubEndingingDay"].toDate().toString()));
          }
        }
      },
    );
    print(currentUserInfos.imageURL);
    print("/////////////////");
  }

  static successSnackBar(String text) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          isDismissible: true,
          duration: const Duration(seconds: 3),
          messageText: Text(
            text,
            style: const TextStyle(fontSize: 16, color: whiteColor),
          ),
          backgroundColor: const Color.fromARGB(255, 98, 216, 102),
          showProgressIndicator: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(
            Icons.done,
            color: whiteColor,
          ));
    }
  }

  static somethingWentWrongSnackBar([String? errorText]) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          duration: const Duration(seconds: 5),
          messageText: Text(
            errorText ?? "هناك خطأ ما",
            style: const TextStyle(fontSize: 16, color: whiteColor),
          ),
          showProgressIndicator: true,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(
            Icons.report_problem,
            color: redColor,
          ));
    }
  }
}
