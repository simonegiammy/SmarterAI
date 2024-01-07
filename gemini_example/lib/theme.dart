import 'package:flutter/material.dart';

String fontFamily = "Modernist";
ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff1C1C1C),
    textTheme: textTheme,
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: Color(0xfff4f4f4))))));

TextTheme textTheme = TextTheme(
  headlineLarge: Typography.blackMountainView.headlineLarge!.copyWith(
    fontFamily: fontFamily,
  ),
  headlineMedium: Typography.blackMountainView.headlineMedium!.copyWith(
    fontFamily: fontFamily,
  ),
  headlineSmall: Typography.blackMountainView.headlineSmall!.copyWith(
    fontFamily: fontFamily,
  ),
  displayLarge: Typography.blackMountainView.displayLarge!
      .copyWith(fontFamily: fontFamily, fontSize: 24),
  displayMedium: Typography.blackMountainView.displayMedium!
      .copyWith(fontFamily: fontFamily, fontSize: 20),
  displaySmall: Typography.blackMountainView.displaySmall!
      .copyWith(fontFamily: fontFamily, fontSize: 18),
  titleLarge: Typography.blackMountainView.titleLarge!.copyWith(
      fontFamily: fontFamily,
      color: Colors.white,
      letterSpacing: -0.5,
      fontSize: 24,
      fontWeight: FontWeight.bold),
  titleMedium: Typography.blackMountainView.titleMedium!.copyWith(
      fontFamily: fontFamily,
      color: const Color(0xff958F8F),
      letterSpacing: -0.5,
      fontSize: 20,
      fontWeight: FontWeight.normal),
  titleSmall: Typography.blackMountainView.titleSmall!.copyWith(
      fontFamily: fontFamily,
      letterSpacing: -0.5,
      fontSize: 16,
      fontWeight: FontWeight.w600),
  bodyLarge: Typography.blackMountainView.bodyLarge!.copyWith(
      color: Colors.white, fontFamily: fontFamily, fontSize: 18, height: 0),
  bodyMedium: Typography.blackMountainView.bodyMedium!
      .copyWith(fontSize: 15, fontFamily: fontFamily, color: Colors.white),
  bodySmall: Typography.blackMountainView.bodySmall!.copyWith(
    fontFamily: fontFamily,
  ),
);
