import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/music_color.dart';

// final purpleTheme = ThemeColors(light: MusicColor(background: Colors.purple[600], text: Colors.black, other: Colors.white), dark: dark, totalDark: totalDark)
final pinkTheme = MusicColor.create(
    palette: ColorPalette.normal,
    theme: ColorTheme.totalDark,
    icon: Colors.pink[800] ?? Colors.pink,
    inactive: Colors.pinkAccent[900] ?? Colors.pink,
    background: Colors.pink,
    text: Colors.white,
    other: const Color(0xFF9E9E9E));
