import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/relationship_style.dart';
import 'package:onPlay/widgets/components/player/relationship/relationship_image.dart';
import 'package:onPlay/widgets/components/player/relationship/relationship_text.dart';

class RelationshipItem extends StatelessWidget {
  final RelationshipStyle style;
  final String text;
  final Uint8List? image;

  const RelationshipItem(
      {super.key,
      required this.style,
      required this.text,
      required this.image});
  @override
  Widget build(BuildContext context) {
    switch (style) {
      case RelationshipStyle.circleImage:
      case RelationshipStyle.image:
        return RelationshipImage(
          isCircular: style == RelationshipStyle.circleImage,
          text: text,
          image: image,
        );
      case RelationshipStyle.name:
        return RelationshipText(
          text: text,
        );
      case RelationshipStyle.option:
        return const SizedBox();
    }
  }
}
