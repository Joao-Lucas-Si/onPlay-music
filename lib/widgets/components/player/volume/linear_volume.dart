import 'package:flutter/material.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/store/volume_store.dart';
import 'package:provider/provider.dart';

class LinearVolume extends StatelessWidget{
  final iconSize = 25.0;
  final MusicColor musicColor;
  const LinearVolume({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final volumeStore = Provider.of<VolumeStore>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Wrap(
        spacing: 1,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                volumeStore.mute();
              },
              icon: Icon(Icons.volume_off,
                  size: iconSize, color: musicColor.text)),
          SizedBox(
              width: (MediaQuery.of(context).size.width * 0.90) -
                  (30 * 2) -
                  (10 * 2) -
                  (1 * 2),
              child: Slider(
                value: volumeStore.volume,
                activeColor: musicColor.text,
                inactiveColor: musicColor.other,
                onChanged: (value) {
                  volumeStore.volume = value;
                },
              )),
          IconButton(
              onPressed: () {
                volumeStore.toMax();
              },
              icon: Icon(Icons.volume_up,
                  size: iconSize, color: musicColor.text))
        ],
      ),
    );
  }
}
