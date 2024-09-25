import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/title/loop_title.dart';
import 'package:provider/provider.dart';

class SongTitle extends StatelessWidget {
  final Song song;
  final MusicColor musicColor;
  const SongTitle({super.key, required this.song, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    switch (settings.interface.titleType) {
      case TitleType.loop:
        return LoopTitle(musicColor: musicColor, song: song);
      case TitleType.option:
        return SizedBox.shrink();
    }
  }
}
