import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/container_style.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/services/colors/color_service.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/players/background_player.dart';
import 'package:onPlay/widgets/components/player/players/card_player.dart';
import 'package:onPlay/widgets/components/player/players/lateral_player.dart';
import 'package:onPlay/widgets/components/player/players/normal_player.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({super.key});
  @override
  createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final pageController = PageController(
    initialPage: 0,
  );

  final colorService = ColorService();

  var page = 0;

  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<SongStore>(context);
    final settings = Provider.of<Settings>(context);
    final interfaceSettings = settings.interface;
    final layoutSettings = settings.layout;
    final playerStore = Provider.of<PlayerStore>(context);
    final colorScheme = Theme.of(context).colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((a) {
      if (pageController.hasClients &&
          playerStore.currentSong != null &&
          playerStore.currentSong != page) {
        pageController.jumpToPage(playerStore.currentSong!);
      }
    });

    return Stack(children: [
      PageView.builder(
          controller: pageController,
          itemCount: playerStore.playlist.length,
          onPageChanged: (value) {
            playerStore.currentSong = value;
            setState(() {
              page = value;
            });
          },
          itemBuilder: (context, index) {
            final song = playerStore.playlist[index];
            final colorStore = Provider.of<ColorStorage>(context);
            MusicColor? color;
            try {
              color = song == playerStore.playingSong
                  ? MusicColor(
                      background: colorStore.background,
                      other: colorStore.other,
                      text: colorStore.text)
                  : colorStore.colors[index];
            } catch (e) {
              color = null;
            }
            color ??= MusicColor(
                background: colorScheme.primary,
                other: colorScheme.tertiary,
                text: colorScheme.secondary);
            return interfaceSettings.pictureType == PictureType.background
                ? (layoutSettings.containerStyle == ContainerStyle.lateral
                    ? LateralPlayer(song: song, musicColor: color)
                    : layoutSettings.containerStyle == ContainerStyle.card
                        ? CardPlayer(
                            song: song,
                            musicColor: color,
                          )
                        : BackgroundPlayer(song: song, musicColor: color))
                : NormalPlayer(
                    song: song,
                    musicColor: color,
                  );
          }),
      const CurrentPlaylist()
    ]);
  }
}
