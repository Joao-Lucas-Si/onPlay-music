import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';

class ItemParams {
  final String title;
  final Uint8List? image;
  final MusicColor colors;
  final bool isColored;
  final Widget? option;
  final Widget? extra;
  final bool isInGrid;

  ItemParams(
      {required this.title,
      this.image,
      required this.isColored,
      required this.colors,
      required this.isInGrid,
      this.extra,
      this.option});
}
