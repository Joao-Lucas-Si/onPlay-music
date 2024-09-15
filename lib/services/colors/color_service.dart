import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/enums/color_palette.dart';
import 'package:onPlay/enums/color_theme.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/services/colors/color_type.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class ColorService {
  var settings = Settings();

  Color toDarken(Color color, [double amount = .1]) {
    // assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static const mediumNivel = 0.35;

  static const minMediumNivel = 0.2;

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

  double getLigthness(Color color) {
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

  Future<MusicColor> getMusicColors(Uint8List? imageData,
      {BuildContext? context}) async {
    final _colorAdapter = ColorAdapter(colorService: this);
    if (context != null) {
      settings = Provider.of<Settings>(context, listen: false);
    }
    final colorTheme = settings.interface.colorTheme;
    final defaultValue = MusicColor(
        background: purpleTheme.background,
        text: purpleTheme.color,
        other: purpleTheme.other);
    var value = defaultValue;
    if (imageData != null) {
      final colorInfo = await getDominantColor(imageData);
      if (colorInfo != null) {
        value = settings.interface.colorPalette == ColorPalette.polychromatic
            ? getPolychromaticPallete(colorInfo)
            : settings.interface.colorPalette == ColorPalette.monocromatic
                ? getMonocromaticPalette(colorInfo)
                : getNormalPalette(colorInfo, colorTheme);
      }
    }

    value = colorTheme == ColorTheme.totalDark
        ? _colorAdapter.toTotalDarkTheme(value)
        : colorTheme == ColorTheme.dark
            ? _colorAdapter.toDarkTheme(value)
            : _colorAdapter.toLightTheme(value);

    return value;
  }

  MusicColor getMonocromaticPalette(PaletteGenerator colorInfo) {
    final color = colorInfo.dominantColor?.color ??
        colorInfo.vibrantColor?.color ??
        colorInfo.mutedColor?.color;

    return MusicColor(background: color, other: color, text: color);
  }

  MusicColor getPolychromaticPallete(PaletteGenerator colorInfo) {
    final colors = colorInfo.paletteColors.toList();
    List<_ColorTypeWithPopulation> types = colors
        .map((color) => _ColorTypeWithPopulation(
            type: getColorType(color.color), population: color.population))
        .toList();
    List<ColorGroup> used = [];

    Color? background, text, other;

    types.sort((i1, i2) => i1.population.compareTo(i2.population));

    types = types.reversed.toList();

    while (background == null || text == null || other == null) {
      final possibilities =
          types.where((type) => !used.contains(type.type.group));
      if (possibilities.isNotEmpty) {
        if (background == null) {
          background = possibilities.first.type.color;
        } else if (text == null) {
          text = possibilities.first.type.color;
        } else if (other == null) {
          other = possibilities.first.type.color;
        } else {
          break;
        }
        used.add(possibilities.first.type.group);
      } else {
        for (final type in types) {
          if (background == null) {
            background = type.type.color;
          } else if (text == null) {
            text = type.type.color;
          } else if (other == null) {
            other = type.type.color;
          } else {
            break;
          }
        }
      }
    }

    // debugPrint(used.toString());

    return MusicColor(background: background, other: other, text: text);
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
    Color? background;
    Color? text;
    Color? other;

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
    return MusicColor(background: background, text: text, other: other);
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
