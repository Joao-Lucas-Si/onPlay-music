import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/get_player_elements.dart';

class BackgroundPlayer extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const BackgroundPlayer(
      {super.key, required this.song, required this.musicColor});

  @override
  Widget build(BuildContext context) {
    final elements = getPlayerElements(context, musicColor, song);

    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        song.picture != null
            ? Container(
                height: size.height,
                foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      (musicColor.background ?? Colors.black).withOpacity(0.05),
                      (musicColor.background ?? Colors.black).withOpacity(0.1),
                      (musicColor.background ?? Colors.black).withOpacity(0.9),
                      musicColor.background ?? Colors.black
                    ],
                        begin: Alignment.topCenter,
                        tileMode: TileMode.decal,
                        end: Alignment.bottomCenter)),
                child: Image.memory(
                  song.picture!,
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ))
            : Icon(
                Icons.music_off,
                size: size.height,
              ),
        Positioned.fill(
            bottom: size.height * CurrentPlaylist.minSize,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          (musicColor.background ?? Colors.black)
                              .withOpacity(0.05),
                          (musicColor.background ?? Colors.black)
                              .withOpacity(0.1),
                          (musicColor.background ?? Colors.black)
                              .withOpacity(0.9),
                          musicColor.background ?? Colors.black
                        ],
                            begin: Alignment.center,
                            tileMode: TileMode.decal,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: elements)))))
      ],
    );
  }
}
