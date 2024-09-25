import 'package:flutter/material.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:provider/provider.dart';

class GradientPicture extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const GradientPicture(
      {super.key, required this.musicColor, required this.song});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    return song.picture != null
        ? Container(
            foregroundDecoration:
                layout.playerElements[0] == PlayerElement.picture
                    ? null
                    : BoxDecoration(
                        gradient: LinearGradient(colors: [
                        Colors.transparent,
                        musicColor.background ,
                      ], begin: Alignment.center, end: Alignment.topCenter)),
            child: Container(
                foregroundDecoration: layout.playerElements.last ==
                        PlayerElement.picture
                    ? null
                    : BoxDecoration(
                        gradient: LinearGradient(colors: [
                        Colors.transparent,
                        musicColor.background,
                      ], begin: Alignment.center, end: Alignment.bottomCenter)),
                child: Image.memory(
                  song.picture!,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                )),
          )
        : Icon(
            Icons.music_off,
            size: MediaQuery.of(context).size.height * 0.4,
          );
  }
}
