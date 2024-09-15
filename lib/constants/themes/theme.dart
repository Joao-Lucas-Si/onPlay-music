import 'package:flutter/material.dart';
import 'package:onPlay/services/colors/color_adapter.dart';

class ThemeColors {
  final MusicColor light;
  final MusicColor dark;
  final MusicColor totalDark;

  const ThemeColors(
      {required this.light, required this.dark, required this.totalDark});
}

class ThemeColorValue {
  final Color background, color, other;

  const ThemeColorValue(
      {required this.background, required this.color, required this.other});
}
