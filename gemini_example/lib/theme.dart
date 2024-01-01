import 'package:flutter/material.dart';

ThemeData theme = ThemeData.dark().copyWith(
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xfff4f4f4))),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: Color(0xfff4f4f4))))));
