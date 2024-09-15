import 'dart:ui';
import 'package:flutter/material.dart';
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

    // other ??= background;

    if (background != null) {
      background = _toLight(background, backgroundLight);
    }
    if (text != null) {
      text = _toDark(text, textLight);
    }
    if (other != null) {
      other = _toDark(other, otherLight);
    }

    return MusicColor(background: background, other: other, text: text);
  }

  toTotalDarkTheme(MusicColor colors) {
    var background = colors.background;
    var text = colors.text;
    var other = colors.other;

    // other ??= background;

    if (background != null) {
      background = _toDark(background, backgroundTotalDark);
    }
    if (text != null) {
      text = _toLight(text, textTotalDark);
    }
    if (other != null) {
      other = _toLight(other, otherTotalDark);
    }

    return MusicColor(background: background, other: other, text: text);
  }

  MusicColor toDarkTheme(MusicColor colors) {
    var background = colors.background;
    var text = colors.text;
    var other = colors.other;

    // if ((text?.computeLuminance() ?? 0) <
    //     (background?.computeLuminance() ?? 0)) {
    //   final tempBackground = background;
    //   final tempText = text;
    //   background = tempText;
    //   text = tempBackground;
    // }

    // other ??= background;

    if (background != null) {
      background = _toDark(background, backgroundDark);
      background = _toLight(background, backgroundDark);
      // if (!colorService.isMedium(background)) {
      //   final lightness = colorService.getLigthness(background);
      //   if (lightness < ColorService.minMediumNivel) {
      //     background = colorService.toLighten(
      //         background, ColorService.minMediumNivel - lightness);
      //   } else {
      //     background = colorService.toDarken(
      //         background, lightness - ColorService.mediumNivel);
      //   }
      // }
    }
    if (text != null) {
      text = _toLight(text, textDark);
    }
    if (other != null) {
      other = _toDark(other, otherDark);
    }
    return MusicColor(background: background, other: other, text: text);
  }
}

class MusicColor {
  final Color? background;
  final Color? text;
  final Color? other;

  const MusicColor({this.background, this.other, this.text});

  @override
  String toString() {
    return "MusicColor{background: $background, text: $text, other: $other}";
  }

  @override
  bool operator ==(Object other) {
    if (other is MusicColor) {
      return other.background == background &&
          other.text == text &&
          other.other == this.other;
    }
    return false;
  }
}
