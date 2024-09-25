import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';

class ThemeColors {
  final MusicColor light;
  final MusicColor dark;
  final MusicColor totalDark;

  const ThemeColors(
      {required this.light, required this.dark, required this.totalDark});
}