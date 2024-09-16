import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/marquee.dart';

class LoopTitle extends StatelessWidget {
  final bool isSmall;
  final Song song;
  final MusicColor musicColor;
  const LoopTitle(
      {super.key,
      this.isSmall = false,
      required this.musicColor,
      required this.song});
  final loopDuration = const Duration(seconds: 10);
  final horizontalPadding = 15.0;
  @override
  Widget build(BuildContext context) {
    return MarqueeWidget(
        pauseDuration: const Duration(seconds: 2),
        backDuration: loopDuration,
        animationDuration: loopDuration,
        child: Padding(
            padding: EdgeInsets.only(
                left: horizontalPadding, right: horizontalPadding),
            child: Text(
              song.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: musicColor.text,
                  fontSize: isSmall ? 15 : 20),
            )));
  }
}
