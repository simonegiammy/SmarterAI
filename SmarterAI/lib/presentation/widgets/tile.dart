import 'package:flutter/material.dart';

class SubjectTile extends StatelessWidget {
  final String text;
  final bool selected;
  final Function() onTap;
  const SubjectTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
            color:
                !selected ? const Color(0xff3A3030) : const Color(0xffD9D9D9),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: selected
                        ? const Color(0xff3A3030)
                        : const Color(0xffD9D9D9),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  final String text;
  final bool selected;
  final Function() onTap;
  const AnswerTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
            color:
                !selected ? const Color(0xff3A3030) : const Color(0xffD9D9D9),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              text,
              //overflow: TextOverflow.ellipsis,
              maxLines: null,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    height: 1.4,
                    color: selected
                        ? const Color(0xff3A3030)
                        : const Color(0xffD9D9D9),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
