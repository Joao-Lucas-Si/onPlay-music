import 'package:flutter/material.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/controls.dart';
import 'package:onPlay/widgets/components/player/images/picture.dart';
import 'package:onPlay/widgets/components/player/options/options.dart';
import 'package:onPlay/widgets/components/player/time-progress/time_progress.dart';
import 'package:onPlay/widgets/components/player/title/song_title.dart';
import 'package:onPlay/widgets/components/player/volume/volume.dart';
import 'package:provider/provider.dart';

List<Widget> getPlayerElements(BuildContext context, MusicColor musicColor, Song song) {
  final settings = Provider.of<Settings>(context);
  final layoutSettings = settings.layout;
  return layoutSettings.playerElements.map((element) {
    late Widget widget;
    switch (element) {
      case PlayerElement.picture:
        widget = Picture(musicColor: musicColor, song: song,);
        break;
      case PlayerElement.controls:
        widget = Controls(musicColor: musicColor,);
        break;
      case PlayerElement.title:
        widget = SongTitle(song: song, musicColor: musicColor,);
        break;
      case PlayerElement.options:
        widget = Options(musicColor: musicColor, song: song);
        break;
      case PlayerElement.position:
        widget = TimeProgress(musicColor: musicColor,);
        break;
      case PlayerElement.volume:
        widget = Volume(musicColor: musicColor,);
        break;
    }
    return layoutSettings.playerElements.first == element &&
            element != PlayerElement.picture
        ? SafeArea(child: widget)
        : widget;
  }).toList();
}
