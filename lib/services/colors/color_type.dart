import 'package:flutter/material.dart';
import "package:collection/collection.dart";

class ColorType {
  final Color color;
  final ColorGroup group;

  @override
  String toString() {
    return "$group";
  }

  const ColorType({required this.color, required this.group});
}

//  if (saturation < 0.2) {
//     if (lightness >= 0.7) {
//       return ColorGroup.white;
//     } else if (lightness <= 0.3) {
//       return ColorGroup.black;
//     } else {
//       return ColorGroup.grey;
//     }
//   }

enum ColorGroup {
  pink(priority: 1, startRange: 300, endRange: 330),
  red(priority: 2, startRange: 330, endRange: 15),
  orange(priority: 3, startRange: 15, endRange: 45),
  yellow(priority: 4, startRange: 45, endRange: 75),
  green(priority: 5, startRange: 75, endRange: 150),
  blue(priority: 6, startRange: 150, endRange: 250),
  purple(priority: 7, startRange: 250, endRange: 300),
  brown(priority: 8, startRange: 15, endRange: 75),
  white(
      priority: 9,
      startRange: 0,
      endRange: 400,
      startSaturationRange: 0,
      startLightnessRange: 0.7,
      endLightnessRange: 1.1,
      endSaturationRange: 0.2),
  grey(
      priority: 10,
      startRange: 0,
      endRange: 400,
      startLightnessRange: 0.3,
      endLightnessRange: 0.7,
      startSaturationRange: 0,
      endSaturationRange: 0.2),
  black(
      priority: 11,
      startRange: 0,
      endRange: 400,
      startLightnessRange: 0,
      endLightnessRange: 0.3,
      startSaturationRange: 0,
      endSaturationRange: 0.2);

  final int priority;
  final double startRange;
  final double endRange;

  final double startLightnessRange;
  final double endLightnessRange;

  final double startSaturationRange;
  final double endSaturationRange;

  static ColorGroup? getByRange(
          double hue, double lightness, double saturation) =>
      ColorGroup.values.firstWhereOrNull((color) =>
          (hue >= color.startRange && hue < color.endRange) &&
          (lightness >= color.startLightnessRange &&
              lightness < color.endLightnessRange) &&
          (saturation >= color.startSaturationRange &&
              saturation < color.endSaturationRange));

  const ColorGroup(
      {required this.priority,
      required this.endRange,
      required this.startRange,
      this.startLightnessRange = 0,
      this.endLightnessRange = 1.1,
      this.startSaturationRange = 0.2,
      this.endSaturationRange = 1.1});
}

ColorGroup getColorGroup(Color color) {
  // Calcula a matiz (hue) da cor
  final hslColor = HSLColor.fromColor(color);
  final hue = hslColor.hue;
  final saturation = hslColor.saturation;
  final lightness = hslColor.lightness;

  final colorGroup = ColorGroup.getByRange(hue, lightness, saturation);

  if (colorGroup != null) return colorGroup;

  if (hue >= 330 || hue < 15) {
    return ColorGroup.red;
  }

  return ColorGroup.brown;
}

ColorType getColorType(Color color) {
  return ColorType(color: color, group: getColorGroup(color));
}
