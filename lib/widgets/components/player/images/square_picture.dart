import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';

class SquarePicture extends StatelessWidget {
  final Song song;
  const SquarePicture({super.key, required this.song});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return SafeArea(
        // padding: const EdgeInsets.only(top: 30),
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: song.picture != null
                    ? Image.memory(
                        song.picture!,
                        width: deviceSize.width * 0.9,
                        height: deviceSize.height * 0.35,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.music_note, size: deviceSize.width * 0.8))));
  }
}
