import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';

// final purpleTheme = ThemeColors(light: MusicColor(background: Colors.purple[600], text: Colors.black, other: Colors.white), dark: dark, totalDark: totalDark)
final redTheme = ColorAdapter().toTotalDarkTheme(MusicColor.create(
    palette: ColorPalette.normal,
    theme: ColorTheme.totalDark,
    icon: Colors.red[800] ?? Colors.red,
    inactive: Colors.redAccent[900] ?? Colors.red,
    background: Colors.red,
    text: Colors.white,
    other: const Color(0xFF9E9E9E)));
