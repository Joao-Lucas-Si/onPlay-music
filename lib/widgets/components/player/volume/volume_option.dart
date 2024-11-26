import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/device/volume_store.dart';
import 'package:provider/provider.dart';

class VolumeOption extends StatelessWidget {
  final MusicColor musicColor;
  const VolumeOption({
    super.key,
    required this.musicColor
  });
  final iconSize = 25.0;
  @override
  Widget build(BuildContext context) {
    final volumeStore = Provider.of<VolumeStore>(context);
    return Wrap(
      spacing: 1,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("${(volumeStore.volume * 100).floor()}%"),
        IconButton(
            onPressed: () {
              volumeStore.volume = volumeStore.volume < 0.25
                  ? 0.25
                  : (volumeStore.volume < 0.50
                      ? 0.50
                      : (volumeStore.volume < 0.7
                          ? 0.75
                          : (volumeStore.volume < 1 ? 1 : 0)));
            },
            icon: Icon(
                volumeStore.volume == 0
                    ? Icons.volume_off
                    : volumeStore.volume < 1
                        ? Icons.volume_down
                        : Icons.volume_up,
                size: iconSize,
                color: musicColor.text)),
      ],
    );
  }
}
