import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/services/NotificationsService.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/services/WallpaperService.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/player/next_button.dart';
import 'package:onPlay/widgets/components/player/play_button.dart';
import 'package:onPlay/widgets/components/player/previous_button.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
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
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
              height: 10,
              width: 60,
              color: colorStore.lightColor ?? Colors.white)),
      Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.down,
        onDismissed: (direction) {
          playerStore.playlist = [];
        },
        child: Container(
            color: const Color(0XFF000000),
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
                Flexible(
                    child: Container(
                  // fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width / 0.5,
                  child: Text(
                    overflow: TextOverflow.clip,
                    playerStore.playingSong?.title ?? "",
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 10,
                        color: Color(0xFFFFFFFF)),
                  ),
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
                            color: colorStore.lightColor ??
                                const Color(0xffc0c0c0),
                            backgroundColor:
                                colorStore.darkColor ?? const Color(0xFFFFFFFF),
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
