import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_palette_generator.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorService {
  late Settings settings;
  late ColorPaletteGenerator colorPaletteGenerator = ColorPaletteGenerator();

  Future<PaletteGenerator?> getColorInfo(Uint8List? imageData) async {
    if (imageData != null) {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        Image.memory(imageData).image,
      );
      return paletteGenerator;
    }
    return null;
  }

  Future<MusicColor> getMusicColorFromSong(PaletteGenerator colorInfo,
      ColorPalette palette, ColorTheme theme) async {
    final colorAdapter = ColorAdapter();
    final defaultValue = MusicColor.create(
        background: purpleTheme.background,
        text: purpleTheme.text,
        icon: purpleTheme.icon,
        other: purpleTheme.other,
        inactive: purpleTheme.inactive,
        palette: palette,
        theme: theme);

    var value = defaultValue;

    value = palette == ColorPalette.polychromatic
        ? colorPaletteGenerator.getPolychromaticPallete(colorInfo, theme)
        : palette == ColorPalette.monocromatic
            ? colorPaletteGenerator.getMonocromaticPalette(colorInfo, theme)
            : colorPaletteGenerator.getNormalPalette(colorInfo, theme);

    value = theme == ColorTheme.totalDark
        ? colorAdapter.toTotalDarkTheme(value)
        : theme == ColorTheme.dark
            ? colorAdapter.toDarkTheme(value)
            : colorAdapter.toLightTheme(value);

    return value;
  }

  Future<List<MusicColor>> getAllColorFromSong(Song song) async {
    final colors = <MusicColor>[];
    final colorInfo = await getColorInfo(song.picture);
    if (colorInfo == null && song.picture != null) {
      debugPrint("estranho isso ai");
    }
    if (colorInfo != null) {
      for (final theme in ColorTheme.values) {
        for (final palette in ColorPalette.values) {
          colors.add(await getMusicColorFromSong(colorInfo, palette, theme));
        }
      }
    }
    return colors;
  }
}
