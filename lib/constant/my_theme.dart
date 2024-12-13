import 'package:flutter/material.dart';

class MyTheme {
  static Map<int, Color> color = const {
    50: Color.fromRGBO(252, 177, 26, .1),
    100: Color.fromRGBO(252, 177, 26, .2),
    200: Color.fromRGBO(252, 177, 26, .3),
    300: Color.fromRGBO(252, 177, 26, .4),
    400: Color.fromRGBO(252, 177, 26, .5),
    500: Color.fromRGBO(252, 177, 26, .6),
    600: Color.fromRGBO(252, 177, 26, .7),
    700: Color.fromRGBO(252, 177, 26, .8),
    800: Color.fromRGBO(252, 177, 26, .9),
    900: Color.fromRGBO(252, 177, 26, 1),
  };
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Roboto",
    primarySwatch: MaterialColor(MyColor.primary.value, color),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: MyColor.primary,
        onPrimary: MyColor.onPrimary,
        secondary: MyColor.secondary,
        onSecondary: MyColor.onSecondary,
        error: MyColor.error,
        onError: MyColor.onError,
        background: MyColor.background,
        onBackground: MyColor.onBackground,
        surface: MyColor.background,
        onSurface: MyColor.onBackground,
    ),

    //ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.primary,
            foregroundColor: MyColor.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            fixedSize: const Size.fromHeight(62))),
    //OutLineButton
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: MyColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(color: MyColor.primary, width: 1),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            fixedSize: const Size.fromHeight(20))),
  );
}

class MyColor {
  static Color primary = const Color(0xFFFFFFFF);
  static Color onPrimary = const Color(0xFFFF7457);
  static Color onSubPrimary = const Color(0xFFFF9864);
  static Color subPrimary = const Color(0xFF192938);
  static Color themeBac = const Color(0xFFFFE5DA);
  static Color light = const Color(0xFFFAB7B9);
  static Color lightpPri = const Color(0xFFFFB2B2).withOpacity(0.19);
  static Color background = const Color(0xFFFFFFFF);
  static Color onBackground = const Color(0xFF000000);
  static Color error = const Color(0xFFFA0000);
  static Color onError = const Color(0xFFFFFFFF);
  static Color secondary = const Color(0xFFB2B2B2);
  static Color onSecondary = const Color(0xFF000000);
  static Color buttonBgColor = const Color(0xFF272727);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color border = const Color(0xFFC2C2C2);
  static Color textBlue = const Color(0xFF249ADD);
  static Color grey = const Color(0xFFAAA6B9);
  static Color darkGrey = const Color(0xFF878787);
  static Color subText = const Color(0xFF9F9F9F).withOpacity(0.20);
  static Color subTextGrey = const Color(0xFF9F9F9F);
  static Color text = const Color(0xFF252525);
  static Color colorLight = const Color(0xFFAECBFF);
  static Color colorBack = const Color(0xFFF8F8F8);
  static Color colorGrey = const Color(0xFFF2F2F2);
  static Color darkPink = const Color(0xFFF972F9);
  static Color lightPink = const Color(0xFFFBEAFB);
  static Color darkBlue= const Color(0xFF6FA0FB);
  static Color lightBlue = const Color(0xFFD4E3FF);
  static Color darkGreen = const Color(0xFF2A9D18);
  static Color lightGreen = const Color(0xFFDDF6E9);
  static Color darkPeach= const Color(0xFFEF944E);
  static Color lightPeach = const Color(0xFFFFE6D3);
  static Color purple = const Color(0xFFA42FC1);
}
