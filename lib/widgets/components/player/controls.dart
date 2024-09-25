import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/buttons/next_button.dart';
import 'package:onPlay/widgets/components/player/buttons/play_button.dart';
import 'package:onPlay/widgets/components/player/buttons/previous_button.dart';

class Controls extends StatelessWidget {
  final MusicColor musicColor;
  const Controls({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    const spacing = 10.0;
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: [
        PreviousButton(
          musicColor: musicColor,
        ),
        const SizedBox(width: spacing),
        PlayButton(
          musicColor: musicColor,
        ),
        const SizedBox(width: spacing),
        NextButton(
          musicColor: musicColor,
        )
      ],
    );
  }
}
