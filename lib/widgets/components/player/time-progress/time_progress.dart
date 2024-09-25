import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/progress_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/time-progress/linear_time.dart';
import 'package:onPlay/widgets/components/player/time-progress/skip_time.dart';
import 'package:provider/provider.dart';

class TimeProgress extends StatelessWidget {
  final MusicColor musicColor;
  final bool vertical;

  const TimeProgress(
      {super.key, this.vertical = false, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    switch (settings.interface.progressType) {
      case ProgressType.linear:
        return LinearTime(
          musicColor: musicColor,
          vertical: vertical,
        );
      case ProgressType.skip:
        return SkipTime(musicColor: musicColor);
      case ProgressType.disk:
        return const SizedBox.shrink();
    }
  }
}
