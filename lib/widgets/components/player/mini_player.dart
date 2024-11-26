import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/notification_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:onPlay/widgets/components/player/buttons/next_button.dart';
import 'package:onPlay/widgets/components/player/buttons/play_button.dart';
import 'package:onPlay/widgets/components/player/buttons/previous_button.dart';
import 'package:onPlay/widgets/components/player/title/loop_title.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});
  @override
  State<StatefulWidget> createState() => MiniPlayerState();
}

class MiniPlayerState extends State<MiniPlayer> {
  late SongStore store;

  @override
  Widget build(BuildContext context) {
    store = Provider.of<SongStore>(context);
    final settings = Provider.of<Settings>(context);
    final playerStore = Provider.of<PlayerStore>(context);
    final song = playerStore.playingSong!;
    final notificationService = Provider.of<NotificationService>(context);
    if (playerStore.playingSong != null) {
      notificationService.setPlayerNotification(playerStore.playingSong!);
      // WallpaperService().setWallpaper(player.playingSong!);
    } else {
      notificationService.close();
    }

    final colorScheme = Theme.of(context).colorScheme;

    final colors = playerStore.playingSong?.currentColors(context) ??
        MusicColor.create(
          palette: ColorPalette.normal,
          theme: ColorTheme.totalDark,
          background: colorScheme.primary,
          text: colorScheme.secondary,
          icon: colorScheme.secondary,
          other: colorScheme.tertiary,
          inactive: colorScheme.tertiary,
        );

    return Column(children: [
      Container(
        key: const Key("container"),
        width: MediaQuery.of(context).size.width,
        color: colorScheme.primary,
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: colors.text, borderRadius: BorderRadius.circular(10)),
              height: 15,
              width: 70,
            )),
      ),
      Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.down,
        onDismissed: (direction) {
          playerStore.playlist = [];
        },
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    playerStore.playingSong!.picture != null
                        ? Image.memory(
                            playerStore.playingSong!.picture!,
                            width: 50,
                            height: 50,
                          )
                        : const Icon(Icons.music_off, size: 50),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: LoopTitle(
                          isSmall: true,
                          musicColor: colors,
                          song: song,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PreviousButton(
                          musicColor: colors,
                        ),
                        Stack(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          fit: StackFit.loose,
                          children: [
                            CircularProgressIndicator(
                                color: colorScheme.secondary,
                                backgroundColor: colorScheme.tertiary,
                                strokeWidth: 5,
                                value: playerStore.position /
                                    (playerStore.playingSong?.duration ?? 0)),
                            PlayButton(
                              musicColor: colors,
                              isSmall: true,
                            )
                          ],
                        ),
                      ],
                    ),
                    NextButton(
                      musicColor: colors,
                    )
                  ],
                ))),
      )
    ]);
  }
}
