import 'package:flutter/material.dart';

class AddNewButton extends StatelessWidget {
  final onTap;
  const AddNewButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(
            color: Color(0xff3A3030),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add,
                color: Color(0xffD9D9D9),
              ),
              Text(
                "Aggiungi nuovo",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color(0xffD9D9D9),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NormalButton extends StatelessWidget {
  final onTap;
  final Widget child;
  const NormalButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(
            color: Color(0xff3A3030),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
