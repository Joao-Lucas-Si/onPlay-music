import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';

class TitleOption extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const TitleOption({super.key, required this.musicColor, required this.song});
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: song.title,
      showDuration: Duration(milliseconds: 20 * song.title.length),
      child: IconButton(
          onPressed: () {
            //     final dynamic tooltip = _key.currentState;
            // tooltip.ensureTooltipVisible();
          },
          icon: Icon(
            Icons.warning_rounded,
            size: 20,
            color: musicColor.text,
          )),
    );
  }
}
