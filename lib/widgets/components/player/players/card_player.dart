import 'package:flutter/material.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/getPlayerElements.dart';
import 'package:onPlay/widgets/components/player/images/picture.dart';
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

    return DecoratedBox(
      decoration: BoxDecoration(
          color: musicColor.background,
          image: playerStore.playingSong!.picture != null
              ? DecorationImage(
                  image: MemoryImage(
                    playerStore.playingSong!.picture!,
                  ),
                  fit: BoxFit.cover)
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Picture(musicColor: musicColor, song: song,),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: musicColor.background,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: Column(
                        children: [...elements],
                      )))),
          SizedBox.fromSize(
            size: Size.fromHeight(MediaQuery.sizeOf(context).height *
                (layoutSettings.playerElements.last == PlayerElement.picture
                    ? 0.025
                    : CurrentPlaylist.minSize)),
          )
        ],
      ),
    );
  }
}
