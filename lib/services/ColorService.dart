import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorService {
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
