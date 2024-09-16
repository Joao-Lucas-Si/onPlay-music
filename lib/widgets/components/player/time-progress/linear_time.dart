import 'package:flutter/material.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/time-progress/toMinutes.dart';
import 'package:provider/provider.dart';

class LinearTime extends StatefulWidget {
  final bool vertical;
  const LinearTime(
      {super.key, required this.musicColor, this.vertical = false});
  final MusicColor musicColor;
  @override
  State<StatefulWidget> createState() {
    return _LinearTimeState();
  }
}

class _LinearTimeState extends State<LinearTime> {
  int? seconds;

  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final player = Provider.of<PlayerService>(context);
    final musicColor = widget.musicColor;
    final song = playerStore.playingSong!;
    var musicPosition = seconds != null
        ? (seconds! / (song.duration ?? 0))
        : playerStore.position / (song.duration ?? 0);

    final progress = SizedBox(
        width: MediaQuery.of(context).size.width * 0.7 - (10 * 2) - (5 * 2),
        child: Slider(
          onChangeEnd: (value) {
            final seconds =
                ((playerStore.playingSong?.duration ?? 0) * value).floor();
            player.setPosition(seconds);
            setState(() {
              this.seconds = null;
            });
          },
          onChanged: (value) {
            final seconds =
                ((playerStore.playingSong?.duration ?? 0) * value).floor();
            setState(() {
              this.seconds = seconds;
            });
          },

          inactiveColor: musicColor.other,
          activeColor: musicColor.text,
          //value: 0,
          value: musicPosition > 1 ? 0 : musicPosition,
        ));
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Wrap(
          spacing: 5,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              toMinutes(seconds != null ? seconds! : playerStore.position),
              style: TextStyle(color: musicColor.text),
            ),
            widget.vertical
                ? RotatedBox(quarterTurns: 1, child: progress)
                : progress,
            Text(toMinutes(playerStore.playingSong!.duration ?? 0),
                style: TextStyle(color: musicColor.text))
          ],
        ));
  }
}
