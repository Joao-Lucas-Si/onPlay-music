import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/buttons/next_button.dart';
import 'package:onPlay/widgets/components/player/buttons/play_button.dart';
import 'package:onPlay/widgets/components/player/buttons/previous_button.dart';
import 'package:onPlay/widgets/components/player/title/loop_title.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final song = playerStore.playingSong!;
    // final notificationService = Provider.of<NotificationService>(context);
    // if (playerStore.playingSong != null) {
    //   notificationService.setPlayerNotification(playerStore.playingSong!);
    //   // WallpaperService().setWallpaper(player.playingSong!);
    // } else {
    //   notificationService.close();
    // }

    final colorScheme = Theme.of(context).colorScheme;

    final colors = song.currentColors(context);

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
        key: ValueKey(song.id),
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
                    song.picture != null
                        ? Image.memory(
                            song.picture!,
                            width: 50,
                            height: 50,
                          )
                        : const Icon(Icons.music_off, size: 50),
                    Expanded(
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
                                strokeWidth: 4,
                                value: playerStore.position /
                                    (song.duration ?? 0)),
                            PlayButton(
                              musicColor: colors,
                              isSmall: true,
                            )
                          ],
                        ),
                        NextButton(
                          musicColor: colors,
                        )
                      ],
                    ),
                  ],
                ))),
      )
    ]);
  }
}
