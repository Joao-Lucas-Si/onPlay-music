import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
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
            case PlayLoopMode.none:
              playerStore.mode = PlayLoopMode.replayMusic;
              break;
            case PlayLoopMode.replayMusic:
              playerStore.mode = PlayLoopMode.replayPlaylist;
              break;
            case PlayLoopMode.replayPlaylist:
              playerStore.mode = PlayLoopMode.none;
              break;
          }
        },
        icon: Icon(
          playerStore.mode == PlayLoopMode.replayPlaylist
              ? Icons.hourglass_full
              : playerStore.mode == PlayLoopMode.replayMusic
                  ? Icons.hourglass_bottom
                  : Icons.hourglass_empty,
          color: musicColor.text,
        ));
  }
}
