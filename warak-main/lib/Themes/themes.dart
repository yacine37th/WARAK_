import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class Themes extends GetxController {
  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
//    fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50)),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
    alignment: Alignment.center,
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(orangeColor),
    overlayColor: MaterialStateColor.resolveWith(
        (states) => transparentColor.withOpacity(0.2)),
  ));

  static ThemeData customLightTheme = ThemeData.light().copyWith(
      primaryColorDark: whiteColor,
      primaryColorLight: darkBlueColor,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: blackColor, fontSize: 16),
        bodyLarge: TextStyle(color: blackColor),
        bodyMedium: TextStyle(color: blackColor, fontSize: 22),
        titleSmall: TextStyle(color: blackColor, fontSize: 20),
        titleLarge: TextStyle(color: blackColor, fontSize: 22),
        titleMedium: TextStyle(color: whiteColor, fontSize: 19),
      ).apply(
        fontFamily: 'Raleway',
      ),
      scaffoldBackgroundColor: whiteColor,
      colorScheme: const ColorScheme.light()
          .copyWith(primary: orangeColor, secondary: orangeColor),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: transparentColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontFamily: 'ArefRuqaa',
              fontWeight: FontWeight.bold,
              color: orangeColor,
              fontSize: 21),
          surfaceTintColor: orangeColor,
          foregroundColor: orangeColor),
      primaryColor: orangeColor,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: orangeColor),
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: whiteColor,
        iconColor: whiteColor,
        prefixIconColor: whiteColor,
        suffixIconColor: whiteColor,
        hintStyle: TextStyle(color: whiteColor),
        outlineBorder: BorderSide(color: whiteColor),
        disabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: whiteColor)),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: redColor, width: 2)),
        errorStyle: TextStyle(
            color: redColor, fontSize: 15, fontWeight: FontWeight.w400),
        errorMaxLines: 3,
        errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor, width: 2)),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: whiteColor, width: 2)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: whiteColor, width: 2)),
      ),
      textButtonTheme: textButtonThemeData,
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      listTileTheme: ListTileThemeData(
        
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        textColor: greyColor,
        //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        tileColor: lightBlueColor,
      ));

  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
      primaryColorDark: darkBlueColor,
      primaryColorLight: whiteColor,
      colorScheme: const ColorScheme.dark()
          .copyWith(primary: bluePurpleColor, secondary: bluePurpleColor),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: transparentColor,
          centerTitle: true,
          foregroundColor: whiteColor),
      primaryColor: bluePurpleColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: bluePurpleColor,
      ),
      listTileTheme: ListTileThemeData(
        visualDensity: const VisualDensity(vertical: -4),
        textColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        tileColor: lightBlueColor.withAlpha(50),
      ),
      inputDecorationTheme: InputDecorationTheme(
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor)),
        fillColor: lightBlueColor.withAlpha(50),
        filled: true,
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        errorStyle: const TextStyle(color: redColor, fontSize: 15),
        errorMaxLines: 3,
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: bluePurpleColor, width: 2)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintStyle: const TextStyle(fontSize: 19),
      ),
      textButtonTheme: textButtonThemeData,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: whiteColor, fontSize: 16),
        bodyLarge: TextStyle(color: whiteColor),
        bodyMedium: TextStyle(color: whiteColor, fontSize: 22),
        titleSmall: TextStyle(color: whiteColor, fontSize: 20),
        titleLarge: TextStyle(color: whiteColor, fontSize: 22),
        titleMedium: TextStyle(color: whiteColor, fontSize: 19),
      ).apply(
        fontFamily: 'Raleway',
      ),
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

//   static ThemeData getThemeMode() {
//     return MainFunctions.sharredPrefs!.getBool("isDarkTheme") ?? false
//         ? Themes.customDarkTheme
//         : Themes.customLightTheme;
//   }
}
