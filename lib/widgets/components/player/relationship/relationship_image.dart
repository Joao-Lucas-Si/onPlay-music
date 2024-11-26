import 'dart:typed_data';

import 'package:flutter/material.dart';

class RelationshipImage extends StatelessWidget {
  final bool isCircular;
  final String text;
  final Uint8List? image;
  final Widget? extra;

  const RelationshipImage(
      {super.key,
      required this.isCircular,
      required this.text,
      this.extra,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image != null
            ? Image(
                image: MemoryImage(image!),
                width: 70,
                height: 70,
              )
            : const Icon(Icons.stop),
        Text(text),
        extra ?? SizedBox.fromSize()
      ],
    );
  }
}
