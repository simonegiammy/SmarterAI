import 'package:flutter/material.dart';

ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff1C1C1C),
    textTheme: textTheme,
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: Color(0xfff4f4f4))))));

TextTheme textTheme = const TextTheme(
  titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  bodyLarge: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),
  bodyMedium: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
  bodySmall: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
);
