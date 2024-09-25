import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_service.dart';

class ColorAdapter {
  final backgroundLight = 0.6;
  final textLight = 0.3;
  final otherLight = 0.15;

  final backgroundDark = 0.3;
  final textDark = 0.7;
  final otherDark = 0.1;

  final backgroundTotalDark = 0.2;
  final textTotalDark = 0.7;
  final otherTotalDark = 0.4;

  final ColorService colorService;

  ColorAdapter({required this.colorService});

  Color _toLight(Color color, double base) {
    final lightness = colorService.getLigthness(color);
    if (lightness < base) {
      return colorService.toLighten(color, base - lightness);
    }
    return color;
  }

  Color _toDark(Color color, double base) {
    final lightness = colorService.getLigthness(color);
    if (base < lightness) {
      color = colorService.toDarken(color, lightness - base);
    }
    return color;
  }

  toLightTheme(MusicColor colors) {
    var background = colors.background;
    var text = colors.text;
    var other = colors.other;
    var icon = colors.icon;
    var inactive = colors.inactive;

    // other ??= background;

    background = _toLight(background, backgroundLight);
    text = _toDark(text, textLight);
    other = _toDark(other, otherLight);

    colors.background = background;
    colors.text = text;
    colors.icon = icon;
    colors.inactive = inactive;
    colors.other = other;

    return colors;
  }

  toTotalDarkTheme(MusicColor colors) {
    var background = colors.background;
    var text = colors.text;
    var other = colors.other;
    var icon = colors.icon;
    var inactive = colors.inactive;

    // other ??= background;

    background = _toDark(background, backgroundTotalDark);
    text = _toLight(text, textTotalDark);
    other = _toLight(other, otherTotalDark);

    colors.background = background;
    colors.text = text;
    colors.icon = icon;
    colors.inactive = inactive;
    colors.other = other;

    return colors;
  }

  MusicColor toDarkTheme(MusicColor colors) {
    var background = colors.background;
    var text = colors.text;
    var other = colors.other;
    var icon = colors.icon;
    var inactive = colors.inactive;

    // if ((text?.computeLuminance() ?? 0) <
    //     (background?.computeLuminance() ?? 0)) {
    //   final tempBackground = background;
    //   final tempText = text;
    //   background = tempText;
    //   text = tempBackground;
    // }

    // other ??= background;

    background = _toDark(background, backgroundDark);
    background = _toLight(background, backgroundDark);

    text = _toLight(text, textDark);

    other = _toDark(other, otherDark);

    colors.background = background;
    colors.text = text;
    colors.icon = icon;
    colors.inactive = inactive;
    colors.other = other;

    return colors;
  }
}
