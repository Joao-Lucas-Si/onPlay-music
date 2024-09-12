import 'package:flutter/material.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final player = Provider.of<PlayerService>(context);
    final colorStore = Provider.of<ColorStorage>(context);
    return IconButton(
        onPressed: () {
          if (playerStore.paused) {
            player.play();
          } else {
            player.pause();
          }
        },
        icon: Icon(playerStore.paused ? Icons.pause : Icons.play_arrow,
            size: 40, color: colorStore.lightColor));
  }
}
