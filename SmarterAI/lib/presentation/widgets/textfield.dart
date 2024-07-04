import 'package:flutter/material.dart';

class GeminiTextField extends StatelessWidget {
  final controller;
  String hint;
  GeminiTextField({
    super.key,
    required this.controller,
    this.hint = "Cosa vorresti ripassare?",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 1,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
          fillColor: const Color(0xff3A3030)),
    );
  }
}
