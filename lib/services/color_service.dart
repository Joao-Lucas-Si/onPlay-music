import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorService {
  Color toDarken(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static const lightenNivel = 0.7;

  static const mediumNivel = 0.5;

  static const darkenNivel = 0.3;

  Color toLighten(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  bool isMedium(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.lightness == mediumNivel;
  }

  bool isDarken(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.lightness < darkenNivel;
  }

  bool isLighten(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.lightness > lightenNivel;
  }

  getLigthness(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.lightness;
  }

  Future<PaletteGenerator?> getDominantColor(Uint8List? imageData) async {
    if (imageData != null) {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        Image.memory(imageData).image,
      );
      return paletteGenerator;
    }
    return null;
  }
}
