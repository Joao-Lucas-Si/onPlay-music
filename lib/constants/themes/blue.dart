import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';

// final purpleTheme = ThemeColors(light: MusicColor(background: Colors.purple[600], text: Colors.black, other: Colors.white), dark: dark, totalDark: totalDark)
final blueTheme = ColorAdapter().toTotalDarkTheme(MusicColor.create(
    palette: ColorPalette.normal,
    theme: ColorTheme.totalDark,
    icon: Colors.blue[800] ?? Colors.blue,
    inactive: Colors.blueAccent[900] ?? Colors.blue,
    background: Colors.blue,
    text: Colors.white,
    other: const Color(0xFF9E9E9E)));
