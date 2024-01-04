import 'package:flutter/material.dart';
import 'package:gemini_example/aiProvider/gemini.dart';
import 'package:gemini_example/presentation/screens/home_screen.dart';
import 'package:gemini_example/presentation/screens/new_quiz_screen.dart';
import 'package:gemini_example/theme.dart';

void main() {
  GeminiProvider.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const NewQuizScreen(),
    );
  }
}
