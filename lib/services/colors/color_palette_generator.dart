import 'package:flutter/material.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_type.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorPaletteGenerator {

  

  MusicColor getMonocromaticPalette(
      PaletteGenerator colorInfo, ColorTheme theme) {
    final color = colorInfo.dominantColor?.color ??
        colorInfo.vibrantColor?.color ??
        colorInfo.mutedColor?.color ??
        purpleTheme.background;

    return MusicColor.create(
        background: color,
        icon: color,
        inactive: color,
        palette: ColorPalette.monocromatic,
        theme: theme,
        other: color,
        text: color);
  }

  MusicColor getPolychromaticPallete(
      PaletteGenerator colorInfo, ColorTheme theme) {
    final colors = colorInfo.paletteColors.toList();
    List<_ColorTypeWithPopulation> types = colors
        .map((color) => _ColorTypeWithPopulation(
            type: getColorType(color.color), population: color.population))
        .toList();
    List<ColorGroup> used = [];

    Color? background, text, icon, inactive, other;

    types.sort((i1, i2) => i1.population.compareTo(i2.population));

    types = types.reversed.toList();

    final similars = {
      ColorGroup.red: [ColorGroup.orange, ColorGroup.pink],
      ColorGroup.yellow: [ColorGroup.orange],
      ColorGroup.orange: [ColorGroup.red, ColorGroup.yellow],
      ColorGroup.pink: [ColorGroup.red, ColorGroup.purple],
      ColorGroup.purple: [ColorGroup.blue, ColorGroup.pink],
      ColorGroup.blue: [ColorGroup.purple]
    };

    while (background == null ||
        text == null ||
        other == null ||
        icon == null ||
        inactive == null) {
      // debugPrint(
      //     "grupos: ${types.map((possibility) => possibility.type.group).toSet()}");
      var possibilities = types.where((type) =>
          (![ColorGroup.white, ColorGroup.grey, ColorGroup.black]
              .contains(type.type.group)) &&
          (!used.contains(type.type.group) &&
              (!used.any((used) {
                try {
                  return similars[used]?.contains(type.type.group) ?? false;
                } catch (e) {
                  return false;
                }
              }))));
      final possibilitiesWithWhiteAndBlack =
          types.where((type) => !used.contains(type.type.group));
      final possibilitiesWithSimilars = types.where((type) =>
          (!used.contains(type.type.group)) &&
          (![ColorGroup.white, ColorGroup.grey, ColorGroup.black]
              .contains(type.type.group)));

      // debugPrint(
      //     "cores ${possibilities.map((possibility) => possibility.type.group).toSet()}");
      // debugPrint(
      //     "similar ${possibilitiesWithSimilars.map((possibility) => possibility.type.group).toSet()}");

      possibilities = possibilities.isEmpty
          ? (possibilitiesWithSimilars.isEmpty
              ? possibilitiesWithWhiteAndBlack.isEmpty
                  ? types
                  : possibilitiesWithWhiteAndBlack
              : possibilitiesWithSimilars)
          : possibilities;
      final color = possibilities.first.type.color;
      if (background == null) {
        background = color;
      } else if (text == null) {
        text = color;
      } else if (icon == null) {
        icon = color;
      } else if (inactive == null) {
        inactive = color;
      } else if (other == null) {
        other = color;
      } else {
        break;
      }
      used.add(possibilities.first.type.group);
    }

    // debugPrint(used.toString());

    return MusicColor.create(
        background: background,
        icon: icon,
        inactive: inactive,
        other: other,
        text: text,
        palette: ColorPalette.polychromatic,
        theme: theme);
  }



  MusicColor getNormalPalette(
      PaletteGenerator colorInfo, ColorTheme colorTheme) {
    final dominant = colorInfo.dominantColor?.color;
    final vibrant =
        colorInfo.vibrantColor?.color ?? colorInfo.mutedColor?.color;
    final dark =
        colorInfo.darkVibrantColor?.color ?? colorInfo.darkMutedColor?.color;
    final light =
        colorInfo.lightVibrantColor?.color ?? colorInfo.lightMutedColor?.color;
    final muted =
        colorInfo.mutedColor?.color ?? colorInfo.lightMutedColor?.color;

    Color? background, text, other, icon, inactive;

    switch (colorTheme) {
      case ColorTheme.totalDark:
        {
          background = dominant;
          text = light ?? dominant;
          other = vibrant;
        }
      case ColorTheme.dark:
        {
          background = dominant;
          text = vibrant ?? light;
          other = dark ?? dominant;
        }
      case ColorTheme.light:
        {
          background = muted ?? vibrant;
          text = dark ?? dominant;
          other = vibrant ?? dominant;
        }
    }

    background ??= purpleTheme.background;
    text ??= purpleTheme.text;
    other ??= purpleTheme.other;
    icon ??= purpleTheme.icon;
    inactive ??= purpleTheme.inactive;
    
    return MusicColor.create(
        background: background,
        theme: colorTheme,
        palette: ColorPalette.normal,
        text: text,
        inactive: inactive,
        icon: icon,
        other: other);
  }
}

class _ColorTypeWithPopulation {
  final ColorType type;
  final int population;

  @override
  String toString() {
    return "ColorTypeWithPopulation{ population: $population, colorType: $type}";
  }

  const _ColorTypeWithPopulation(
      {required this.type, required this.population});
}
