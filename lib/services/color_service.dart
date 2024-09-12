import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorService {
  Color toDarken(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static const lightenNivel = 0.6;

  static const mediumNivel = 0.35;

  static const minMediumNivel = 0.2;

  static const darkenNivel = 0.15;

  Color toLighten(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  bool isMedium(Color color) {
    final lightness = getLigthness(color);

    return lightness <= mediumNivel && lightness >= minMediumNivel;
  }

  bool isDarken(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.lightness <= darkenNivel;
  }

  bool isLighten(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.lightness >= lightenNivel;
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
