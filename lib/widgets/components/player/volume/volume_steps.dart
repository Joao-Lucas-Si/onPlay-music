import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/volume_store.dart';
import 'package:provider/provider.dart';

class VolumeSteps extends StatelessWidget {
  final MusicColor musicColor;
  const VolumeSteps({super.key, required this.musicColor});
  final iconSize = 25.0;

  @override
  Widget build(BuildContext context) {
    final volumeStore = Provider.of<VolumeStore>(context);
    final List<double> levels = [0, 0.25, 0.5, 0.75, 1];
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Wrap(
        spacing: 5,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...levels.map(
            (level) => GestureDetector(
              onTap: () {
                volumeStore.volume = level;
              },
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: volumeStore.volume >= level - 0.2
                        ? musicColor.text
                        : musicColor.background,
                    border: Border.all(
                        width: 5, color: musicColor.text ?? Colors.white),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${level * 100}%",
                        style: TextStyle(
                          color: volumeStore.volume >= level - 0.2
                              ? musicColor.background
                              : musicColor.text,
                        ),
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
