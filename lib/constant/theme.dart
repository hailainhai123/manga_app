import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFF1F1F1F);
const kSecondaryColor = Color(0xFFFFEC44);
const kAppGreyColor = Color(0xffC4C4C4);
const kGreyColor = Color(0xff9d9d9d);
const kErrorColor = Color(0xffEF5350);
const kSuccessColor = Colors.green;


ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.yellow,
      accentColor: kSecondaryColor,
      primaryColorDark: kSecondaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: kPrimaryColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      elevation: 0,
    ),
    textTheme: GoogleFonts.notoSansTextTheme().apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    backgroundColor: kPrimaryColor,
    scaffoldBackgroundColor: kPrimaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          )),
    ),
  );
}
