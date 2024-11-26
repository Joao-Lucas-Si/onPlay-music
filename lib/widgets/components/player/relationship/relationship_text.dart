import 'package:flutter/material.dart';

class RelationshipText extends StatelessWidget {
  final String text;
  final Widget? extra;

  const RelationshipText(
      {super.key,
      required this.text,
      this.extra,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Text(text),
        extra ?? SizedBox.fromSize()
      ],
    );
  }
}
