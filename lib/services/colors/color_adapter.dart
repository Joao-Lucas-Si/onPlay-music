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

  Color toLighten(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color toDarken(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  double getLigthness(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.lightness;
  }

  Color _toLight(Color color, double base) {
    final lightness = getLigthness(color);
    if (lightness < base) {
      return toLighten(color, base - lightness);
    }
    return color;
  }

  Color _toDark(Color color, double base) {
    final lightness = getLigthness(color);
    if (base < lightness) {
      color = toDarken(color, lightness - base);
    }
    return color;
  }

  MusicColor toLightTheme(MusicColor colors) {
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

  MusicColor toTotalDarkTheme(MusicColor colors) {
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
