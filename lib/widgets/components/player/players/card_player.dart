import 'package:flutter/material.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/get_player_elements.dart';
import 'package:provider/provider.dart';

class CardPlayer extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const CardPlayer({super.key, required this.song, required this.musicColor});

  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<SongStore>(context);
    final settings = Provider.of<Settings>(context);
    final layoutSettings = settings.layout;
    final playerStore = Provider.of<PlayerStore>(context);

    final elements = getPlayerElements(context, musicColor, song);
    final size = MediaQuery.sizeOf(context);
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
          height: size.height,
          width: size.width,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: musicColor.background,
                  image: playerStore.playingSong!.picture != null
                      ? DecorationImage(
                          image: MemoryImage(
                            playerStore.playingSong!.picture!,
                          ),
                          fit: BoxFit.cover)
                      : null))),
      Positioned.fill(
          bottom: size.height * (CurrentPlaylist.minSize + 0.01),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.4,
                      ),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: musicColor.background,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [...elements],
                              )))))))),
    ]);
  }
}
