import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class MusicFlow extends StatelessWidget {
  final MusicColor musicColor;
  const MusicFlow({super.key, required this.musicColor});

  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    return IconButton(
        onPressed: () {
          switch (playerStore.mode) {
            case PlayModes.none:
              playerStore.mode = PlayModes.replayMusic;
              break;
            case PlayModes.replayMusic:
              playerStore.mode = PlayModes.replayPlaylist;
              break;
            case PlayModes.replayPlaylist:
              playerStore.mode = PlayModes.none;
              break;
          }
        },
        icon: Icon(
          playerStore.mode == PlayModes.replayPlaylist
              ? Icons.hourglass_full
              : playerStore.mode == PlayModes.replayMusic
                  ? Icons.hourglass_bottom
                  : Icons.hourglass_empty,
          color: musicColor.text,
        ));
  }
}
