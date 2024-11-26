import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/device/volume_store.dart';
import 'package:provider/provider.dart';

class VolumeLevels extends StatelessWidget {
  final MusicColor musicColor;
  const VolumeLevels({super.key, required this.musicColor});
  final iconSize = 25.0;

  @override
  Widget build(BuildContext context) {
    final volumeStore = Provider.of<VolumeStore>(context);
    final List<double> levels = [
      0,
      0.10,
      0.20,
      0.30,
      0.40,
      0.50,
      0.60,
      0.70,
      0.80,
      0.90,
      1
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Wrap(
        spacing: 5,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
              iconSize: 30,
              color: musicColor.text,
              onPressed: () {
                volumeStore.volume =
                    volumeStore.volume == 1 ? 0 : volumeStore.volume + 0.1;
              },
              icon: Icon(volumeStore.volume == 0
                  ? Icons.volume_off
                  : volumeStore.volume == 1
                      ? Icons.volume_up
                      : Icons.volume_down)),
          ...levels.map(
            (level) => GestureDetector(
                onTap: () {
                  volumeStore.volume = level;
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: volumeStore.volume >= level - 0.05
                        ? musicColor.text
                        : musicColor.background,
                    border: Border.all(
                        width: 2, color: musicColor.text ?? Colors.white),
                  ),
                  child: const SizedBox.square(
                    dimension: 21,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
