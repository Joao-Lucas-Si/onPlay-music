import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';

class CircularPicture extends StatelessWidget {
  final Song song;
  const CircularPicture({super.key, required this.song});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final size = deviceSize.width * 0.3;
    return SafeArea(
      child: CircleAvatar(
          backgroundImage:
              song.picture != null ? MemoryImage(song.picture!) : null,
          minRadius: size,
          child: song.picture != null
              ? null
              : Icon(
                  Icons.music_off,
                  size: size,
                )),
    );
  }
}
