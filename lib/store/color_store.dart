import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:onPlay/dto/song.dart';
import 'package:onPlay/services/color_service.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorStorage extends ChangeNotifier {
  Color? dominantColor;
  Color? darkColor;
  Color? lightColor;
  final colorService = ColorService();
  PaletteGenerator? info;
  Song? song;

  setColors(Song song) {
    _setStates(song);
    notifyListeners();
  }

  update(Song? song) {
    this.song = song;
    if (song != null) setColors(song);
    return this;
  }

  _setStates(Song song) async {
    if (song.picture != null) {
      final colorInfo = await colorService.getDominantColor(song.picture!);
      dominantColor = colorInfo?.dominantColor?.color;
      darkColor =
          colorInfo?.darkMutedColor?.color ?? colorInfo?.darkMutedColor?.color;
      lightColor =
          colorInfo?.vibrantColor?.color ?? colorInfo?.mutedColor?.color;
      if (dominantColor != null) {
        if (colorService.isMedium(dominantColor!)) {
          final lightness = colorService.getLigthness(dominantColor!);
          if (lightness < ColorService.mediumNivel) {
            dominantColor = colorService.toLighten(
                dominantColor!, lightness - ColorService.mediumNivel);
          } else {
            dominantColor = colorService.toDarken(
                dominantColor!, ColorService.mediumNivel - lightness);
          }
        }
      }
      if (lightColor != null) {
        final isLighten = colorService.isLighten(lightColor!);
        if (!isLighten) {
          lightColor = colorService.toLighten(
              lightColor!,
              ColorService.lightenNivel -
                  colorService.getLigthness(lightColor!));
        }
      }
      if (darkColor != null) {
        final isDarken = colorService.isDarken(darkColor!);
        if (!isDarken) {
          darkColor = colorService.toDarken(darkColor!,
              colorService.getLigthness(darkColor!) - ColorService.darkenNivel);
        }
      }
      info = colorInfo;
    }
  }
}
