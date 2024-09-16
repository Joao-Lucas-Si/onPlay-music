import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/buttons/next_button.dart';
import 'package:onPlay/widgets/components/player/buttons/play_button.dart';
import 'package:onPlay/widgets/components/player/buttons/previous_button.dart';
import 'package:provider/provider.dart';

class Disk extends StatefulWidget {
  final MusicColor musicColor;
  final Song song;
  const Disk({super.key, required this.musicColor, required this.song});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Disk> with SingleTickerProviderStateMixin {
  late double size;
  late Song song;
  late MusicColor musicColor;
  late PlayerStore playerStore;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 10))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    size = deviceSize.width * 0.3;
    song = widget.song;
    musicColor = widget.musicColor;
    playerStore = Provider.of<PlayerStore>(context);

    return SafeArea(
        child: Stack(
      children: [
        getPictureDisk(),
        Positioned(
            right: playerStore.paused ? 10 : 80,
            top: playerStore.paused ? 20 : -5,
            child: getControl())
      ],
    ));
  }

  Widget getControl() {
    return Transform.rotate(
        angle: playerStore.paused ? 0 : 1,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: musicColor.other,
                  borderRadius: BorderRadius.circular(12)),
              height: 50,
              width: 50,
              child: PlayButton(
                musicColor: musicColor,
                isSmall: true,
              ),
            ),
            Container(
              color: musicColor.other,
              height: 125,
              width: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NextButton(
                    musicColor: musicColor,
                    isSmall: true,
                  ),
                  PreviousButton(
                    musicColor: musicColor,
                    isSmall: true,
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: musicColor.other,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(20))),
            ),
          ],
        ));
  }

  Widget getPictureDisk() {
    if (_controller.isAnimating && playerStore.paused) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: CircleAvatar(
                  backgroundImage:
                      song.picture != null ? MemoryImage(song.picture!) : null,
                  minRadius: size,
                  child: song.picture != null
                      ? null
                      : Icon(
                          Icons.music_off,
                          size: size,
                        )),
            ));
  }
}
