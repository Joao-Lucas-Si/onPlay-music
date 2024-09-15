import 'package:flutter/material.dart';

class ColorType {
  final Color color;
  final ColorGroup group;

  @override
  String toString() {
    return "$group";
  }

  const ColorType({required this.color, required this.group});
}

enum ColorGroup {
  red,
  blue,
  purple,
  green,
  orange,
  black,
  yellow,
  brown,
  white,
}

ColorGroup getColorGroup(Color color) {
  // Calcula a matiz (hue) da cor
  final hslColor = HSLColor.fromColor(color);
  final hue = hslColor.hue;
  // Define os intervalos de matiz para cada grupo de cores
  if (hue >= 285 || hue < 15) {
    return ColorGroup.red;
  } else if (hue >= 15 && hue < 45) {
    return ColorGroup.orange;
  } else if (hue >= 45 && hue < 75) {
    return ColorGroup.yellow;
  } else if (hue >= 75 && hue < 165) {
    return ColorGroup.green;
  } else if (hue >= 165 && hue < 255) {
    return ColorGroup.blue;
  } else if (hue >= 255 && hue < 285) {
    return ColorGroup.purple;
  }
  // Verifica tons de cinza e cores próximas ao preto e branco
  final luminance = hslColor.lightness;
  if (luminance > 0.95) {
    return ColorGroup.white;
  } else if (luminance < 0.05) {
    return ColorGroup.black;
  }
  // Se a cor não se encaixar em nenhum dos grupos acima, retorna marrom como padrão
  return ColorGroup.brown;
}

ColorType getColorType(Color color) {
  return ColorType(color: color, group: getColorGroup(color));
}
