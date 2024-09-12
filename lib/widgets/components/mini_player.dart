import 'package:flutter/material.dart';
import 'package:onPlay/services/NotificationsService.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/marquee.dart';
import 'package:onPlay/widgets/components/player/next_button.dart';
import 'package:onPlay/widgets/components/player/play_button.dart';
import 'package:onPlay/widgets/components/player/previous_button.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});
  @override
  State<StatefulWidget> createState() => MiniPlayerState();
}

class MiniPlayerState extends State<MiniPlayer> {
  late PlayerService player;
  late SongStore store;

  @override
  Widget build(BuildContext context) {
    final colorStore = Provider.of<ColorStorage>(context);
    store = Provider.of<SongStore>(context);
    player = Provider.of<PlayerService>(context);
    final playerStore = Provider.of<PlayerStore>(context);
    final notificationService = Provider.of<NotificationService>(context);
    if (playerStore.playingSong != null) {
      notificationService.setPlayerNotification(playerStore.playingSong!);
      // WallpaperService().setWallpaper(player.playingSong!);
    } else {
      notificationService.close();
    }

    final colorScheme = Theme.of(context).colorScheme;

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
                  color: colorStore.lightColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(10)),
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
        child: Container(
            color: colorScheme.primary,
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
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    child: MarqueeWidget(
                      direction: Axis.horizontal,
                      animationDuration: Duration(seconds: 40),
                      backDuration: Duration(microseconds: 0),
                      pauseDuration: Duration(microseconds: 1),
                      child: Text(playerStore.playingSong?.title ?? "",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 10,
                              color: colorScheme.secondary)),
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PreviousButton(),
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        CircularProgressIndicator(
                            color: colorScheme.secondary,
                            backgroundColor: colorScheme.tertiary,
                            strokeWidth: 6,
                            value: playerStore.position /
                                (playerStore.playingSong?.duration ?? 0)),
                        PlayButton()
                      ],
                    ),
                  ],
                ),
                const NextButton()
              ],
            )),
      )
    ]);
  }
}
