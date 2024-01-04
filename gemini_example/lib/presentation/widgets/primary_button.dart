import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final onTap;
  final String text;
  const PrimaryButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(
            color: Color(0xffD9D9D9),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: const Color(0xff1c1c1c)),
            )),
      ),
    );
  }
}
