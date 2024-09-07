import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/services/player_service.dart';
import 'package:myapp/store/color_store.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/player/next_button.dart';
import 'package:myapp/widgets/components/player/play_button.dart';
import 'package:myapp/widgets/components/player/previous_button.dart';
import 'package:provider/provider.dart';

class Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);
    final colorStore = Provider.of<ColorStorage>(context);
    final player = Provider.of<PlayerService>(context);
    final playerStore = Provider.of<PlayerStore>(context);

    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.down,
        onDismissed: (_) {
          GoRouter.of(context).pop();
        },
        child: Container(
          color: colorStore.info?.lightMutedColor?.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              playerStore.playingSong?.picture != null
                  ? Image.memory(playerStore.playingSong!.picture!)
                  : const Icon(Icons.music_off),
              Text(
                playerStore.playingSong?.title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: colorStore.info?.darkVibrantColor?.color,
                    fontSize: 20),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                children: [PreviousButton(), PlayButton(), NextButton()],
              ),
              LinearProgressIndicator(
                backgroundColor: colorStore.lightColor,
                value: playerStore.position / (playerStore.playingSong?.duration ?? 0),
                color: colorStore.darkColor ?? const Color(0xffffffff),
              )
            ],
          ),
        ));
  }
}
