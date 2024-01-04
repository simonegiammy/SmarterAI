import 'package:flutter/material.dart';
import 'package:gemini_example/aiProvider/gemini.dart';
import 'package:gemini_example/presentation/screens/home_screen.dart';
import 'package:gemini_example/theme.dart';

void main() {
  GeminiProvider.setup();
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
