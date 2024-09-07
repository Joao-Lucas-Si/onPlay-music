import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:myapp/dto/song.dart';
import 'package:myapp/services/ColorService.dart';
import 'package:myapp/services/player_service.dart';
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
    if (song.metadata != null) {
      final colorInfo = await colorService.getDominantColor(song.picture!);
      dominantColor = colorInfo?.dominantColor?.color;
      darkColor = colorInfo?.darkMutedColor?.color;
      lightColor = colorInfo?.lightVibrantColor?.color;
      info = colorInfo;
    }
  }
}
