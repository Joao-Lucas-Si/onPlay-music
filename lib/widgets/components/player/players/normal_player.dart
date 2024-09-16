import 'package:flutter/material.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/get_player_elements.dart';
import 'package:provider/provider.dart';

class NormalPlayer extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;
  const NormalPlayer({super.key, required this.musicColor, required this.song});

  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<SongStore>(context);
    final settings = Provider.of<Settings>(context);
    final layoutSettings = settings.layout;

    final elements = getPlayerElements(context, musicColor, song);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: musicColor.background,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...elements,
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
