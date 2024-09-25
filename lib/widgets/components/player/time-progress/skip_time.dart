import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/time-progress/toMinutes.dart';
import 'package:provider/provider.dart';

class SkipTime extends StatelessWidget {
  final MusicColor musicColor;
  const SkipTime({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final player = Provider.of<PlayerService>(context);

    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              if (playerStore.position > 15) {
                player.setPosition(playerStore.position - 15);
              } else {
                player.setPosition(0);
              }
            },
            icon: Icon(
              Icons.navigate_before,
              color: musicColor.text,
            )),
        Text(
          toMinutes(playerStore.position),
          style: TextStyle(color: musicColor.text),
          textAlign: TextAlign.center,
        ),
        Text(
          "/",
          style: TextStyle(color: musicColor.text, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Text(toMinutes(playerStore.playingSong?.duration ?? 0),
            style: TextStyle(color: musicColor.text),
            textAlign: TextAlign.center),
        IconButton(
            onPressed: () {
              if (playerStore.position + 15 <
                  (playerStore.playingSong?.duration ?? 0)) {
                player.setPosition(playerStore.position + 15);
              } else if (playerStore.playingSong?.duration != null) {
                player.setPosition(playerStore.playingSong!.duration!);
              }
            },
            icon: Icon(Icons.navigate_next, color: musicColor.text)),
      ],
    );
  }
}
