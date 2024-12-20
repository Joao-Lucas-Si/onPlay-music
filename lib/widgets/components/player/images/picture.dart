import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/widgets/components/player/images/circular_picture.dart';
import 'package:onPlay/widgets/components/player/images/disk.dart';
import 'package:onPlay/widgets/components/player/images/gradient_picture.dart';
import 'package:onPlay/widgets/components/player/images/square_picture.dart';
import 'package:provider/provider.dart';

class Picture extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const Picture({super.key, required this.musicColor, required this.song});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final interfaceSettings = settings.interface;
    final sizes = MediaQuery.sizeOf(context);
    switch (interfaceSettings.pictureType) {
      case PictureType.circular:
        return CircularPicture(
          song: song,
        );
      case PictureType.gradient:
        return GradientPicture(
          song: song,
          musicColor: musicColor,
        );
      case PictureType.square:
        return SquarePicture(
          song: song,
        );
      case PictureType.background:
        return SizedBox(
          height: sizes.height * 0.50,
        );
      case PictureType.disk:
        return Disk(musicColor: musicColor, song: song);
    }
  }
}
