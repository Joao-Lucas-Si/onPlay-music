import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/volume/linear_volume.dart';
import 'package:onPlay/widgets/components/player/volume/volume_steps.dart';
import 'package:onPlay/widgets/components/player/volume/volune_levels.dart';
import 'package:provider/provider.dart';

class Volume extends StatelessWidget {
  final MusicColor musicColor;
  final bool vertical;
  const Volume({super.key, required this.musicColor, this.vertical = false});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    switch (layout.volumeType) {
      case VolumeType.steps:
        return VolumeSteps(
          musicColor: musicColor,
        );
      case VolumeType.slider:
        return LinearVolume(
          musicColor: musicColor,
          vertical: vertical,
        );
      case VolumeType.levels:
        return VolumeLevels(musicColor: musicColor);
      default:
        return const SizedBox.shrink();
    }
  }
}
