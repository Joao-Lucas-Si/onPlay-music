import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  final bool isSmall;
  final MusicColor musicColor;
  const PlayButton({super.key, this.isSmall = false, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final settings = Provider.of<Settings>(context);
    final interfaceSettings = settings.interface;

    return InkWell(
        onTap: () {
          if (playerStore.paused) {
            playerStore.player.play();
          } else {
            playerStore.player.pause();
          }
        },
        child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    interfaceSettings.controlsType == ControlsType.circleButton
                        ? musicColor.text
                        : Colors.transparent),
            child: Icon(
                playerStore.paused
                    ? Icons.pause
                    : getPlayIcon(interfaceSettings.controlsType),
                size: isSmall &&
                        interfaceSettings.controlsType ==
                            ControlsType.circleButton
                    ? 20
                    : 40,
                color:
                    interfaceSettings.controlsType == ControlsType.circleButton
                        ? musicColor.background
                        : musicColor.text)));
  }

  getPlayIcon(ControlsType controlsType) {
    switch (controlsType) {
      case ControlsType.outline:
        return Icons.play_arrow_outlined;
      case ControlsType.fill:
        return Icons.play_arrow;
      default:
        return Icons.play_arrow;
    }
  }

  getPauseIcon(ControlsType controlsType) {
    switch (controlsType) {
      case ControlsType.outline:
        return Icons.pause_presentation;
      case ControlsType.fill:
        return Icons.pause;
      default:
        return Icons.pause;
    }
  }
}
