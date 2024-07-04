import 'package:SmarterAI/aiProvider/gemini.dart';
import 'package:SmarterAI/presentation/screens/home_screen.dart';
import 'package:SmarterAI/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
