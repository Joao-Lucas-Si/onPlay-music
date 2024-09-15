import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_service.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class ColorStorage extends ChangeNotifier {
  Color? background;
  Color? other;
  Color? text;
  late ColorService colorService;
  PaletteGenerator? info;
  Song? song;
  List<MusicColor> colors = [];
  List<Song> playlist = [];
  BuildContext context;

  ColorStorage({required this.context}) {
    colorService = ColorService();
  }

  setColors(Song? song) {
    _setStates(song);
    notifyListeners();
  }

  update(Song? song, List<Song> playlist, BuildContext context) {
    this.context = context;
    final settings = Provider.of<Settings>(context, listen: false);

    if (settings.change) {
      settings.desableChange();
      _setAllColors();
    } else if (song != this.song) {
      this.song = song;
      setColors(song);
    } else if (!listEquals(playlist, this.playlist)) {
      this.playlist = playlist;
      _setAllColors();
    }

    return this;
  }

  _setStates(Song? song) async {
    final index = playlist
        .indexOf(song ?? Song(path: "", title: "", duration: 0, year: 0));
    if (song != null && index != -1) {
      MusicColor colorInfo;
      try {
        colorInfo = colors[index];
      } catch (e) {
        colorInfo = await _getColors(song);
      }
      background = colorInfo.background;
      other = colorInfo.other;
      text = colorInfo.text;
    } else {
      final colorInfo = await _getColors(song);
      background = colorInfo.background;
      other = colorInfo.other;
      text = colorInfo.text;
      notifyListeners();
    }
  }

  Future<MusicColor> _getColors(Song? song) async {
    final colorInfo =
        await colorService.getMusicColors(song?.picture, context: context);
    return colorInfo;
  }

  _setAllColors() async {
    colors = [];
    for (final song in playlist) {
      colors.add(await _getColors(song));
      notifyListeners();
    }
    _setStates(song);
    notifyListeners();
  }
}
