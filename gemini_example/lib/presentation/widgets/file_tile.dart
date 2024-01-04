import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final String nomeFile;
  const FileTile({super.key, required this.nomeFile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.insert_drive_file_outlined,
          color: Color(0xffD9D9D9),
        ),
        Text(
          nomeFile,
        )
      ],
    );
  }
}
