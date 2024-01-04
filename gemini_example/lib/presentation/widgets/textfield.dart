import 'package:flutter/material.dart';

class GeminiTextField extends StatelessWidget {
  final controller;
  const GeminiTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 1,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: "Cosa vorresti ripassare?",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
          fillColor: Color(0xff3A3030)),
    );
  }
}
